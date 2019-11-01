//
//  NotifyCellModel.h
//  LZBProject
//
//  Created by 刘义增 on 2019/10/31.
//  Copyright © 2019 hicity. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kAroundMargin       15.f
#define kLeftMargin         15.f
#define kHW_image_spacing   10.f
#define kTitle_width        (kScreenWidth - 2 * kAroundMargin - 2 * kLeftMargin)
#define kImage_width        ((kTitle_width - 2 * kHW_image_spacing) / 3.f)

#define kTagLbHeight        23.f
#define kVH_tag_title       18.f
#define kVH_title_desc      19.f
#define kVH_desc_sepLine    12.f
#define kVH_desc_imange     15.f
#define kImage_height       (kImage_width / 98.f * 70.f)
#define kImage_spacing      10.f
#define kVH_image_sepLine   15.f
/// 分割线-消息来源-底部
#define kBottomBarHeight    44.f



NS_ASSUME_NONNULL_BEGIN

@interface NotifyCellModel : NSObject


@property (nonatomic, strong) NSArray   *tags;

@property (nonatomic, strong) NSString  *timeStr;

@property (nonatomic, strong) NSString  *title;

@property (nonatomic, strong) NSString  *desc;

@property (nonatomic, strong) NSArray   *imgArr;

@property (nonatomic, strong) NSString  *from;

@property (nonatomic, assign) BOOL      hasButton;

@property (nonatomic, assign) BOOL      isNewMsg;



@property (nonatomic, assign) CGFloat   cellHeight;

@property (nonatomic, assign) CGFloat   titleHeight;

@property (nonatomic, assign) CGFloat   descHeight;

@property (nonatomic, assign) CGFloat   imagesHeight;

- (instancetype)transToModelWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
