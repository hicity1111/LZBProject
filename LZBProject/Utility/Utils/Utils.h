//
//  Utils.h
//  LZBProject
//
//  Created by hicity on 2019/10/23.
//  Copyright © 2019 hicity. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface Utils : NSObject

+ (instancetype)sharedInstance;
/**
 *  保存当前用户Token
 */
+(void)saveUserToken:(NSString*)token;
/**
 *  加载前用户Token
 */
+(NSString*)loadUserToken;
@end

NS_ASSUME_NONNULL_END
