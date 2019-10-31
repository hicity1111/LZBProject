//
//  UIView+Empty.m
//  LZBProject
//
//  Created by hicity on 2019/10/31.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "UIView+Empty.h"
#import <objc/runtime.h>
#import "LZBEmptyView.h"


@implementation UIView (Empty)

+ (void)exchangeInstanceMethod1:(SEL)method1 method2:(SEL)method2{
    
    method_exchangeImplementations(class_getInstanceMethod(self, method1), class_getInstanceMethod(self, method2));
}

static char kEmptyViewKey;

- (void)setLzbemptyView:(LZBEmptyView *)lzbemptyView{
    if (lzbemptyView != self.lzbemptyView) {
        
        objc_setAssociatedObject(self, &kEmptyViewKey, lzbemptyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        for (UIView *view in self.subviews) {
            if ([view isKindOfClass:[lzbemptyView class]]) {
                [view removeFromSuperview];
            }
        }
        [self addSubview:self.lzbemptyView];
        
        if ([self isKindOfClass:[UITableView class]] || [self isKindOfClass:[UICollectionView class]]) {
            [self getDataAndSet]; // 添加时根据DataSource去决定显隐
        } else {
            self.lzbemptyView.hidden = YES;// 添加时默认隐藏
        }
    }
}

- (LZBEmptyView *)lzbemptyView{
    return objc_getAssociatedObject(self, &kEmptyViewKey);
}

- (NSInteger)totalDataCount
{
    NSInteger totalCount = 0;
    if ([self isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)self;
        
        for (NSInteger section = 0; section < tableView.numberOfSections; section++) {
            totalCount += [tableView numberOfRowsInSection:section];
        }
    } else if ([self isKindOfClass:[UICollectionView class]]) {
        UICollectionView *collectionView = (UICollectionView *)self;
        
        for (NSInteger section = 0; section < collectionView.numberOfSections; section++) {
            totalCount += [collectionView numberOfItemsInSection:section];
        }
    }
    return totalCount;
}

- (void)getDataAndSet{
    //没有设置emptyView的，直接返回
    if (!self.lzbemptyView) {
        return;
    }
    
    if ([self totalDataCount] == 0) {
        [self show];
    }else{
        [self hide];
    }
}

- (void)show{
    //当不自动显隐时，内部自动调用show方法时也不要去显示，要显示的话只有手动去调用 lzbshowEmptyView
    if (!self.lzbemptyView.autoShowEmptyView) {
        return;
    }
    
    [self lzbshowEmptyView];
}
- (void)hide{
    //当不自动显隐时，内部自动调用hide方法时也不要去隐藏，要隐藏的话只有手动去调用 lzbhideEmptyView
    if (!self.lzbemptyView.autoShowEmptyView) {
        return;
    }
    
    [self lzbhideEmptyView];
}

#pragma mark - Public Method
- (void)lzbshowEmptyView{
    
    NSAssert(![self isKindOfClass:[LZBEmptyView class]], @"LZBEmptyView及其子类不能调用lzbshowEmptyView方法");

    self.lzbemptyView.hidden = NO;
    
    //让 emptyBGView 始终保持在最上层
    [self bringSubviewToFront:self.lzbemptyView];
}
- (void)lzbhideEmptyView{
    NSAssert(![self isKindOfClass:[LZBEmptyView class]], @"LZBEmptyView及其子类不能调用lzbhideEmptyView方法");
    self.lzbemptyView.hidden = YES;
}
- (void)lzbstartLoading{
    NSAssert(![self isKindOfClass:[LZBEmptyView class]], @"LZBEmptyView及其子类不能调用lzbstartLoading方法");
    self.lzbemptyView.hidden = YES;
}
- (void)lzbendLoading{
    NSAssert(![self isKindOfClass:[LZBEmptyView class]], @"LZBEmptyView及其子类不能调用lzbendLoading方法");
    self.lzbemptyView.hidden = [self totalDataCount];
}

@end

#pragma mark - ------------------ UITableView ------------------

@implementation UITableView (Empty)
+ (void)load{
    
    [self exchangeInstanceMethod1:@selector(reloadData) method2:@selector(lzbreloadData)];
    
    ///section
    [self exchangeInstanceMethod1:@selector(insertSections:withRowAnimation:) method2:@selector(lzbinsertSections:withRowAnimation:)];
    [self exchangeInstanceMethod1:@selector(deleteSections:withRowAnimation:) method2:@selector(lzbdeleteSections:withRowAnimation:)];
    [self exchangeInstanceMethod1:@selector(reloadSections:withRowAnimation:) method2:@selector(lzbreloadSections:withRowAnimation:)];
    
    ///row
    [self exchangeInstanceMethod1:@selector(insertRowsAtIndexPaths:withRowAnimation:) method2:@selector(lzbinsertRowsAtIndexPaths:withRowAnimation:)];
    [self exchangeInstanceMethod1:@selector(deleteRowsAtIndexPaths:withRowAnimation:) method2:@selector(lzbdeleteRowsAtIndexPaths:withRowAnimation:)];
    [self exchangeInstanceMethod1:@selector(reloadRowsAtIndexPaths:withRowAnimation:) method2:@selector(lzbreloadRowsAtIndexPaths:withRowAnimation:)];
}
- (void)lzbreloadData{
    [self lzbreloadData];
    [self getDataAndSet];
}
///section
- (void)lzbinsertSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation{
    [self lzbinsertSections:sections withRowAnimation:animation];
    [self getDataAndSet];
}
- (void)lzbdeleteSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation{
    [self lzbdeleteSections:sections withRowAnimation:animation];
    [self getDataAndSet];
}
- (void)lzbreloadSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation{
    [self lzbreloadSections:sections withRowAnimation:animation];
    [self getDataAndSet];
}

///row
- (void)lzbinsertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation{
    [self lzbinsertRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    [self getDataAndSet];
}
- (void)lzbdeleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation{
    [self lzbdeleteRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    [self getDataAndSet];
}
- (void)lzbreloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation{
    [self lzbreloadRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    [self getDataAndSet];
}


@end

#pragma mark - ------------------ UICollectionView ------------------

@implementation UICollectionView (Empty)

+ (void)load{
    
    [self exchangeInstanceMethod1:@selector(reloadData) method2:@selector(lzbreloadData)];
    
    ///section
    [self exchangeInstanceMethod1:@selector(insertSections:) method2:@selector(lzbinsertSections:)];
    [self exchangeInstanceMethod1:@selector(deleteSections:) method2:@selector(lzbdeleteSections:)];
    [self exchangeInstanceMethod1:@selector(reloadSections:) method2:@selector(lzbreloadSections:)];
    
    ///item
    [self exchangeInstanceMethod1:@selector(insertItemsAtIndexPaths:) method2:@selector(lzbinsertItemsAtIndexPaths:)];
    [self exchangeInstanceMethod1:@selector(deleteItemsAtIndexPaths:) method2:@selector(lzbdeleteItemsAtIndexPaths:)];
    [self exchangeInstanceMethod1:@selector(reloadItemsAtIndexPaths:) method2:@selector(lzbreloadItemsAtIndexPaths:)];
    
}
- (void)lzbreloadData{
    [self lzbreloadData];
    [self getDataAndSet];
}
///section
- (void)lzbinsertSections:(NSIndexSet *)sections{
    [self lzbinsertSections:sections];
    [self getDataAndSet];
}
- (void)lzbdeleteSections:(NSIndexSet *)sections{
    [self lzbdeleteSections:sections];
    [self getDataAndSet];
}
- (void)lzbreloadSections:(NSIndexSet *)sections{
    [self lzbreloadSections:sections];
    [self getDataAndSet];
}

///item
- (void)lzbinsertItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths{
    [self lzbinsertItemsAtIndexPaths:indexPaths];
    [self getDataAndSet];
}
- (void)lzbdeleteItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths{
    [self lzbdeleteItemsAtIndexPaths:indexPaths];
    [self getDataAndSet];
}
- (void)lzbreloadItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths{
    [self lzbreloadItemsAtIndexPaths:indexPaths];
    [self getDataAndSet];
}
@end
