//
//  LZBAPIResponseBaseModel.h
//  LZBProject
//
//  Created by hicity on 2019/11/1.
//  Copyright © 2019 hicity. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LZBAPIResponseBaseModel : NSObject

@property (nonatomic, copy) NSString *currentTime;

@property (nonatomic, assign) int flag;

@property (nonatomic, copy) NSString *message;

@property (nonatomic, strong) id infos;

@end

NS_ASSUME_NONNULL_END
