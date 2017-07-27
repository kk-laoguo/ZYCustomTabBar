//
//  HomeViewController.m
//  CustomTabbar
//
//  Created by 今代科技 on 2017/7/26.
//  Copyright © 2017年 GZY. All rights reserved.
//

#import "HomeViewController.h"
#import "ZYTabBarViewController.h"

@interface HomeViewController ()
@property (nonatomic, strong) NSArray   * titleArr;
@property (nonatomic, strong) NSArray   * cellArr;

@end

@implementation HomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleArr = @[@"typeOne",@"typeTwo",@"typeThree"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    self.tableView.tableFooterView = [UIView new];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
    cell.textLabel.text = self.titleArr[indexPath.row];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    ZYTabBarViewController * tabVc = [[ZYTabBarViewController alloc] init];
    tabVc.tabBarType = indexPath.row;
    window.rootViewController = tabVc;
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:2];
//    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:window cache:YES];
//    //设置动画淡入淡出
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//    [UIView commitAnimations];

    [UIView transitionWithView:window duration:2 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        window.backgroundColor = [UIColor whiteColor];

    } completion:^(BOOL finished) {
        window.backgroundColor = [UIColor whiteColor];

    }];


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
