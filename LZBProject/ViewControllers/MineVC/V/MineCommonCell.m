//
//  MineCommonCell.m
//  LZBProject
//
//  Created by 刘义增 on 2019/10/30.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "MineCommonCell.h"
#import "LYZCleanCache.h"
#import "LYZSandBoxPath.h"
#import "LYZCurrentVCHelper.h"
#import "LZBAlertViewController.h"

@interface MineCommonCell ()

@property (weak, nonatomic) IBOutlet UILabel *leftLb;

@end

@implementation MineCommonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    
    if (highlighted) {
        self.backgroundColor = TABLECELL_HIGHLIGHTED_COLOR;
    } else {
        self.backgroundColor = WHITECOLOR;
    }
}

#pragma mark -

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self adjustMyFram];
}

- (void)adjustMyFram {
    CGFloat leftMargin = 15.f;
    self.frame = CGRectMake(leftMargin, self.top, kScreenWidth - 2 * leftMargin, self.height);
    
    if (self.cellIndex == 0) {
        [self setRoundedCorners: LYZRectCornerTop
        withRadius: 15.f];
    } else {
        [self noCornerRadius];
    }
}

- (void)setCellIndex:(NSInteger)cellIndex {
    _cellIndex = cellIndex;
        
    switch (cellIndex) {
        case 0: {
            self.leftLb.text = @"手机号";
            self.rightLb.text = @"未绑定";
            break;
        }
        case 1: {
            self.leftLb.text = @"清除缓存";
            self.rightLb.text = @"0M";
            break;
        }
        case 2: {
            self.leftLb.text = @"用户协议";
            self.rightLb.text = @"";
            break;
        }
        case 3: {
            self.leftLb.text = @"版本号";
            self.rightLb.text = @"v1.0.0";
            break;
        }
        case 4: {
            self.leftLb.text = @"客服电话";
            self.rightLb.text = @"400-016-2123";
            break;
        }
        default:
            break;
    }
}

#pragma mark - Custom Method

- (void)selectedCellWithIndex:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        // 绑定手机号
        case 0: {
            [self bindPhoneNumber];
            break;
        }
        // 清除缓存
        case 1: {
            [self cleanCache];
            break;
        }
        // 用户协议
        case 2: {
            [self seeUserProtocol];
            break;
        }
        // 版本更新
        case 3: {
            [self requestVersionUpdate];
            break;
        }
        // 客服电话
        case 4: {
            [self callCustomerService];
            break;
        }
        default:
            break;
    }
}

/// 绑定手机号
- (void)bindPhoneNumber {
    
}

/// 清除缓存
- (void)cleanCache {
    LYZCleanCache *manager = [LYZCleanCache sharedCleanManager];
    NSString *cacheFolder = [LYZSandBoxPath path4Tmp];
    CGFloat folderSize = [manager folderSizeAtPath:cacheFolder];
//    [manager cleanFoldersWithPath:cacheFolder];
    
    NSString *message = [NSString stringWithFormat:@"共清理了 %.2f M", folderSize];
    [manager tokenAnimationWithView:[UIApplication sharedApplication].keyWindow
                            message:message];
}

/// 用户协议
- (void)seeUserProtocol {
    
}

/// 版本号
- (void)requestVersionUpdate {
    [self alertWithTitle:@"更新版本" message:@"有新版本啦，是否去AppStore更新？" sureButtonText:@"确定" cancelButtonText:@"取消" sureActionBlock:^(UIAlertAction *action) {
        
    } cancelActionBlock:nil];
}

/// 打客服电话
- (void)callCustomerService {
    NSString *number = self.rightLb.text;
    NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"tel:%@", number];
    NSURL *url = [NSURL URLWithString:str];
    UIApplication *application = [UIApplication sharedApplication];
    [application openURL:url options:@{} completionHandler:^(BOOL success) {
        //OpenSuccess=选择 呼叫 为 1  选择 取消 为0
        NSLog(@"OpenSuccess=%d", success);
    }];
}

- (void)alertWithTitle:(NSString *)title
               message:(NSString *)msg
        sureButtonText:(NSString *)sureText
      cancelButtonText:(NSString *)cancelText
       sureActionBlock:(void (^)(UIAlertAction *action))sureBlock
     cancelActionBlock:(void (^)(UIAlertAction *action))cancelBlock {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:sureText style:UIAlertActionStyleDefault handler:sureBlock];
    [alert addAction:sureAction];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelText style:UIAlertActionStyleCancel handler:cancelBlock];
    [alert addAction:cancelAction];
    
    [[LYZCurrentVCHelper getCurrentVC] presentViewController:alert animated:YES completion:^{
        
    }];
}

@end
