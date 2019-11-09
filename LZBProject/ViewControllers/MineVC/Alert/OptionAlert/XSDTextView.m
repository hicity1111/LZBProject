//
//  XSDTextView.m
//  BJJTADL.XSD
//
//  Created by hicity on 2018/12/6.
//  Copyright © 2018年 BJJTADL. All rights reserved.
//

#import "XSDTextView.h"
@interface XSDTextView ()<UITextViewDelegate,UITextFieldDelegate>
@end

@implementation XSDTextView

@synthesize placeHolderLabel;
@synthesize placeholder;
@synthesize placeholderColor;

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    placeHolderLabel = nil;
    placeholderColor = nil;
    placeholder = nil;

}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setPlaceholder:@""];
    [self setPlaceholderColor:[UIColor lightGrayColor]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
}

- (id)initWithFrame:(CGRect)frame
{
    if( (self = [super initWithFrame:frame]) )
    {
        [self setPlaceholder:@""];
        [self setPlaceholderColor:[UIColor lightGrayColor]];
        self.delegate = self;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)textChanged:(NSNotification *)notification
{
    if([[self placeholder] length] == 0)
    {
        return;
    }
    
    if([[self text] length] == 0)
    {
        [[self viewWithTag:999] setAlpha:1];
    }
    else
    {
        [[self viewWithTag:999] setAlpha:0];
    }
}

- (void)setText:(NSString *)text {
    [super setText:text];
    [self textChanged:[NSNotification new]];
}

- (void)drawRect:(CGRect)rect
{
    if( [[self placeholder] length] > 0 )
    {
        if ( placeHolderLabel == nil )
        {
            placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(14,12,self.bounds.size.width - 16,0)];
            placeHolderLabel.lineBreakMode = UILineBreakModeWordWrap;
            placeHolderLabel.numberOfLines = 0;
            placeHolderLabel.font = self.font;
            placeHolderLabel.backgroundColor = [UIColor clearColor];
            placeHolderLabel.textColor = self.placeholderColor;
            placeHolderLabel.alpha = 0;
            placeHolderLabel.tag = 999;
            [self addSubview:placeHolderLabel];
        }
        
        placeHolderLabel.text = self.placeholder;
        [placeHolderLabel sizeToFit];
        [self sendSubviewToBack:placeHolderLabel];
    }
    
    if( [[self text] length] == 0 && [[self placeholder] length] > 0 )
    {
        [[self viewWithTag:999] setAlpha:1];
    }
    
    [super drawRect:rect];
}


//首先实现UITextView的禁止输入表情符号代码
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    
    if ([textView isFirstResponder]) {
        //判断键盘是不是九宫格键盘
        if ([self isNineKeyBoard:text] ){
             return YES;
        }else{
            if ([self hasEmoji:text] || [self stringContainsEmoji:text]){
//                [[self getCurrentVC] showError:@"禁止输入表情"];
                return NO;
            }
        }
        if ([[[textView textInputMode] primaryLanguage] isEqualToString:@"emoji"] || ![[textView textInputMode] primaryLanguage]) {
//            [[self getCurrentVC] showError:@"禁止输入表情"];
            return NO;
        }
    }

//    if ([text isEqualToString:@"\n"]) {
//        [textView resignFirstResponder];
//        return NO;
//    }
    return YES;
}

/**
 * 判断字符串中是否存在emoji
 * @param string 字符串
 * @return YES(含有表情)
 */
- (BOOL)stringContainsEmoji:(NSString *)string {
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        
        const unichar hs = [substring characterAtIndex:0];
        // surrogate pair
        if (0xd800 <= hs && hs <= 0xdbff) {
            returnValue = YES;
            if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                NSLog(@"=========%d",uc);
                
                if (0x1d000 <= uc && uc <= 0x1f985) {
                    returnValue = YES;
                }
            }
         }else if (substring.length > 1) {
             returnValue = YES;
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 returnValue = YES;
             }
             if (ls == 0xfe0f) {
                 returnValue = YES;
             }
             NSLog(@"ls  ====== %hu",ls);
         }else{
             // non surrogate
             if (0x2100 <= hs && hs <= 0x27ff) {
                 returnValue = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 returnValue = YES;
             }else if (0x2934 <= hs && hs <= 0x2935){
                 returnValue = YES;
             }else if (0x3297 <= hs && hs <= 0x3299) {
                 returnValue = YES;
             }else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                 returnValue = YES;
             }
         }
    }];
    return returnValue;
}

/**
 *  判断字符串中是否存在emoji
 * @param string 字符串
 * @return YES(含有表情)
 */
- (BOOL)hasEmoji:(NSString*)string{
    NSString *pattern = @"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:string];
    return isMatch;
}

//去除字符串中所带的表情
- (NSString *)disable_emoji:(NSString *)text{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]"options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text options:0 range:NSMakeRange(0, [text length]) withTemplate:@""];
    return modifiedString;
}

/**
 判断是不是九宫格
 @param string  输入的字符
 @return YES(是九宫格拼音键盘)
 */
-(BOOL)isNineKeyBoard:(NSString *)string{
    NSString *other = @"➋➌➍➎➏➐➑➒";
    int len = (int)string.length;
    for (int i = 0; i < len; i++) {
        if (!([other rangeOfString:string].location != NSNotFound)) {
            return NO;
        }
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView{
    
    [self textChanged:[NSNotification new]];
    if (textView.text.length > 0 && [self stringContainsEmoji:textView.text]) {
//        [[self getCurrentVC] showError:@"禁止输入表情"];    // 提示框
        NSLog(@"有表情");
        // 禁止系统表情的输入
        NSString *text = [self disable_emoji:[textView text]];
        if (![text isEqualToString:textView.text]) {
            NSRange textRange = [textView selectedRange];
            textView.text = text;
            [textView setSelectedRange:textRange];
        }
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if ([self stringContainsEmoji:textView.text]) {
//        [[self getCurrentVC] showError:@"禁止输入表情,请重新输入"];
        NSLog(@"有表情");
    }
}

//然后实现UITextField的禁止输入表情符号代码
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([self stringContainsEmoji:textField.text]) {
//        [[self getCurrentVC] showError:@"禁止输入表情,请重新输入"];
        NSLog(@"有表情");
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
     if ([textField isFirstResponder]) {
         //判断键盘是不是九宫格键盘
        if ([self isNineKeyBoard:string] ){
            return YES;
        }else{
            if ([self hasEmoji:string] || [self stringContainsEmoji:string]) {
//                [[self getCurrentVC] showError:@"不知道是啥"];
                return NO;
            }
        }
//         if ([string isEqualToString:@"\n"]) {
//             [textField resignFirstResponder];
//             return NO;
//         }
     }
    
    return YES;
    
    return YES;
}

- (void)textFieldDidChange:(UITextField *)TextField
{
    if (TextField.text.length > 0 && [self stringContainsEmoji:TextField.text]) {
//        [[self getCurrentVC] showError:@"禁止输入表情"];
        NSLog(@"有表情");
        // 禁止系统表情的输入
        NSString *text = [self disable_emoji:[TextField text]];
        TextField.text = text;
        
    }
}
@end

