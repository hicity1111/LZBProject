//
//  HomeModel.h
//  LZBProject
//
//  Created by hicity on 2019/11/4.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "LZBAPIResponseBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeModel : LZBAPIResponseBaseModel

/// 作业截止时间/资源分享时间
@property (nonatomic, copy) NSNumber *homeworkEndtime;
///资源名称
@property (nonatomic, copy) NSString * resourceName;
/// 视频路径
@property (nonatomic, copy) NSString * resourcePath;
/// 资源类型1:视频，2：音频，3：图片
@property (nonatomic, assign) NSInteger resourceType;
/// 学生ID
@property (nonatomic, assign) NSInteger studentInfoId;
/// 章节
@property (nonatomic, copy) NSString * subjectName;
/// 资源章节    
@property (nonatomic, copy) NSString * textbookChapterName;

/// 判断课本类型
@property (nonatomic, copy) NSString *subjectAbbreviation;

/// 作业id
@property (nonatomic, copy) NSNumber *homeworkId;

/// 是否互批
@property (nonatomic, assign) NSInteger homeworkIshp;

/// 作业名称
@property (nonatomic, copy) NSString *homeworkName;

/// 作业开始时间
@property (nonatomic, copy) NSNumber *homeworkStarttime;

/// 学生ID
@property (nonatomic, copy) NSNumber *homeworkStudentId;

/// 1：普通作业 2：错题作业 3：听说作业 4：单词作业 5:阅读训练 6作文任务
@property (nonatomic, copy) NSNumber *homeworkType;

/// 作业题数
@property (nonatomic, copy) NSNumber *questionNumber;

/// 学生完成题数
@property (nonatomic, copy) NSNumber *studentDoneQuestionNum;

/// 作业状态 1：未答 2：未完成 3：已完成
@property (nonatomic, copy) NSNumber *submitType;



@end

NS_ASSUME_NONNULL_END
