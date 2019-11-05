//
//  HomeViewController.h
//  LZBProject
//
//  Created by hicity on 2019/10/21.
//  Copyright © 2019 hicity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeDataService.h"

NS_ASSUME_NONNULL_BEGIN


@interface HomeViewController : LZBBaseViewController

@property (nonatomic, strong) HomeDataService *dataService;

@end

NS_ASSUME_NONNULL_END
