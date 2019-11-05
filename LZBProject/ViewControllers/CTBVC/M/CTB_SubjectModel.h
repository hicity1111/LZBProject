//
//  CTB_SubjectModel.h
//  LZBProject
//
//  Created by 刘义增 on 2019/11/5.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "LZBAPIResponseBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CTB_SubjectModel : LZBAPIResponseBaseModel

@property (nonatomic, assign) NSInteger noexamineCount;

@property (nonatomic, strong) NSString *subjectAbbreviation;


@end

NS_ASSUME_NONNULL_END
