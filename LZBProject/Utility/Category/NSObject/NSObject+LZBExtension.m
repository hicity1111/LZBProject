//
//  NSObject+LZBExtension.m
//  LZBProject
//
//  Created by liyan on 2019/11/5.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "NSObject+LZBExtension.h"


@implementation NSObject (LZBExtension)



+ (void)mt_showAlertWithTitle:(NSString *)title
                      message:(NSString *)message
                 confirmTitle:(NSString *)confirmTitle
                  cancleTitle:(NSString *)cancelTitle
                confirmAction:(void(^)(void))confirmAction
                 cancleAction:(void(^)(void))cancelAction {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    /// 左边按钮
    if(cancelTitle.length > 0){
        UIAlertAction *cancel= [UIAlertAction actionWithTitle:cancelTitle?cancelTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { !cancelAction?:cancelAction(); }];
        [alertController addAction:cancel];
    }
    
    
    if (confirmTitle.length > 0) {
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:confirmTitle?confirmTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { !confirmAction?:confirmAction();}];
        [alertController addAction:confirm];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSObject mt_currentViewController] presentViewController:alertController animated:YES completion:NULL];
    });
}




/**  找到当前试图控制器 */
+ (UIViewController *)mt_currentViewController {
    
    UIViewController *viewController = [[UIApplication sharedApplication].delegate window].rootViewController;
    return [self findBestViewController:viewController];
}


#pragma mark --- private API
//遍历查找当前视图控制器
+ (UIViewController *)findBestViewController:(UIViewController *)vc
{
    if (vc.presentedViewController) {
        
        return [self findBestViewController:vc.presentedViewController];
        
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        
        UINavigationController* svc = (UINavigationController*) vc;
        if (svc.viewControllers.count > 0) {
            return [self findBestViewController:svc.topViewController];
        } else {
            return vc;
        }
        
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        
        UITabBarController* svc = (UITabBarController *)vc;
        if (svc.viewControllers.count > 0) {
            return [self findBestViewController:svc.selectedViewController];
        } else {
            return vc;
        }
        
    } else {
        return vc;
    }
}


@end
