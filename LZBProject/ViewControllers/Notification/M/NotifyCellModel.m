//
//  NotifyCellModel.m
//  LZBProject
//
//  Created by 刘义增 on 2019/10/31.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "NotifyCellModel.h"

@implementation NotifyCellModel

- (instancetype)transToModelWithDict:(NSDictionary *)dict {
    NotifyCellModel *model = [[NotifyCellModel alloc] init];
    
    model.tags = @[@"", @"", @""];
    model.timeStr = @"10/17 23:27";
    model.title = @"这里是系统消息的名字，最多显示两行，后台限制字数30个汉字以内。";
    model.desc = @"这里是系统消息内容，有多少显示多少。不同的消息类页、web页等。需要跳转时，点击查看按钮。";
    model.imgArr = @[];
    
    NSMutableArray *imgArr = [NSMutableArray array];
    UIImage *img = [UIImage imageNamed:@"user_resources"];
    [imgArr addObject:img];
    [imgArr addObject:img];
    [imgArr addObject:img];
    [imgArr addObject:img];
    
    model.from = @"系统消息";

    model.cellHeight = 255.f;
    model.titleHeight = 50.f;
    model.descHeight = 71.f;
    model.imagesHeight = 0;
    
    return model;
}

@end
