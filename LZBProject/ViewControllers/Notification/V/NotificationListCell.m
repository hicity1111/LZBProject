//
//  NotificationListCell.m
//  LZBProject
//
//  Created by liyan on 2019/11/1.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "NotificationListCell.h"
#import "NotificaitonIconItem.h"
#import "NotificationImageItemCell.h"
#import "NotificationToolItem.h"
#import "NotifyListEntry.h"

#define shadowOffset 6.0

///Class Extension
@interface NotificationListCell()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
///背景卡片组件
@property (nonatomic, strong) UIImageView *cardView;
///iCON  header 组件
@property (nonatomic, strong) NotificaitonIconItem *iconHeaderV;
///title 标题
@property (nonatomic, strong) YYLabel *titleLab;
///描述
@property (nonatomic, strong) YYLabel *descLab;
///图片列表
@property (nonatomic, strong) UICollectionView *collectionView;
///底部工具栏
@property (nonatomic, strong) NotificationToolItem *toolView;
///多选button
@property (nonatomic, strong) UIButton *selectedBtn;

@end

@implementation NotificationListCell

///修正cell Frame
- (void)setFrame:(CGRect)frame {
    frame.size.width = [UIScreen mainScreen].bounds.size.width;
    [super setFrame:frame];
}


///MARK:- 构造方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self mt_loadUI];
        [self mt_loadFrame];
    }
    return self;
}


///MARK:- 设置数据模型
- (void)setModel:(NotifyListEntry *)model {
    if (!model) return;
    _model = model;
    ///多选 按钮状态
    self.selectedBtn.selected = model.isSelected;
    
    ///跟新collection 布局
    [self.collectionView reloadData];
    CGFloat collectionHeight = 0.0;
    if (model.imageNums == 0) {
         collectionHeight = 0.0f;
     } else if (model.imageNums <= 3) {
         collectionHeight = 70.0f;
     } else {
         collectionHeight = 150.0f;
     }
    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(collectionHeight);
    }];
}

- (void)setIsMulSelectedStatus:(BOOL)isMulSelectedStatus {
    _isMulSelectedStatus = isMulSelectedStatus;
    self.selectedBtn.hidden = !isMulSelectedStatus;
}


///MARK:- Open API
//计算cell 高度
+ (CGFloat)computeNotifyCellHeight:(NotifyListEntry *)model {
    ///缓存高度
    if (model.cellHeight > 0) return model.cellHeight;
    
    CGFloat cellHeight = 0.f;
    ///上边距
    CGFloat topOrBottomSpace = 5.0f;
    ///iCON  header 组件 高度
    CGFloat iconHeaderH = 40.0f;
    ///iCON  header 到 titleView 的 间距
    CGFloat iconHeaderToTitleSpace = 0.f;
    ///titleView 的高度
    NSMutableAttributedString *titleString = [NotificationListCell mt_generateString:@"这里是系统消息的名字，最多显示两行，后台限制字数30个汉字以内。" color:[UIColor colorWithRed:88/255.0 green:104/255.0 blue:120/255.0 alpha:1.0] font:KMAINFONTBOLD22];
    CGFloat titleHeight = [NotificationListCell mt_computeAttributedStringHeight:titleString];
    ///title 到 desc 的间距
    CGFloat titleToDescSpace = 15.0f;
    ///desc 高度
    NSMutableAttributedString *descString = [NotificationListCell mt_generateString:@"这里是老师编辑的消息内容，最多200个字，全部展示。这里是老师编辑的消息内容，最多200个字，全部展示。这里是老师编辑的消息内容，最多200个字，全部展示。" color:[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0] font:KMAINFONT16];
    CGFloat descHeight = [NotificationListCell mt_computeAttributedStringHeight:descString];
    ///宫格图片高度 高度计算
    CGFloat collectionHeight = 0;
    if (model.imageNums == 0) {
        collectionHeight = 15.0f;
    } else if (model.imageNums <= 3) {
        collectionHeight = 10.0f + 70.0f + 10.0f;
    } else {
        collectionHeight = 10.0f + 150.0f + 10.f;
    }
    ///底部工具栏
    CGFloat bottomToolHeight = 45.0f;
    cellHeight = topOrBottomSpace * 2 + shadowOffset * 2 + iconHeaderH + iconHeaderToTitleSpace + titleHeight + titleToDescSpace + descHeight + collectionHeight + bottomToolHeight;
    model.cellHeight = cellHeight;
    return cellHeight;
}

///MARK:- Private API
+ (NSMutableAttributedString *)mt_generateString:(NSString *)string color:(UIColor *)color font:(UIFont *)font {
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:string];
    attString.yy_font = font;
    attString.yy_color = color;
    attString.yy_lineSpacing = 8.0;
    return attString;
}

+ (CGFloat)mt_computeAttributedStringHeight:(NSMutableAttributedString *)string {
    CGSize maxSize = CGSizeMake(kScreenWidth - 30, MAXFLOAT);
    //计算文本尺寸
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:maxSize text:string];
    CGFloat introHeight = layout.textBoundingSize.height;
    return introHeight;
}


- (void)selectedEvent {
    !self.itemSelectedCallBack ?: self.itemSelectedCallBack(self.model, self.index);
}


///MARK: - Private Methods
- (void)mt_loadUI {
    ///添加卡片
    [self.contentView addSubview:self.cardView];
    ///添加icon 头部
    [self.cardView addSubview:self.iconHeaderV];
    ///添加选择button
    [self.iconHeaderV addSubview:self.selectedBtn];
    ///添加标题
    [self.cardView addSubview:self.titleLab];
    ///添加描述
    [self.cardView addSubview:self.descLab];
    ///添加图片列表
    [self.cardView addSubview:self.collectionView];
    ///添加底部工具栏
    [self.cardView addSubview:self.toolView];
    
    ///临时赋值
    NSMutableAttributedString *titleString = [NotificationListCell mt_generateString:@"这里是系统消息的名字，最多显示两行，后台限制字数30个汉字以内。" color:[UIColor colorWithRed:88/255.0 green:104/255.0 blue:120/255.0 alpha:1.0] font:KMAINFONTBOLD22];
    self.titleLab.attributedText = titleString;
    
    ///临时复制
      NSMutableAttributedString *descString = [NotificationListCell mt_generateString:@"这里是老师编辑的消息内容，最多200个字，全部展示。这里是老师编辑的消息内容，最多200个字，全部展示。这里是老师编辑的消息内容，最多200个字，全部展示。" color:[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0] font:KMAINFONT16];
      self.descLab.attributedText = descString;
}

- (void)mt_loadFrame {
    [self.cardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(5);
        make.bottom.mas_equalTo(-5);
    }];
    
    [self.iconHeaderV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(shadowOffset);
        make.right.mas_equalTo(-shadowOffset);
        make.height.mas_equalTo(40);
    }];
    
    [self.selectedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(44, 44));
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(14);
        make.right.mas_equalTo(-14);
        make.top.equalTo(self.iconHeaderV.mas_bottom);
    }];
    
    [self.descLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.titleLab);
        make.top.equalTo(self.titleLab.mas_bottom).offset(15);
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.titleLab);
        make.top.equalTo(self.descLab.mas_bottom).offset(10);
        make.height.mas_equalTo(0);
    }];
    
    [self.toolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.titleLab);
        make.bottom.mas_equalTo(-shadowOffset);
        make.height.mas_equalTo(45);
    }];
}

///MARK:- UICollectionViewDelegate代理
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.model.imageNums;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((self.mj_w - 60 - 20)/3.0, 70);
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NotificationImageItemCell *cell = (NotificationImageItemCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"NotificationImageItemCell" forIndexPath:indexPath];
    return cell;
}


//点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
}



///MARK:- Getter and Setter
- (UIImageView *)cardView {
    if (!_cardView) {
        _cardView = [[UIImageView alloc] init];
        _cardView.image = [UIImage imageNamed:@"bg_card"];
        _cardView.userInteractionEnabled = YES;
    }
    return _cardView;
}

- (NotificaitonIconItem *)iconHeaderV {
    if (!_iconHeaderV) {
        _iconHeaderV = [NotificaitonIconItem new];
    }
    return _iconHeaderV;
}

- (YYLabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[YYLabel alloc] init];
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.textVerticalAlignment = YYTextVerticalAlignmentTop;
        _titleLab.numberOfLines = 0;
        _titleLab.preferredMaxLayoutWidth = self.width - 30;
    }
    return _titleLab;
}

- (YYLabel *)descLab {
    if (!_descLab) {
        _descLab = [[YYLabel alloc] init];
        _descLab.textAlignment = NSTextAlignmentLeft;
        _descLab.textVerticalAlignment = YYTextVerticalAlignmentTop;
        _descLab.numberOfLines = 0;
        _descLab.preferredMaxLayoutWidth = self.width - 30;
    }
    return _descLab;
}


- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 10.0f;
        flowLayout.minimumInteritemSpacing = 10.0f;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.alwaysBounceVertical = YES;
        
        [_collectionView registerClass:[NotificationImageItemCell class] forCellWithReuseIdentifier:@"NotificationImageItemCell"];
    }
    return _collectionView;
}


- (NotificationToolItem *)toolView {
    if (!_toolView) {
        _toolView = [[NotificationToolItem alloc] init];
    }
    return _toolView;
}

- (UIButton *)selectedBtn {
    if (!_selectedBtn) {
        _selectedBtn = [UIButton new];
        [_selectedBtn setImage:[UIImage imageNamed:@"notify_check_normal"] forState:UIControlStateNormal];
        [_selectedBtn setImage:[UIImage imageNamed:@"notify_check_selected"] forState:UIControlStateSelected];
        [_selectedBtn setImageEdgeInsets:UIEdgeInsetsMake(8, 8, 8, 8)];
        _selectedBtn.hidden = YES;
        [_selectedBtn addTarget:self action:@selector(selectedEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectedBtn;
}



@end
