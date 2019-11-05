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
                             withModel:(CTB_SubjectModel *)model {
    CTBSubjectCell *cell = [tableView dequeueReusableCellWithIdentifier:subjectCellID];
    
    if (!cell) {
        
    }
    
    NSString *subjectText = model.subjectAbbreviation;
    NSString *imgName = @"subject_chinese";
    NSString *title = @"语文";
    if ([subjectText isEqualToString:@"yuwen"]) {
        imgName = @"subject_chinese";
        title = @"语文";
    }
    else if ([subjectText isEqualToString:@"shuxue"]) {
        imgName = @"subject_math";
        title = @"数学";
    }
    else if ([subjectText isEqualToString:@"yingyu"]) {
        imgName = @"subject_english";
        title = @"英语";
    }
    else if ([subjectText isEqualToString:@"wuli"]) {
        imgName = @"subject_physics";
        title = @"物理";
    }
    else if ([subjectText isEqualToString:@"huaxue"]) {
        imgName = @"subject_chemistry";
        title = @"化学";
    }
    
    cell.subject_imgV.image = IMAGE_NAMED(imgName);
    cell.subject_nameLb.text = title;
    
    NSInteger count = model.noexamineCount;
    if (count == 0) {
        cell.subject_descLb.text = @"你真棒，没有错题啦~";
    } else {
        cell.subject_descLb.text = [NSString stringWithFormat:@"有 %ld 道题未修改哟~", count];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
