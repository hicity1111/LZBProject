//
//  AppDelegate+LZBIntroduction.m
//  LZBProject
//
//  Created by hicity on 2019/11/8.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "AppDelegate+LZBIntroduction.h"


@implementation AppDelegate (LZBIntroduction)

- (void)initIntroduct{
    
    if (![SDUserDefaults boolForKey:@"everLaunched"]) {
        [SDUserDefaults setBool:YES forKey:@"everLaunched"];
        [SDUserDefaults setBool:YES forKey:@"firstLaunch"];
        XLDLog(@"first launch第一次程序启动");
        //这里进入引导画面
        [self example];
    }else {
        XLDLog(@"second launch再次程序启动");
        ////直接进入主界面
        [self entryDoor];
    }
}


- (void)example{
    LZBIntroductionView *introductionView = [[LZBIntroductionView alloc] initWithImgCount:3 andDataSource:self];
    
    [introductionView.introlCollectionView registerNib:[UINib nibWithNibName:@"LZBIntroductionCell" bundle:nil] forCellWithReuseIdentifier:@"LZBIntroductionCell"];
    [introductionView.introlCollectionView registerNib:[UINib nibWithNibName:@"LZBMiddleIntroductionCell" bundle:nil] forCellWithReuseIdentifier:@"LZBMiddleIntroductionCell"];
    [introductionView.introlCollectionView registerNib:[UINib nibWithNibName:@"LZBLastIntroductionCell" bundle:nil] forCellWithReuseIdentifier:@"LZBLastIntroductionCell"];
    self.window.rootViewController = [UIViewController new];
    [[UIApplication sharedApplication].keyWindow addSubview:introductionView];
    self.introductionView = introductionView;
}
- (void)introductionViewDidClickEnterAction:(LZBIntroductionView *)introductionView
{
    
    [self.introductionView removeFromSuperview];
    self.introductionView = nil;
    
}
- (void)didClickEnter{
    [self entryDoor];
}
- (void)introductionView:(LZBIntroductionView *)introductionView didClickPageIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%d", (int)indexPath.item);
}


// GYIntroductionDataSource
- (__kindof UICollectionViewCell *)introductionView:(LZBIntroductionView *)introductionView cellForItemAtIndex:(NSIndexPath *)indexPath
{
    LZBIntroductionCell *cell = [introductionView.introlCollectionView dequeueReusableCellWithReuseIdentifier:@"LZBIntroductionCell" forIndexPath:indexPath];
    LZBMiddleIntroductionCell *middleCell = [introductionView.introlCollectionView dequeueReusableCellWithReuseIdentifier:@"LZBMiddleIntroductionCell" forIndexPath:indexPath];
    LZBLastIntroductionCell *lastCell = [introductionView.introlCollectionView dequeueReusableCellWithReuseIdentifier:@"LZBLastIntroductionCell" forIndexPath:indexPath];
    lastCell.delegate = self;
    if (indexPath.item == 0) {
        // the last one
        return cell;
    }else if (indexPath.item == 1){
        return middleCell;
    }else{
        return lastCell;
    }
}
@end
