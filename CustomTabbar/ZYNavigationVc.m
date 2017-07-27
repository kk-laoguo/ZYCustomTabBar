//
//  ZYNavigationVc.m
//  CustomTabbar
//
//  Created by 今代科技 on 2017/7/26.
//  Copyright © 2017年 GZY. All rights reserved.
//

#import "ZYNavigationVc.h"
#import "HomeViewController.h"

@interface ZYNavigationVc ()

@end

@implementation ZYNavigationVc

- (void)viewDidLoad {
    [super viewDidLoad];
}
/**
 重写这个方法的目的是拦截所有push进来的控制器
 @param viewController 即将push进来的控制器
 @param animated 是否有动画效果
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([viewController isMemberOfClass:[UIViewController class]]) {
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    }
    [super pushViewController:viewController animated:animated];

}
- (void)back {
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    HomeViewController * vc = [[HomeViewController alloc] init];
    ZYNavigationVc *nav = [[ZYNavigationVc alloc] initWithRootViewController:vc];
    vc.title = @"自定义TabBar";
    window.rootViewController = nav;
    [UIView transitionWithView:window duration:2 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
    } completion:^(BOOL finished) {
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
