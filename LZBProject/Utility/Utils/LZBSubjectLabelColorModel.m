//
//  LZBSubjectLabelColorModel.m
//  LZBProject
//
//  Created by 刘义增 on 2019/11/7.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "LZBSubjectLabelColorModel.h"

@implementation LZBSubjectLabelColorModel

/**
 
 */

- (instancetype)init {
    self = [super init];
    if (self) {
        self.subjectName = @"语文";
        self.textColor = kMAIN00A1;
        self.backgroundColor = KMAINB2E3;
    }
    return self;
}

+ (NSDictionary *)getSubjectLableColorDictionary {
    NSMutableDictionary *mudic = [NSMutableDictionary dictionary];
    
    LZBSubjectLabelColorModel *yw = [[LZBSubjectLabelColorModel alloc] init];
    [mudic setObject:yw forKey:@"语文"];
    
    LZBSubjectLabelColorModel *sx = [[LZBSubjectLabelColorModel alloc] init];
    sx.subjectName = @"数学";
    sx.textColor = kMAIN4D93;
    sx.backgroundColor = [UIColor colorWithHex:@"#4D93FD" alpha:0.34];
    [mudic setObject:sx forKey:@"数学"];
    
    LZBSubjectLabelColorModel *yy = [[LZBSubjectLabelColorModel alloc] init];
    yy.subjectName = @"英语";
    yy.textColor = kMAINAA6F;
    yy.backgroundColor = kMAINE4D1;
    [mudic setObject:yy forKey:@"英语"];
    
    LZBSubjectLabelColorModel *wl = [[LZBSubjectLabelColorModel alloc] init];
    wl.subjectName = @"物理";
    [mudic setObject:wl forKey:@"物理"];
    
    LZBSubjectLabelColorModel *sw = [[LZBSubjectLabelColorModel alloc] init];
    sw.subjectName = @"生物";
    [mudic setObject:sw forKey:@"生物"];
    
    LZBSubjectLabelColorModel *hx = [[LZBSubjectLabelColorModel alloc] init];
    hx.subjectName = @"化学";
    [mudic setObject:hx forKey:@"化学"];
    
    LZBSubjectLabelColorModel *ls = [[LZBSubjectLabelColorModel alloc] init];
    ls.subjectName = @"历史";
    [mudic setObject:ls forKey:@"历史"];
    
    LZBSubjectLabelColorModel *dl = [[LZBSubjectLabelColorModel alloc] init];
    dl.subjectName = @"地理";
    [mudic setObject:dl forKey:@"地理"];
    
    LZBSubjectLabelColorModel *zz = [[LZBSubjectLabelColorModel alloc] init];
    zz.subjectName = @"政治";
    [mudic setObject:zz forKey:@"政治"];
    
    return mudic;
}

+ (instancetype)getModelWithSubjectName:(NSString *)name {
    NSDictionary *dic = [self getSubjectLableColorDictionary];
    LZBSubjectLabelColorModel *model = (LZBSubjectLabelColorModel *)dic[name];
    return model;
}

@end
