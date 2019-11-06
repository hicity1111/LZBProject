//
//  QRCodeAlertManager.h
//  LZBProject
//
//  Created by 刘义增 on 2019/11/1.
//  Copyright © 2019 hicity. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QRCodeConfig : NSObject

@property (nonatomic, strong) UIImage *avatarImg;

@property (nonatomic, strong) NSString *studentName;

@property (nonatomic, assign) LZBStudentSex sex;

@property (nonatomic, strong) NSString *schoolName;

@property (nonatomic, strong) NSString *className;


@property (nonatomic, strong) NSString *studentId;
@property (nonatomic, strong) NSString *gradeClassId;

@end



@interface QRCodeAlertView : UIView


@property (nonatomic, strong) QRCodeConfig *config;

@property (nonatomic, copy) void (^didHide)(void);

//+ (instancetype)sharedManager;

- (void)showAlert;

- (void)hideAlert;


@end

NS_ASSUME_NONNULL_END
