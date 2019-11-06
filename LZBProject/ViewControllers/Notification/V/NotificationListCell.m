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
#import "YBImageBrowser.h"

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
///小红点
@property (nonatomic, strong) UIView *redDotV;

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
    ///icon head
    self.iconHeaderV.model = model;
    ///消息红点
    self.redDotV.hidden = model.isRead;
    ///title赋值
    NSMutableAttributedString *titleString = [NotificationListCell mt_generateString:IFISNIL(model.noticeTitle) color:[UIColor colorWithRed:88/255.0 green:104/255.0 blue:120/255.0 alpha:1.0] font:KMAINFONTBOLD22];
    self.titleLab.attributedText = titleString;
    
    ///描述赋值
    NSMutableAttributedString *descString = [NotificationListCell mt_generateString:IFISNIL(model.noticeContent) color:[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0] font:KMAINFONT16];
//    ///消息
//    if (model.noticeType == 1) {
//        descString = [[[NSAttributedString alloc] initWithData:[IFISNIL(model.noticeContent) dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil] mutableCopy];
//    } else {
//
//    }
    self.descLab.attributedText = descString;

    ///底部工具条
    self.toolView.model = model;
    
    ///更新collection 布局
    [self.collectionView reloadData];
    CGFloat collectionHeight = 0.0;
    if (model.noticeImagesUrl.count == 0) {
         collectionHeight = 0.0f;
     } else if (model.noticeImagesUrl.count <= 3) {
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
    NSMutableAttributedString *titleString = [NotificationListCell mt_generateString:IFISNIL(model.noticeTitle) color:[UIColor colorWithRed:88/255.0 green:104/255.0 blue:120/255.0 alpha:1.0] font:KMAINFONTBOLD22];
    CGFloat titleHeight = [NotificationListCell mt_computeAttributedStringHeight:titleString];
    ///title 到 desc 的间距
    CGFloat titleToDescSpace = 15.0f;
    ///desc 高度
    NSMutableAttributedString *descString = [NotificationListCell mt_generateString:IFISNIL(model.noticeContent) color:[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0] font:KMAINFONT16];
    CGFloat descHeight = [NotificationListCell mt_computeAttributedStringHeight:descString];
    ///宫格图片高度 高度计算
    CGFloat collectionHeight = 0;
    if (model.noticeImagesUrl.count == 0) {
        collectionHeight = 15.0f;
    } else if (model.noticeImagesUrl.count <= 3) {
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
    ///添加小红点
    [self.iconHeaderV addSubview:self.redDotV];
    ///添加标题
    [self.cardView addSubview:self.titleLab];
    ///添加描述
    [self.cardView addSubview:self.descLab];
    ///添加图片列表
    [self.cardView addSubview:self.collectionView];
    ///添加底部工具栏
    [self.cardView addSubview:self.toolView];
    
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
    
    [self.redDotV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(6, 6));
        make.top.mas_equalTo(4);
        make.right.mas_equalTo(-4);
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
    return self.model.noticeImagesUrl.count;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((self.mj_w - 60 - 20)/3.0, 70);
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NotificationImageItemCell *cell = (NotificationImageItemCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"NotificationImageItemCell" forIndexPath:indexPath];
    NSString *imageUrl = self.model.noticeImagesUrl[indexPath.row];
    [cell.imageV sd_setImageWithURL:[NSURL URLWithString:IFISNIL(imageUrl)]];
    return cell;
}


//点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // 网络图片
    NSMutableArray *imageUrls = [NSMutableArray new];
    for (NSString *path in self.model.noticeImagesUrl) {
        YBIBImageData *data = [YBIBImageData new];
        data.imageURL = [NSURL URLWithString:path];
        [imageUrls addObject:data];
    }
    YBImageBrowser *browser = [YBImageBrowser new];
    browser.dataSourceArray = imageUrls;
    browser.currentPage = indexPath.row;
    [browser show];
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
        _collectionView.scrollEnabled = NO;
        
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


- (UIView *)redDotV {
    if (!_redDotV) {
        _redDotV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 6, 6)];
        [_redDotV setCornerRadius:3.0];
        _redDotV.hidden = NO;
        _redDotV.backgroundColor = [UIColor colorWithRed:255/255.0 green:0/255.0 blue:0/255.0 alpha:1.0];
    }
    return _redDotV;
}



@end
