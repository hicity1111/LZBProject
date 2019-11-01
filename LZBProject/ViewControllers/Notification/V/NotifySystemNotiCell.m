//
//  NotifySystemNotiCell.m
//  LZBProject
//
//  Created by 刘义增 on 2019/10/30.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "NotifySystemNotiCell.h"

#define kTimeTopMargin  14.f


@interface NotifySystemNotiCell ()

@property (nonatomic, assign) BOOL hasImage;

/// 容器
@property (nonatomic, strong) UIView *containerView;

/// 三个标签
@property (nonatomic, strong) NSArray <UILabel *> *tagArr;

@property (nonatomic, strong) UILabel *timeLb;

@property (nonatomic, strong) UILabel *titleLb;

@property (nonatomic, strong) UILabel *descLb;

/// 6个图片
@property (nonatomic, strong) NSArray <UIImageView *> *imgArr;

@property (nonatomic, assign) CGFloat imgMaxY;

@end

@implementation NotifySystemNotiCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style
                    reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = UIColor.redColor;
        
        [self addCustomSubviews];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];

    if (highlighted) {
        self.backgroundColor = TABLECELL_HIGHLIGHTED_COLOR;
    } else {
        self.backgroundColor = WHITECOLOR;
    }
}

#pragma mark - Custom Method

- (void)addCustomSubviews {
    
    [self addSubview:self.containerView];
    
    for (UILabel *tag in self.tagArr) {
        [self.containerView addSubview:tag];
    }
    [self.containerView addSubview:self.timeLb];
    [self.containerView addSubview:self.titleLb];
    [self.containerView addSubview:self.descLb];
    for (UIImageView *item in self.imgArr) {
        [self.containerView addSubview:item];
    }
    
    [self addBottomBar];
}


- (void)addTagLabels {
    LZBWeak;
    NSInteger tagCount = self.model.tags.count;
    __block CGFloat tag_x, tag_y, tag_w = 0;
    [self.model.tags enumerateObjectsUsingBlock:^(NSString *text, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *lb = [[UILabel alloc] init];
        lb.backgroundColor = KMAINB2E3;
        lb.textAlignment = NSTextAlignmentCenter;
        lb.text = text;
        lb.textColor = kMAIN00A1;
        lb.font = LZBMediumFont(14.f);
        tag_w = [self getWidthWithString:text] + 16.f;
        lb.frame = CGRectMake(tag_x, tag_y, tag_w, kTagLbHeight);
        
        if (idx == 0) {
            [lb setRoundedCorners:LYZRectCornerTopLeft withRadius:8];
        }
        // 最后一个
        else if (idx == tagCount - 1) {
            [lb setRoundedCorners:LYZRectCornerBottomRight withRadius:8];
        }
        
        [weakSelf.containerView addSubview:lb];
        tag_x += tag_w;
    }];
}

- (void)addTimeLb {
    
}

- (void)addTitleAndDesc {
    UILabel *titleLb = [[UILabel alloc] init];
    titleLb.text = self.model.title;
    titleLb.textColor = KMAIN5868;
    titleLb.font = LZBMediumFont(18.f);
    titleLb.numberOfLines = 0;
    titleLb.frame = CGRectMake(kLeftMargin, kTagLbHeight + kVH_tag_title, kTitle_width, self.model.titleHeight);
    
    self.titleLb = titleLb;
    [self.containerView addSubview:titleLb];
    
    UILabel *descLb = [[UILabel alloc] init];
    descLb.text = self.model.desc;
    descLb.textColor = KMAIN7777;
    descLb.font = LZBRegularFont(16.f);
    descLb.numberOfLines = 0;
    CGFloat descY = CGRectGetMaxY(titleLb.frame) + kVH_title_desc;
    descLb.frame = CGRectMake(kLeftMargin, descY, kTitle_width, self.model.descHeight);
    
    self.descLb = descLb;
    [self.containerView addSubview:descLb];
}

- (void)addImages {
    LZBWeak;
    
    [self.model.imgArr enumerateObjectsUsingBlock:^(UIImage *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger rowIndex = idx / 3;
        NSInteger colIndex = idx % 3;
        CGFloat imgX = rowIndex * (kImage_width + kHW_image_spacing);
        CGFloat imgY = colIndex * (kImage_height + kImage_spacing);
        
        CGRect rect = CGRectMake(imgX, imgY, kImage_width, kImage_height);
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:rect];
        imgV.image = obj;
        [weakSelf.containerView addSubview:imgV];
        
        weakSelf.imgMaxY = CGRectGetMaxY(imgV.frame);
    }];
}

- (void)addBottomBar {
    CGFloat sepY = CGRectGetMaxY(self.descLb.frame) + kVH_desc_sepLine;
    if (self.hasImage) {
        sepY = self.imgMaxY + kVH_image_sepLine;
    }
    UIImageView *sepLine = [[UIImageView alloc] initWithFrame:CGRectMake(kLeftMargin, sepY, kTitle_width, 1.f)];
    sepLine.image = [UIImage imageNamed:@"message_line"];
    [self.containerView addSubview:sepLine];
    
    CGFloat lby = CGRectGetMaxY(sepLine.frame) + 15.f;
    
    UILabel *xllyLb = [[UILabel alloc] initWithFrame:CGRectZero];
    xllyLb.text = @"消息来源：";
    xllyLb.textColor = kMAIN9696;
    xllyLb.font = LZBRegularFont(14.f);
    [xllyLb sizeToFit];
    xllyLb.frame = CGRectMake(kLeftMargin, lby, xllyLb.width, xllyLb.height);
    [self.containerView addSubview:xllyLb];
    
    UILabel *lyLb = [[UILabel alloc] initWithFrame:CGRectZero];
    lyLb.text = self.model.from;
    lyLb.textColor = kMAIN9696;
    lyLb.font = LZBRegularFont(14.f);
    [lyLb sizeToFit];
    lyLb.frame = CGRectMake(CGRectGetMaxX(xllyLb.frame), lby, lyLb.width, lyLb.height);
    [self.containerView addSubview:lyLb];
    
    UIImageView *arrowV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"message_arrow"]];
    arrowV.frame = CGRectMake(kTitle_width - 6, lby, 6.f, 10.f);
    [self.containerView addSubview:arrowV];
    
    if (self.model.hasButton) {
        JMBaseButtonConfig *config = [JMBaseButtonConfig buttonConfig];
        config.styleType = JMButtonStyleTypeRight;
        config.padding = 10.f;
        config.image = [UIImage imageNamed:@"message_arrow"];
        config.imageSize = CGSizeMake(6.f, 10.f);
        config.title = @"点击查看";
        config.titleColor = KMAIN00A2;
        config.titleFont = LZBRegularFont(15.f);
        CGRect rect = CGRectMake(kTitle_width - 80, 0, 80, kBottomBarHeight);
        JMButton *button = [[JMButton alloc] initWithFrame:rect ButtonConfig:config];
        [self.containerView addSubview:button];
    }
}

- (void)addNoreadDot {
    
}

#pragma mark - Private Method

- (CGFloat)getWidthWithString:(NSString *)text {
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectZero];
    lb.text = text;
    lb.font = LZBRegularFont(14.f);
    CGSize size = [lb sizeThatFits:CGSizeMake(kTitle_width, 20.f)];
    
    return size.width;
}


#pragma mark - Setter

- (void)setModel:(NotifyCellModel *)model {
    _model = model;
    self.hasImage = model.imgArr.count > 0;
    
    
}


#pragma mark - 懒加载

- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] initWithFrame:CGRectMake(kAroundMargin, kAroundMargin, kScreenWidth - 2 * kAroundMargin, self.height - kAroundMargin)];
        NSLog(@"(((((((((((((   %@, %@", self, self.contentView);
        _containerView.backgroundColor = UIColor.blueColor;
        [_containerView setCornerRadius:8.f];
    }
    return _containerView;
}

- (UILabel *)timeLb {
    if (_timeLb) {
        _timeLb = [[UILabel alloc] init];
        _timeLb.textColor = kMAIN9696;
        _timeLb.font = LZBRegularFont(14.f);
        _timeLb.textAlignment = NSTextAlignmentRight;
    }
    return _timeLb;
}

- (UILabel *)titleLb {
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.text = self.model.title;
        _titleLb.textColor = KMAIN5868;
        _titleLb.font = LZBMediumFont(18.f);
        _titleLb.numberOfLines = 0;
    }
    return _titleLb;
}


@end
