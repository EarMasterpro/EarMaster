//
//  EMRootViewController.m
//  EarMaster
//
//  Created by 徐艺达 on 15/9/4.
//  Copyright (c) 2015年 EM. All rights reserved.
//

#import "EMRootViewController.h"
#import "PlistResources.h"
#include "TTAlertView.h"
@interface EMRootViewController ()

@end

@implementation EMRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //获取plist 资源eg
    NSString *str = [[PlistResources sharePlist] resourceForKey:@"checkPointNum" theNumber:0];
    TTAlertView *v = [[TTAlertView alloc]initWithTitle:@"dd" contentText:@"dd" leftButtonTitle:nil rightButtonTitle:@"d"];
    v.rightBlock = ^{
        DLog(@"右侧点击时间");
    };
    v.leftBlock =^{
        DLog(@"左侧点击时间");
    };
    [v show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
