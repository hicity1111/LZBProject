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
    [self example];
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
    NSLog(@"代理回调 点击进入");
    
    [self.introductionView removeFromSuperview];
    self.introductionView = nil;
    
}
- (void)introductionView:(LZBIntroductionView *)introductionView didClickPageIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%d", (int)indexPath.item);
}



// GYIntroductionDataSource
- (__kindof UICollectionViewCell *)introductionView:(LZBIntroductionView *)introductionView cellForItemAtIndex:(NSIndexPath *)indexPath
{
    LZBIntroductionCell *cell = [introductionView.introlCollectionView dequeueReusableCellWithReuseIdentifier:@"LZBIntroductionCell" forIndexPath:indexPath];
    LZBMiddleIntroductionCell *cell1 = [introductionView.introlCollectionView dequeueReusableCellWithReuseIdentifier:@"LZBMiddleIntroductionCell" forIndexPath:indexPath];
    LZBLastIntroductionCell *cell2 = [introductionView.introlCollectionView dequeueReusableCellWithReuseIdentifier:@"LZBLastIntroductionCell" forIndexPath:indexPath];
//    cell.delegate = self;
    if (indexPath.item == 0) {
        // the last one
        return cell;
    }else if (indexPath.item == 1){
        return cell1;
    }else{
        return cell2;
    }
}
@end
