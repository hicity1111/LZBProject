//
//  LZBEmptyBaseView.m
//  LZBProject
//
//  Created by hicity on 2019/10/31.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "LZBEmptyBaseView.h"

@implementation LZBEmptyBaseView

- (instancetype)init{
    self = [super init];
    if (self) {
        [self initialize];
        [self prepare];
    }
    return self;
}

- (void)initialize{
}

- (void)layoutSubviews{
    [super layoutSubviews];
    UIView *view = self.superview;
    if (view && [view isKindOfClass:[UIView class]]) {
        self.width = view.width;
        self.height = view.height;
    }
    [self setupSubviews];
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    
    if (newSuperview && ![newSuperview isKindOfClass:[UIView class]]) return;
    
    if (newSuperview) {
        self.width = newSuperview.width;
        self.height = newSuperview.height;
    }
}
- (void)setupSubviews{
    
}

- (void)prepare{
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}


+ (instancetype)emptyActionViewWithImage:(UIImage *)image titleStr:(NSString *)titleStr detailStr:(NSString *)detailStr btnTitleStr:(NSString *)btnTitleStr target:(id)target action:(SEL)action{
    LZBEmptyBaseView *empty = [[self alloc] init];
    
    [empty creatEmptyViewWithImage:image imageStr:nil titleStr:titleStr detailStr:detailStr btnTitleStr:btnTitleStr target:target action:action btnClickBlock:nil];
    return empty;
}

+ (instancetype)emptyActionViewWithImage:(UIImage *)image
                                titleStr:(NSString *)titleStr
                               detailStr:(NSString *)detailStr
                             btnTitleStr:(NSString *)btnTitleStr
                           btnClickBlock:(LZBActionTapBlock)btnClickBlock{
    
    LZBEmptyBaseView *emptyView = [[self alloc] init];
    [emptyView creatEmptyViewWithImage:image imageStr:nil titleStr:titleStr detailStr:detailStr btnTitleStr:btnTitleStr target:nil action:nil btnClickBlock:btnClickBlock];
    
    return emptyView;
}

+ (instancetype)emptyActionViewWithImageStr:(NSString *)imageStr
                                   titleStr:(NSString *)titleStr
                                  detailStr:(NSString *)detailStr
                                btnTitleStr:(NSString *)btnTitleStr
                                     target:(id)target
                                     action:(SEL)action{
    
    LZBEmptyBaseView *emptyView = [[self alloc] init];
    [emptyView creatEmptyViewWithImage:nil imageStr:imageStr titleStr:titleStr detailStr:detailStr btnTitleStr:btnTitleStr target:target action:action btnClickBlock:nil];
    
    return emptyView;
}

+ (instancetype)emptyActionViewWithImageStr:(NSString *)imageStr
                                   titleStr:(NSString *)titleStr
                                  detailStr:(NSString *)detailStr
                                btnTitleStr:(NSString *)btnTitleStr
                              btnClickBlock:(LZBActionTapBlock)btnClickBlock{
   
    LZBEmptyBaseView *emptyView = [[self alloc] init];
    [emptyView creatEmptyViewWithImage:nil imageStr:imageStr titleStr:titleStr detailStr:detailStr btnTitleStr:btnTitleStr target:nil action:nil btnClickBlock:btnClickBlock];
    
    return emptyView;
}

+ (instancetype)emptyViewWithImage:(UIImage *)image
                          titleStr:(NSString *)titleStr
                         detailStr:(NSString *)detailStr{
    
    LZBEmptyBaseView *emptyView = [[self alloc] init];
    [emptyView creatEmptyViewWithImage:image imageStr:nil titleStr:titleStr detailStr:detailStr btnTitleStr:nil target:nil action:nil btnClickBlock:nil];
    
    return emptyView;
}

+ (instancetype)emptyViewWithImageStr:(NSString *)imageStr
                             titleStr:(NSString *)titleStr
                            detailStr:(NSString *)detailStr{
    
    LZBEmptyBaseView *emptyView = [[self alloc] init];
    [emptyView creatEmptyViewWithImage:nil imageStr:imageStr titleStr:titleStr detailStr:detailStr btnTitleStr:nil target:nil action:nil btnClickBlock:nil];
    
    return emptyView;
}

+ (instancetype)emptyViewWithCustomView:(UIView *)customView{
    
    LZBEmptyBaseView *emptyView = [[self alloc] init];
    [emptyView creatEmptyViewWithCustomView:customView];
    
    return emptyView;
}



- (void)creatEmptyViewWithImage:(UIImage *)image imageStr:(NSString *)imageStr titleStr:(NSString *)titleStr detailStr:(NSString *)detailStr btnTitleStr:(NSString *)btnTitleStr target:(id)target action:(SEL)action btnClickBlock:(LZBActionTapBlock)btnClickBlock{
    
    _image = image;
    _imageStr = imageStr;
    _titleStr = titleStr;
    _detailStr = detailStr;
    _btnTitleStr = btnTitleStr;
    _actionBtnTarget = target;
    _actionBtnAction = action;
    _btnClickBlock = btnClickBlock;
    
    //内容物背景视图
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectZero];
        [self addSubview:_contentView];
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEmptyView:)];
    [self addGestureRecognizer:tap];
}


- (void)creatEmptyViewWithCustomView:(UIView *)customView{
    
    //内容物背景视图
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectZero];
        [self addSubview:_contentView];
    }
    
    if (!_customView) {
        [_contentView addSubview:customView];
    }
    _customView = customView;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEmptyView:)];
    [self addGestureRecognizer:tap];
}

#pragma mark - 点击手法方法
- (void)tapEmptyView:(UITapGestureRecognizer *)tap{
    if (_tapEmptyViewBlock) {
        _tapEmptyViewBlock();
    }
}

- (void)setImage:(UIImage *)image{
    _image = image;
    [self setNeedsLayout];
}

- (void)setImageStr:(NSString *)imageStr{
    _imageStr = imageStr;
    [self setNeedsLayout];
}

- (void)setDetailStr:(NSString *)detailStr{
    _detailStr = detailStr;
    [self setNeedsLayout];
}

- (void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
    [self setNeedsLayout];
}

- (void)setBtnTitleStr:(NSString *)btnTitleStr{
    _btnTitleStr = btnTitleStr;
    [self setNeedsLayout];
}
@end

