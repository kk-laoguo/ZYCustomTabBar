//
//  ZYTabbar.h
//  CustomTabbar
//
//  Created by 今代科技 on 2017/7/26.
//  Copyright © 2017年 GZY. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ZYTabBarDelegate <NSObject>
@optional
- (void)tabBarDidClickPlusButton;
@end

@interface ZYTabbar : UITabBar
//这里最好别用delegate,防止系统的delegate冲突
@property (nonatomic, assign) id<ZYTabBarDelegate>ZYDelegate;
//中间是否为圆形凸起tabbar
@property (nonatomic, assign) BOOL isCircle;
@end
