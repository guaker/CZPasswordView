//
//  ViewController.m
//  CZPasswordView
//
//  Created by chenzhen on 16/4/8.
//  Copyright © 2016年 chenzhen. All rights reserved.
//

#import "ViewController.h"
#import "PasswordViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的钱包";
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    PasswordViewController *passwordVC = [[PasswordViewController alloc] init];
    passwordVC.view.frame = self.view.bounds;
    [self.view addSubview:passwordVC.view];
    [self addChildViewController:passwordVC];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
