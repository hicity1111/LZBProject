//
//  UIViewController+HUD.h
//  中格仓储
//
//  Created by 大橙子 on 2018/6/1.
//  Copyright © 2018年 中都格罗唯视. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^completionBlock)(void);
@interface UIViewController (HUD)

-(void)showSuccess:(NSString *)success;
-(void)showError:(NSString *)error;
-(void)showMessage:(NSString *)message afterDelay:(NSTimeInterval)timer;
-(void)showMessage:(NSString *)message afterDelay:(NSTimeInterval)timer completion:(completionBlock)completion;
-(void)showWaiting;
-(void)showLoading;
-(void)showLoadingWithMessage:(NSString *)message;
-(void)showSaving;
-(void)hideHUD;
@end
