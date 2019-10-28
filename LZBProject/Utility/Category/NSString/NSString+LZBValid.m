//
//  NSString+LZBValid.m
//  LZBProject
//
//  Created by hicity on 2019/10/23.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "NSString+LZBValid.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>


@implementation NSString (LZBValid)

/// 有效的手机号码
+ (BOOL)mh_isValidMobile:(NSString *)str
{
    NSString *phoneRegex = @"^1[3456789]\\d{9}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:str];
}

- (BOOL)isNotEmpty {
    if (!self) return YES;
    NSCharacterSet *blank = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    for (NSInteger i = 0; i < self.length; ++i) {
        unichar c = [self characterAtIndex:i];
        if (![blank characterIsMember:c]) {
            return YES;
        }
    }
    return NO;
}

+ (BOOL)lzb_checkStringIsEmpty:(NSString *)inputString {
    NSString *string = inputString;
    if([string isKindOfClass:[NSNull class]]){
        return YES;
    }
    if (string == nil) {
        return YES;
    }
    if ([string isEqualToString:@"(null)"]) {
        return YES;
    }
    NSString *text = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([text length] == 0) {
        return YES;
    }
    return NO;
}

+ (NSString *)lzb_MD5:(NSString *) inputString{
    const char *cStr = [inputString UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest ); // This is the md5 call
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return  output;
}

+ (NSString *)lzb_getDateUTCTime{
    char date_str[21] = {0};
    time_t t = time(NULL)-28800;  // UTC秒数
    struct tm *tp = localtime(&t);
    sprintf(date_str, "%04d", tp->tm_year+1900);
    sprintf(date_str+4, "%s", "-");
    sprintf(date_str+5, "%02d", tp->tm_mon+1);
    sprintf(date_str+7, "%s", "-");
    sprintf(date_str+8, "%02d", tp->tm_mday);
    sprintf(date_str+10, "%s", "T");
    sprintf(date_str+11, "%02d", tp->tm_hour);
    sprintf(date_str+13, "%s", ":");
    sprintf(date_str+14, "%02d", tp->tm_min);
    sprintf(date_str+16, "%s", ":");
    sprintf(date_str+17, "%02d", tp->tm_sec);
    sprintf(date_str+19, "%s", "Z");
    NSString *output = [NSString stringWithFormat:@"%s",date_str];
    return output;
}

+(BOOL)detectionIsPasswordQualified:(NSString *)patternStr{

    NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:patternStr];
    return isMatch;

}
@end
