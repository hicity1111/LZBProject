//
//  CTB_SubjectDataService.h
//  LZBProject
//
//  Created by 刘义增 on 2019/11/5.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "LZBServiceBase.h"
#import "CTB_SubjectModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CTB_SubjectDataService : LZBServiceBase


+ (CTB_SubjectDataService *)sharedService;


- (void)requestDataWithSuccessBlock:(void (^)(LZBAPIResponseBaseModel * _Nonnull))success
                       failureBlock:(void (^)(NSError * _Nonnull))failure;

@end

NS_ASSUME_NONNULL_END
