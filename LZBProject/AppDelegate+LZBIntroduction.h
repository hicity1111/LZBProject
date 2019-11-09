//
//  AppDelegate+LZBIntroduction.h
//  LZBProject
//
//  Created by hicity on 2019/11/8.
//  Copyright © 2019 hicity. All rights reserved.
//


#import "AppDelegate.h"
#import "LZBIntroductionView.h"
#import "LZBIntroductionCell.h"
#import "LZBMiddleIntroductionCell.h"
#import "LZBLastIntroductionCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (LZBIntroduction)<LZBIntroductionDelegate,LZBIntroductionDataSource>


- (void)initIntroduct;
@end

NS_ASSUME_NONNULL_END
