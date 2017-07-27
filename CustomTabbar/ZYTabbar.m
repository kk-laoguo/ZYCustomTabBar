//
//  ZYTabbar.m
//  CustomTabbar
//
//  Created by 今代科技 on 2017/7/26.
//  Copyright © 2017年 GZY. All rights reserved.
//

#import "ZYTabbar.h"


@interface ZYTabbar ()
@property (nonatomic, strong) UIButton * publishButton;
@property (nonatomic, strong) UILabel  * label;


@end
@implementation ZYTabbar
- (void)layoutSubviews {
    [super layoutSubviews];
    //按钮的尺寸
    CGFloat buttonW = self.frame.size.width/5.0;
    CGFloat buttonH = self.frame.size.height;
    
    self.publishButton.center = CGPointMake(self.frame.size.width * 0.5, buttonH * 0.5);
    //中间凸起tabBar
    if (_isCircle) {
        self.publishButton.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height/2.0 - 20);
        self.label.center = CGPointMake(self.publishButton.center.x, CGRectGetMaxY(self.publishButton.frame)+10);
    }
    //按钮索引
    NSInteger tabbarIndex = 0;
    for (UIView * subview in self.subviews) {
        if ([subview isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            subview.frame = CGRectMake(tabbarIndex * buttonW, 0, buttonW, buttonH);
            tabbarIndex ++;
            //把中间的按钮位置预留出来
            if (tabbarIndex == 2) {
                tabbarIndex ++;
            }
        }
    }
}
- (void)publishClick {
    if ([self.ZYDelegate respondsToSelector:@selector(tabBarDidClickPlusButton)]) {
        [self.ZYDelegate tabBarDidClickPlusButton];
    }
}
//重写hitTest方法，去监听发布按钮的点击，目的是为了让凸出的部分点击也有反应
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    //这一个判断是关键，不判断的话push到其他页面，点击发布按钮的位置也是会有反应的，这样就不好了
    //self.isHidden == NO 说明当前页面是有tabbar的，那么肯定是在导航控制器的根控制器页面
    //在导航控制器根控制器页面，那么我们就需要判断手指点击的位置是否在发布按钮身上
    //是的话让发布按钮自己处理点击事件，不是的话让系统去处理点击事件就可以了
    if (self.isHidden == NO) {
        
        //将当前tabbar的触摸点转换坐标系，转换到发布按钮的身上，生成一个新的点
        CGPoint newPoint = [self convertPoint:point toView:self.publishButton];
        
        //判断如果这个新的点是在发布按钮身上，那么处理点击事件最合适的view就是发布按钮
        if ( [self.publishButton pointInside:newPoint withEvent:event]) {
            return self.publishButton;
        }else{
            //如果点不在发布按钮身上，直接让系统处理就可以了
            return [super hitTest:point withEvent:event];
        }
    }
    
    else {
        //tabbar隐藏了，那么说明已经push到其他的页面了，这个时候还是让系统去判断最合适的view处理就好了
        return [super hitTest:point withEvent:event];
    }
}
#pragma mark -- setter 
- (void)setIsCircle:(BOOL)isCircle {
    _isCircle = isCircle;
    if (isCircle) {
        [self.publishButton setBackgroundImage:[UIImage imageNamed:@"post_normal"] forState:UIControlStateNormal];
        [self.publishButton setBackgroundImage:[UIImage imageNamed:@"post_normal"] forState:UIControlStateHighlighted];
        self.publishButton.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height/2.0 - 20);
        self.label.center = CGPointMake(self.publishButton.center.x, CGRectGetMaxY(self.publishButton.frame)+10);
        [self addSubview:self.label];
    }
}
#pragma mark -- geter
#pragma mark -- lazy --
- (UIButton *)publishButton {
    if (!_publishButton) {
        _publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_publishButton setImage:[UIImage imageNamed:@"tabbar_write"] forState:UIControlStateNormal];
//        [_publishButton setImage:[UIImage imageNamed:@"tabbar_write"] forState:UIControlStateHighlighted];
        [_publishButton setBackgroundImage:[UIImage imageNamed:@"tabbar_write"] forState:UIControlStateNormal];
        [_publishButton setBackgroundImage:[UIImage imageNamed:@"tabbar_write"] forState:UIControlStateHighlighted];
        [_publishButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _publishButton.bounds = CGRectMake(0, 0, _publishButton.currentBackgroundImage.size.width, _publishButton.currentBackgroundImage.size.height);
        // 发布按钮的点击事件
        [_publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_publishButton];
    }
    return _publishButton;
}
- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.font = [UIFont systemFontOfSize:10.f];
        _label.text = @"发布";

        [_label sizeToFit];
        _label.textColor = [UIColor lightGrayColor];
    }
    return _label;
}
@end
