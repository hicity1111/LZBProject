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
/// 未读小红点
@property (nonatomic, strong) UILabel *dot;
/// 时间
@property (nonatomic, strong) UILabel *timeLb;
/// 标题
@property (nonatomic, strong) UILabel *titleLb;
/// 内容
@property (nonatomic, strong) UILabel *descLb;

/// 6个图片
@property (nonatomic, strong) NSArray <UIImageView *> *imgArr;

/// 分割线
@property (nonatomic, strong) UILabel *sepLine;
/// 来源
@property (nonatomic, strong) UILabel *fromLb;
/// 按钮
@property (nonatomic, strong) JMButton *actionBtn;

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
    CGSize size = [lb sizeThatFits:CGSizeMake(kTitle_width, 17.f)];
    
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
        _containerView = [[UIView alloc] init];
        _containerView.backgroundColor = UIColor.blueColor;
        [_containerView setCornerRadius:8.f];
    }
    return _containerView;
}

- (NSArray<UILabel *> *)tagArr {
    if (!_tagArr) {
        NSMutableArray *mua = [NSMutableArray array];
        for (int i = 0; i < 3; i++) {
            UILabel *lb = [[UILabel alloc] init];
            lb.textAlignment = NSTextAlignmentCenter;
            lb.font = LZBMediumFont(14.f);
            lb.backgroundColor = KMAINB2E3;
            lb.textColor = kMAIN00A1;
            
            [mua addObject:lb];
        }
        _tagArr = [NSArray arrayWithArray:mua];
    }
    return _tagArr;
}

- (UILabel *)dot {
    if (_dot) {
        _dot = [[UILabel alloc] init];
        _dot.backgroundColor = REDCOLOR;
        _dot.size = CGSizeMake(7.f, 7.f);
        [_dot setCornerRadiusAuto];
    }
    return _dot;
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
        _titleLb.textColor = KMAIN5868;
        _titleLb.font = LZBMediumFont(18.f);
        _titleLb.numberOfLines = 0;
    }
    return _titleLb;
}

- (UILabel *)descLb {
    if (_descLb) {
        _descLb = [[UILabel alloc] init];
        _descLb.textColor = kMAIN7777;
        _descLb.font = LZBRegularFont(16.f);
        _descLb.numberOfLines = 0;
    }
    return _descLb;
}

- (NSArray<UIImageView *> *)imgArr {
    if (!_imgArr) {
        NSMutableArray *mua = [NSMutableArray array];
        for (int i = 0; i < 6; i++) {
            UIImageView *imgV = [[UIImageView alloc] init];
            [mua addObject:imgV];
        }
        _imgArr = [NSArray arrayWithArray:mua];
    }
    return _imgArr;
}




@end
