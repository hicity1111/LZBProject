//
//  LYZCurrentVCHelper.h
//  LZBProject
//
//  Created by 刘义增 on 2019/11/1.
//  Copyright © 2019 hicity. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYZCurrentVCHelper : NSObject

+ (UIViewController *)getCurrentVC;

+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC;

@end

NS_ASSUME_NONNULL_END
