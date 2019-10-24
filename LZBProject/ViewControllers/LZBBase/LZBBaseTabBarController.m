//
//  LZBBaseTabBarController.m
//  LZBProject
//
//  Created by hicity on 2019/10/21.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "LZBBaseTabBarController.h"
#import "LZBBaseNavigationController.h"

#define KStoryBoardHomeVC    @"Home"
#define KStoryBoardCTBVC     @"CTB"
#define KSroryBoardMineVC    @"Mine"

#define KStoryBoardHomeVCTitle    @"首页"
#define KStoryBoardCTBVCTitle     @"错题本"
#define KSroryBoardMineVCTitle    @"我的"

@interface LZBBaseTabBarController ()<UINavigationControllerDelegate>

@property (nonatomic, strong) NSMutableArray *normalImageArray;

@property (nonatomic, strong) NSMutableArray *selectedImageArray;

@property (nonatomic, strong) NSArray        *controllerIdentiferArray;

@end

@implementation LZBBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self confgiSubControllers];
    
    [self configTabbar];
    
    // Do any additional setup after loading the view.
}

- (void)confgiSubControllers{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    [self.controllerIdentiferArray enumerateObjectsUsingBlock:^(NSString *identifier, NSUInteger idx, BOOL * _Nonnull stop) {
        LZBBaseNavigationController *navi = [self navigationControllerWithIdentifier:identifier];
        navi.delegate = self;
        [arr addObject:navi];
    }];
    self.viewControllers = arr;
}

- (void)configTabbar{
    
    
//    self.tabBarItem.imageInsets = UIEdgeInsetsMake(0, 0, -6,0);
//    //设置文字位置
//     [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0, -2.5)];
//    self.tabBarItem.imageInsets = UIEdgeInsetsMake(-6, 0, 6, 0);
    
    UITabBar *tabBar = self.tabBar;
    
    UITabBarItem *item0 = [tabBar.items objectAtIndex:0];
    UITabBarItem *item1 = [tabBar.items objectAtIndex:1];
    UITabBarItem *item2 = [tabBar.items objectAtIndex:2];

    item0.selectedImage = [[self.selectedImageArray objectAtIndex:0] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item0.title = KStoryBoardHomeVCTitle;
    item0.image = [[self.normalImageArray objectAtIndex:0] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    item1.title = KStoryBoardCTBVCTitle;
    item1.selectedImage = [[self.selectedImageArray objectAtIndex:1] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item1.image = [[self.normalImageArray objectAtIndex:1] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    item2.title = KSroryBoardMineVCTitle;
    item2.image = [[self.normalImageArray objectAtIndex:2] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item2.selectedImage = [[self.selectedImageArray objectAtIndex:2] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

}

- (LZBBaseNavigationController *)navigationControllerWithIdentifier:(NSString *)identifier{
    LZBBaseNavigationController *nav = [[UIStoryboard storyboardWithName:identifier bundle:nil] instantiateInitialViewController];
    return nav;
}

- (NSArray *)controllerIdentiferArray{
    if (!_controllerIdentiferArray) {
        _controllerIdentiferArray = @[KStoryBoardHomeVC,KStoryBoardCTBVC,KSroryBoardMineVC];
    }
    return _controllerIdentiferArray;
}

- (NSMutableArray *)normalImageArray{
    if (!_normalImageArray) {
        _normalImageArray = [[NSMutableArray alloc] initWithObjects:IMAGE_NAMED(@"tanchuang_xuangzeriqi_xiangqian_normal"),IMAGE_NAMED(@"bg_homepage"),IMAGE_NAMED(@"bg_homepage"), nil];
    }
    return _normalImageArray;
}

- (NSMutableArray *)selectedImageArray{
    if (!_selectedImageArray) {
        _selectedImageArray = [[NSMutableArray alloc] initWithObjects:IMAGE_NAMED(@"bg_homepage"),IMAGE_NAMED(@"tanchuang_xuangzeriqi_xiangqian_normal"),IMAGE_NAMED(@"tanchuang_xuangzeriqi_xiangqian_normal"), nil];
    }
    return _selectedImageArray;
}

- (void)insertSubView:(UIView *)view atIndex:(NSInteger)index{
    
    UIView*tabbarBgView =[[UIView alloc]initWithFrame:CGRectMake(0,0,self.tabBar.frame.size.width,self.tabBar.frame.size.height)];
    tabbarBgView.backgroundColor=[UIColor redColor];
    [self.tabBar insertSubview:tabbarBgView atIndex:0];
    
    CGSize indicatorImageSize=CGSizeMake(self.tabBar.bounds.size.width/5-10,self.tabBar.bounds.size.height);
    
    self.tabBar.selectionIndicatorImage=[self drawTabBarItemBackgroundUmageWithSize:indicatorImageSize];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:KMAINFFFF,NSForegroundColorAttributeName,[UIFont lzb_fontForPingFangSC_RegularFontOfSize:12],NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    self.tabBar.selectionIndicatorImage=[self drawTabBarItemBackgroundUmageWithSize:indicatorImageSize];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor],NSForegroundColorAttributeName,[UIFont lzb_fontForPingFangSC_RegularFontOfSize:12],NSFontAttributeName, nil] forState:UIControlStateSelected];
    
}

-(UIImage*)drawTabBarItemBackgroundUmageWithSize:(CGSize)size{
    UIGraphicsBeginImageContext(size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(ctx, 1, 1, 1, 1);
    CGContextFillRect(ctx, CGRectMake(5, 0, size.width, size.height));
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    CGContextAddEllipseInRect(ctx, rect);
    CGContextClip(ctx);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    [image drawInRect:rect];
    
    UIGraphicsEndImageContext();
    return  image;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
