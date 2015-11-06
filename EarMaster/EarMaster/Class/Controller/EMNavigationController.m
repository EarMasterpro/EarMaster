//
//  EMNavigationController.m
//  EarMaster
//
//  Created by 徐艺达 on 15/9/4.
//  Copyright (c) 2015年 EM. All rights reserved.
//

#import "EMNavigationController.h"



@interface EMNavigationController ()

@end

@implementation EMNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.hidden = YES;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    viewController.hidesBottomBarWhenPushed = YES;
    [super pushViewController:viewController animated:animated];
}

@end
