//
//  LZB_CTB_CellHelper.h
//  LZBProject
//
//  Created by 刘义增 on 2019/10/29.
//  Copyright © 2019 hicity. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTB_SubjectModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LZB_CTB_CellHelper : NSObject

+ (UITableViewCell *)cellWithTableView:(UITableView *)tableView
                         withIndexPath:(NSIndexPath *)indexpath
                             withModel:(CTB_SubjectModel *)model;

@end

NS_ASSUME_NONNULL_END
