//
//  NotificationImageItemCell.m
//  LZBProject
//
//  Created by liyan on 2019/11/1.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "NotificationImageItemCell.h"

@interface NotificationImageItemCell()
///图片
@property (nonatomic, strong) UIImageView *imageV;

@end

@implementation NotificationImageItemCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self mt_loadUI];
        [self mt_loadFrame];
    }
    return self;
}


- (void)mt_loadUI {
    [self.contentView addSubview:self.imageV];
}


- (void)mt_loadFrame {
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
}


//MARK:- Getter and Setter
- (UIImageView *)imageV {
    if (!_imageV) {
        _imageV = [UIImageView new];
        _imageV.backgroundColor = [UIColor lightGrayColor];
        [_imageV setCornerRadius:5];
    }
    return _imageV;
}

@end
