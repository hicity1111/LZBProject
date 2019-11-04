//
//  UserModel.h
//  LZBProject
//
//  Created by hicity on 2019/11/1.
//  Copyright © 2019 hicity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZBAPIResponseBaseModel.h"
#import "UserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserModel : LZBAPIResponseBaseModel

@property (nonatomic, strong) UserModel *infos;

/// 班级名称
@property (nonatomic, copy) NSString *className;

/// 班级
@property (nonatomic, copy) NSString *grade;

/// 班级ID
@property (nonatomic, copy) NSNumber *gradeClassId;

/// 学校ID
@property (nonatomic, copy) NSNumber *schoolId;

/// 学校名称
@property (nonatomic, copy) NSString *schoolName;

@property (nonatomic, copy) NSString *section;

/// 学生学籍号
@property (nonatomic, copy) NSString *studentCode;

/// 学生考号
@property (nonatomic, copy) NSString *studentExaminationnume;

/// 学生ID
@property (nonatomic, copy) NSNumber *studentInfoId;

/// 学生登录时间
@property (nonatomic, copy) NSString *studentLogintime;

/// 学生名字
@property (nonatomic, copy) NSString *studentName;

/// 学生手机号
@property (nonatomic, copy) NSString *studentPhone;

/// 学生性别
@property (nonatomic, copy) NSNumber *studentSex;

/// token
@property (nonatomic, copy) NSString *token;
@end

NS_ASSUME_NONNULL_END
