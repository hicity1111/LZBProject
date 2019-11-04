//
//  MineCommonCell.h
//  LZBProject
//
//  Created by 刘义增 on 2019/10/30.
//  Copyright © 2019 hicity. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineCommonCell : UITableViewCell

@property (nonatomic, assign) NSInteger cellIndex;

@property (weak, nonatomic) IBOutlet UILabel *rightLb;

- (void)selectedCellWithIndex:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
