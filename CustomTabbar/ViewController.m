//
//  ViewController.m
//  CustomTabbar
//
//  Created by 今代科技 on 2017/7/26.
//  Copyright © 2017年 GZY. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    UIView * view1;
    UIView * view2;
}
@property (nonatomic, strong) UIView * someView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.someView = [[UIView alloc] initWithFrame:CGRectMake(20, 100, 100, 100)];
    self.someView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.someView];
    
    view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    view1.backgroundColor = [UIColor redColor];
    view1.alpha = 0;
    [self.someView addSubview:view1];
    
    view2 = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
    view2.backgroundColor = [UIColor blueColor];
    [self.someView addSubview:view2];
    
    
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [UIView transitionWithView:self.someView duration:2.5 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
        view2.alpha = 0;
        self.someView.center = CGPointMake(200, 400);
        view1.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
  
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
