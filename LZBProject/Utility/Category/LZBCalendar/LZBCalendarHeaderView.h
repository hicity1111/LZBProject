//
//  LZBCalendarHeaderView.h
//  LZBProject
//
//  Created by hicity on 2019/10/18.
//  Copyright © 2019 hicity. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^calendarLeftClickBlock)  (void);

typedef void (^calendarRightClickBlock) (void);

typedef void (^calendarTotalClickBlock) (void);


@interface LZBCalendarHeaderView : UIView

@property (nonatomic, strong) UIButton    *leftButton;

@property (nonatomic, strong) UIButton    *rightButton;

@property (nonatomic, strong) UILabel     *yearAndMonthLabel;

@property (nonatomic, strong) UIButton    *totalButton;

@property (nonatomic, strong) UIImageView *bottonImage;
 
@property (nonatomic, strong) NSString    *dateStr;

@property (nonatomic, assign) BOOL isShowBottomImage;

@property (nonatomic, assign) BOOL isShowLeftAndRightBtn;

@property (nonatomic, copy) calendarLeftClickBlock   leftClickBlock;

@property (nonatomic, copy) calendarRightClickBlock  rightClickBlock;

@property (nonatomic, copy) calendarTotalClickBlock  totalClickBlock;
@end

NS_ASSUME_NONNULL_END
