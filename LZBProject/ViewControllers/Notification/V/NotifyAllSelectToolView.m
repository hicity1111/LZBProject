//
//  NotifyAllSelectToolView.m
//  LZBProject
//
//  Created by liyan on 2019/11/1.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "NotifyAllSelectToolView.h"

@interface NotifyAllSelectToolView()

///删除按钮
@property (nonatomic, strong) UIButton *delBtn;
///全选按钮
@property (nonatomic, strong) JMBaseButton *allBtn;

@end


@implementation NotifyAllSelectToolView

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
    self.backgroundColor =  [UIColor colorWithHex:@"#eeeeee"];
    [self addSubview:self.delBtn];
    [self addSubview:self.allBtn];
}


- (void)mt_loadFrame {
    MJWeakSelf
    [self.delBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(90, 32));
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.right.mas_equalTo(-17);
    }];
}

///MARK:- Open API
///重置状态
- (void)resetData {
    self.allBtn.selected = NO;
    [self.delBtn setTitle:@"删除" forState:UIControlStateNormal];
}

///更新删除num
- (void)updateDelNums:(NSInteger)nums {
    if (nums == 0) {
        [self.delBtn setTitle:[NSString stringWithFormat:@"删除"] forState:UIControlStateNormal];
    } else {
        [self.delBtn setTitle:[NSString stringWithFormat:@"删除(%@)",@(nums)] forState:UIControlStateNormal];
    }
}

///MARK:- Private API
//全选事件
- (void)allSelectedEvent {
    self.allBtn.selected = !self.allBtn.selected;
    !self.allSelectedCallBack ?: self.allSelectedCallBack(self.allBtn.selected);
}

///删除事件
- (void)deleteEvent {
    !self.deleteEventCallBack ?: self.deleteEventCallBack();
}


///MARK:- Getter and Setter
- (UIButton *)delBtn {
    if (!_delBtn) {
        _delBtn = [UIButton new];
        [_delBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_delBtn setBackgroundColor:[UIColor colorWithHex:@"#00B57A"]];
        [_delBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _delBtn.titleLabel.font = KMAINFONT16;
        [_delBtn setCornerRadius:16.0];
        [_delBtn addTarget:self action:@selector(deleteEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _delBtn;
}

- (JMBaseButton *)allBtn {
    if (!_allBtn) {
        JMBaseButtonConfig *config = [JMBaseButtonConfig buttonConfig];
        config.styleType = JMButtonStyleTypeLeft;
        config.padding = 10.f;
        config.imageSize = CGSizeMake(20.f, 20.f);
        config.title = @"选择全部";
        config.titleColor = KMAIN00A2;
        config.titleFont = LZBRegularFont(15.f);
        config.backgroundColor = [UIColor clearColor];
        _allBtn = [[JMBaseButton alloc] initWithFrame:CGRectMake(16, 2.5, 100, 40) ButtonConfig:config];
        [_allBtn setImage:[UIImage imageNamed:@"notify_check_normal"] forState:UIControlStateNormal];
        [_allBtn setImage:[UIImage imageNamed:@"notify_check_selected"] forState:UIControlStateSelected];
        [_allBtn addTarget:self action:@selector(allSelectedEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _allBtn;
}

@end
