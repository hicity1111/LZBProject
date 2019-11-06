//
//  NotifyListEntry.h
//  LZBProject
//
//  Created by liyan on 2019/11/1.
//  Copyright © 2019 hicity. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NotifyListEntry : NSObject

///作业id
@property (nonatomic, copy) NSString *homeworkId;
///消息id
@property (nonatomic, copy) NSString *noticeId;
///是否已读
@property (nonatomic, assign) BOOL isRead;
///通知标题
@property (nonatomic, copy) NSString *noticeTitle;
///通知内容
@property (nonatomic, copy) NSString *noticeContent;
///发布人id
@property (nonatomic, copy) NSString *noticeSendid;
///发布人姓名
@property (nonatomic, copy) NSString *noticeSendname;
///发布时间
@property (nonatomic, copy) NSString *noticeSendtime;
///发布对象 （1：老师，2：学生，3：老师和学生）
@property (nonatomic, assign) NSInteger noticeObject;
///通知类型     通知类型（1：系统，2：作业提醒（半小时），3：改错提醒,4：班级通知，5发布作业。6作业撤回 9重批申请10重批处理完成11未提交作业提醒
@property (nonatomic, assign) NSInteger noticeType;
///消息图片地址
@property (nonatomic, strong) NSArray *noticeImagesUrl;
///科目
@property (nonnull, copy) NSString *subjectAbbreviation;

///MARK:- 自定义字段
//高度缓存
@property (nonatomic, assign) CGFloat cellHeight;
//是否选中状态 默认false 非选中状态
@property (nonatomic, assign) BOOL isSelected;
///自定义contentStr
@property (nonatomic, copy) NSString *contentStr;

@end

NS_ASSUME_NONNULL_END
