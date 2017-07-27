//
//  ZYTabBarViewController.h
//  CustomTabbar
//
//  Created by 今代科技 on 2017/7/26.
//  Copyright © 2017年 GZY. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, TabBarType) {
    typeOne = 0,
    typeTwo = 1,
    typeThree = 2
};

@interface ZYTabBarViewController : UITabBarController
@property (nonatomic, assign) TabBarType tabBarType;
@end
