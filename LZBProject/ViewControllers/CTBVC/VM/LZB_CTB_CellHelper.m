//
//  LZB_CTB_CellHelper.m
//  LZBProject
//
//  Created by 刘义增 on 2019/10/29.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "LZB_CTB_CellHelper.h"
#import "CTBSubjectCell.h"

#define subjectCellID @"CTBSubjectCell"

@implementation LZB_CTB_CellHelper

+ (UITableViewCell *)cellWithTableView:(UITableView *)tableView
                         withIndexPath:(NSIndexPath *)indexpath
                             withModel:(NSDictionary *)model {
    CTBSubjectCell *cell = [tableView dequeueReusableCellWithIdentifier:subjectCellID];
    
    if (!cell) {
        
    }
    
    cell.subject_imgV.image = [UIImage imageNamed:model[@"imgName"]];
    cell.subject_nameLb.text = [NSString stringWithFormat:@"%@ %ld", model[@"title"], indexpath.row];
    cell.subject_descLb.text = [NSString stringWithFormat:@"%@", model[@"desc"]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
