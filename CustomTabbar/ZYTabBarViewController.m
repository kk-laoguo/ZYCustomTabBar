//
//  ZYTabBarViewController.m
//  CustomTabbar
//
//  Created by 今代科技 on 2017/7/26.
//  Copyright © 2017年 GZY. All rights reserved.
//

#import "ZYTabBarViewController.h"
#import "ZYTabbar.h"
#import "ViewController.h"
#import "ZYNavigationVc.h"
@interface ZYTabBarViewController () <ZYTabBarDelegate,UITabBarControllerDelegate,UITabBarDelegate>

@end

@implementation ZYTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //tabBar背景颜色
    [UITabBar appearance].barTintColor = [UIColor whiteColor];
    //是否是半透明效果
    [UITabBar appearance].translucent = NO;
    
//    ZYTabbar * tabbar = [[ZYTabbar alloc] init];
//    tabbar.ZYDelegate = self;
//    self.delegate = self;
//    //注意：因为是系统的tabBar是readonly的，所以用KVO方法替换
//    if (self.tabBarType == typeTwo) {
//        [self setValue:tabbar forKey:@"tabBar"];
//    }
//    [self setupAllChildViewControllers];
}
- (void)setTabBarType:(TabBarType)tabBarType {
    _tabBarType = tabBarType;
    ZYTabbar * tabbar = [[ZYTabbar alloc] init];
    tabbar.ZYDelegate = self;
    self.delegate = self;
    //注意：因为是系统的tabBar是readonly的，所以用KVC方法替换
    if (self.tabBarType == typeTwo) {
        [self setValue:tabbar forKey:@"tabBar"];
    }else if (self.tabBarType == typeThree) {
        tabbar.isCircle = YES;
        [self setValue:tabbar forKey:@"tabBar"];
    }
    [self setupAllChildViewControllers];

}
#pragma mark - custom method
// 初始化所有的子控制器
- (void)setupAllChildViewControllers {
    // 1.ONE
    UIViewController *one = [[UIViewController alloc] init];
    one.view.backgroundColor = [UIColor whiteColor];
    [self addChildViewController:one  title:@"首页" imageName:@"tabbar_news" selectedImageName:@"tabbar_news_hl"];
    
    // 2.TWO
    UIViewController *two = [[UIViewController alloc] init];
    two.view.backgroundColor = [UIColor magentaColor];
    [self addChildViewController:two title:@"图片" imageName:@"tabbar_picture" selectedImageName:@"tabbar_picture_hl"];
    
  
    if (self.tabBarType == typeOne) {
        // 2.publishButton
        UIViewController *publish = [[UIViewController alloc] init];
        publish.view.backgroundColor = [UIColor blueColor];
        two.view.backgroundColor = [UIColor magentaColor];
        [self addChildViewController:publish title:@"publish" imageName:@"tabbar_write" selectedImageName:@"tabbar_write"];
    }
    
    // 3.THREE
    UIViewController *three = [[UIViewController alloc] init];
    three.view.backgroundColor = [UIColor cyanColor];
    [self addChildViewController:three title:@"精华" imageName:@"tabbar_video" selectedImageName:@"tabbar_video_hl"];
    
    // 4.FOUR
    UIViewController *four = [[UIViewController alloc] init];
    four.view.backgroundColor = [UIColor yellowColor];
    [self addChildViewController:four title:@"我的" imageName:@"tabbar_setting" selectedImageName:@"tabbar_setting_hl"];
}

/**
 *  初始化一个子控制器
 *
 *  @param childVc           需要初始化的子控制器
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中的图标
 */
- (void)addChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName {
    // 1.设置控制器的属性
    childVc.title = title;
    // 设置图标
    childVc.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 设置选中的图标
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [childVc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont systemFontOfSize:13.f]} forState:UIControlStateSelected];

    //方式一 (self.tabBarType == typeOne) 只有图片没有文字tabbar
    if ([title isEqualToString:@"publish"]) {
        //tabBar图片居中显示，不显示文字
        childVc.title = @"";
        childVc.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    }
    // 2.包装一个导航控制器
    ZYNavigationVc *nav = [[ZYNavigationVc alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
}
#pragma mark -- ZYTabBarDelegate 
- (void)tabBarDidClickPlusButton {
    [self presentViewController:[[ViewController alloc] init] animated:YES completion:nil];
}
#pragma mark -- UITabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    return YES;
}
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    NSMutableArray * tabbarArr = [NSMutableArray array];
    NSInteger index = [self.tabBar.items indexOfObject:item];
 
    for (UIView *subview in tabBar.subviews) {
        if ([subview isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabbarArr addObject:subview];
        }
    }
    
    UIView * tabbarBtn = tabbarArr[index];
    for (UIView * imgV in tabbarBtn.subviews) {
        if ([imgV isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
           
            CABasicAnimation*pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            pulse.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            pulse.duration = 0.2;
            pulse.repeatCount= 1;
            pulse.autoreverses= YES;
            pulse.fromValue= [NSNumber numberWithFloat:0.7];
            pulse.toValue= [NSNumber numberWithFloat:1.3];
            [imgV.layer
             addAnimation:pulse forKey:nil];
        }
    }
    
//    for (UIView * item in tabbarArr[index]) {
//        
//        if ([item isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
//            
//            [UIView animateWithDuration:0.15 delay:0 usingSpringWithDamping:1 initialSpringVelocity:9.8 options:0 animations:^{
//                item.transform = CGAffineTransformMakeScale(0.7, 0.7);
//            } completion:^(BOOL finished) {
//                [UIView animateWithDuration:0.15 animations:^{
//                    item.transform = CGAffineTransformMakeScale(1.3, 1.3);
//                } completion:^(BOOL finished) {
//                    [UIView animateWithDuration:0.15 animations:^{
//                        item.transform = CGAffineTransformIdentity;
//                    }];
//                }];
//                
//            }];
//        }
//    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
