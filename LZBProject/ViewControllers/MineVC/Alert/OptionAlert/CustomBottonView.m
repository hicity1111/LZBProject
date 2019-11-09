//
//  CustomBottonView.m
//  LZBProject
//
//  Created by hicity on 2019/11/9.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "CustomBottonView.h"

#define buttonHeight 28

@interface CustomBottonView ()

@property (nonatomic, strong) JMBaseButton *selectButton;
@end

@implementation CustomBottonView

- (void)setTitleArr:(NSArray *)titleArr{
    _titleArr = titleArr;
    if (_rowNum.length == 0) {
        _rowNum = @"2";
    }
    if (self.backColor == nil||self.backColor==NULL) {
        self.backColor = [UIColor whiteColor];
    }
    if (self.selectColor == nil||self.selectColor==NULL) {
        self.selectColor = [UIColor colorWithHex:@"#CCF0E5"];
    }
    if (self.nomorlColor == nil||self.nomorlColor==NULL) {
        self.nomorlColor = [UIColor colorWithHexString:@"#F5F5F5"];
    }
    if (self.nomorlTitleColor == nil||self.nomorlTitleColor==NULL) {
        self.nomorlTitleColor = [UIColor colorWithHex:@"#666666"];
    }
    if (self.selectTitleColor == nil||self.selectTitleColor==NULL) {
        self.selectTitleColor = [UIColor colorWithHex:@"#00985B"];
    }
    if (self.fontSize == nil||self.fontSize==NULL) {
        self.fontSize = [UIFont systemFontOfSize:14*kWidthScale];
    }
    if (self.MarginX == 0) {
        self.MarginX = 10*kWidthScale;
    }
    if (self.MarginY == 0) {
        self.MarginY = 10*kWidthScale;
    }
    
    CGFloat buttonWidth = (self.frame.size.width - ([_rowNum intValue] + 1) * self.MarginX)/[_rowNum intValue];

    [_titleArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSInteger row = idx/[self.rowNum intValue];
        NSInteger loc = idx%[self.rowNum intValue];
        
        CGFloat x = (buttonWidth)  * loc + self.MarginX * (loc + 1);
        CGFloat y = (buttonHeight*kWidthScale) * row + self.MarginY * (row + 1);
        
        JMBaseButton *button = [JMBaseButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:button];
        
        button.frame = CGRectMake(x, y, buttonWidth, buttonHeight*kWidthScale);
        button.backgroundColor = self.nomorlColor;
        [button setTitleColor:self.nomorlTitleColor forState:(UIControlStateNormal)];
        button.titleLabel.font = self.fontSize;
        [button setTitle:titleArr[idx] forState:UIControlStateNormal];
        button.tag = idx;
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:[UIImage imageNamed:@"nomorl"] forState:(UIControlStateNormal)];
        button.layer.cornerRadius = self.cornerRadiu;
        
        if (_selectIndex.length == 0) {
            
        }else {
            //设置默认选中项
            if (button.tag == [_selectIndex intValue]) {
                button.backgroundColor = self.selectColor;
                [button setTitleColor:self.selectTitleColor forState:(UIControlStateNormal)];
                [button setImage:[UIImage imageNamed:@"select"] forState:(UIControlStateNormal)];
                button.selected = YES;
                self.selectButton = button;
                [self.selectedMarkArray addObject:[NSString stringWithFormat:@"%@",_selectIndex]];
            }else {
                
            }
        }

    }];
    
    CGRect rectSize = self.frame;
    
    if ([titleArr isKindOfClass:[NSArray class]]&&titleArr.count!=0) {
        NSInteger rows = titleArr.count / [_rowNum intValue];
        NSInteger loc = titleArr.count%[self.rowNum intValue];
        if (titleArr.count) {
            if ( titleArr.count % [_rowNum intValue]!=0) {
                rows += 1;
            }
            rectSize.size.height +=  rows * buttonHeight*kWidthScale  + (loc+2) * 10*kWidthScale; // 图片高度 + 间隙
        }
    }
    self.frame = rectSize;
    self.backgroundColor = KMAINFFFF;
    
}

// 单选 在点击事件中，以一个static变量记录instance
- (void)btnClick:(JMBaseButton *)sender {
    if (_isMuli == YES) {
        //多选
        sender.selected = !sender.selected;
        if (sender.isSelected) {
            sender.backgroundColor = self.selectColor;
            [sender setTitleColor:self.selectTitleColor forState:(UIControlStateNormal)];
            [sender setImage:[UIImage imageNamed:@"select"] forState:(UIControlStateNormal)];
            
            [self.selectedMarkArray addObject:[NSString stringWithFormat:@"%ld",sender.tag]];
        } else {
            sender.backgroundColor = self.nomorlColor;
            [sender setTitleColor:self.nomorlTitleColor forState:(UIControlStateNormal)];
            [sender setImage:[UIImage imageNamed:@"nomorl"] forState:(UIControlStateNormal)];
            
            [self.selectedMarkArray removeObject:[NSString stringWithFormat:@"%ld",sender.tag]];
            
        }
        
    }else {
        //单选
        //self.selectBtn上个按钮，也为临时按钮
        //这里为设置按钮的字体颜色，如果不需要改变按钮的背景颜色，即只需要改变selected的值，不需要再判断临时按钮和当前按钮是否一样
        self.selectButton.selected = NO;
        sender.selected=YES;
        //这里为设置按钮的背景颜色
        if (self.selectButton == sender) {
            
        }else{
            sender.backgroundColor = self.selectColor;
            [sender setTitleColor:self.selectTitleColor forState:(UIControlStateNormal)];
            
            self.selectButton.backgroundColor = self.nomorlColor;
            [self.selectButton setTitleColor:self.nomorlTitleColor forState:(UIControlStateNormal)];
            
        }
        self.selectButton = sender;
        // 判断下这个block在控制其中有没有被实现
        
    }
    if (self.buttonAction) {
        // 调用block传入参数
        self.buttonAction(self.selectButton);
    }
}
- (NSMutableArray *)selectedMarkArray {
    if (!_selectedMarkArray) {
        _selectedMarkArray = [NSMutableArray array];
        
    }
    return _selectedMarkArray;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
