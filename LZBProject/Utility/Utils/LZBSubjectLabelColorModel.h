//
//  LZBSubjectLabelColorModel.h
//  LZBProject
//
//  Created by 刘义增 on 2019/11/7.
//  Copyright © 2019 hicity. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LZBSubjectLabelColorModel : NSObject

@property (nonatomic, strong) NSString *subjectName;

@property (nonatomic, strong) UIColor *textColor;

@property (nonatomic, strong) UIColor *backgroundColor;


+ (NSDictionary *)getSubjectLableColorDictionary;

+ (instancetype)getModelWithSubjectName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
