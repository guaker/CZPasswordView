//
//  PasswordViewController.m
//  CZPasswordView
//
//  Created by chenzhen on 16/4/8.
//  Copyright © 2016年 chenzhen. All rights reserved.
//

#import "PasswordViewController.h"

static NSString *const inputPassword    = @"请输入6位数字查询密码";
static NSString *const retryPassword    = @"查询密码错误，请重试";
static NSString *const setPassword      = @"请设置6位数字查询密码";
static NSString *const setAgainPassword = @"请再次输入6位数字查询密码";
static NSString *const resetPassword    = @"两次密码不一致，请重新设置6位数字查询密码";

//密码输入状态
typedef NS_ENUM(NSInteger, PasswordType) {
    PasswordTypeInput,    //输入密码
    PasswordTypeRetry,    //重试
    PasswordTypeSet,      //设置密码
    PasswordTypeSetAgain, //再次设置密码
    PasswordTypeReset     //重新设置密码
};

@interface PasswordViewController ()

@property (nonatomic, strong) UILabel        *alertLabel;   //提示label
@property (nonatomic, strong) CZPasswordView *passwordView; //密码输入框
@property (nonatomic, strong) UIButton       *resetButton;  //忘记密码
@property (nonatomic, assign) PasswordType   passwordType;  //密码输入状态

@end

@implementation PasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"钱包密码";
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    //提示
    [self.view addSubview:self.alertLabel];
    
    //密码输入框
    [self.view addSubview:self.passwordView];
    
    //忘记密码
    [self.view addSubview:self.resetButton];
    
    //添加约束
    [self addConstraints];
    
    //设置默认值
    self.passwordType = PasswordTypeInput;
}

#pragma mark - CZPasswordViewDelegate
- (void)czPasswordView:(CZPasswordView *)passwordView completedWithPassword:(NSString *)password lastPassword:(NSString *)lastPassword
{
    switch (self.passwordType) {
        case PasswordTypeInput: {
            self.passwordType = PasswordTypeRetry;
            break;
        }
        case PasswordTypeRetry: {
            break;
        }
        case PasswordTypeSet: {
            self.passwordType = PasswordTypeSetAgain;
            break;
        }
        case PasswordTypeSetAgain: {
            if ([password isEqualToString:lastPassword]) {
                [self removePasswordVC];
            } else {
                self.passwordType = PasswordTypeReset;
            }
            break;
        }
        case PasswordTypeReset: {
            self.passwordType = PasswordTypeSetAgain;
            break;
        }
    }
}

#pragma mark - private
- (void)addConstraints
{
    //设置autoLayout
    NSDictionary *viewsDictionary = @{@"alertLabel":self.alertLabel,
                                      @"passwordView":self.passwordView,
                                      @"resetButton":self.resetButton};
    
    //横向约束 Horizontal
    [self.view addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:[passwordView(243.5)]"
                                             options:0
                                             metrics:nil
                                               views:viewsDictionary]];
    
    [self.view addConstraint:
     [NSLayoutConstraint constraintWithItem:self.passwordView
                                  attribute:NSLayoutAttributeCenterX
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.view
                                  attribute:NSLayoutAttributeCenterX
                                 multiplier:1
                                   constant:0]];
    
    [self.view addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:[alertLabel(<=passwordView)]"
                                             options:0
                                             metrics:nil
                                               views:viewsDictionary]];
    
    [self.view addConstraint:
     [NSLayoutConstraint constraintWithItem:self.alertLabel
                                  attribute:NSLayoutAttributeCenterX
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.view
                                  attribute:NSLayoutAttributeCenterX
                                 multiplier:1
                                   constant:0]];
    
    [self.view addConstraint:
     [NSLayoutConstraint constraintWithItem:self.resetButton
                                  attribute:NSLayoutAttributeRight
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.passwordView
                                  attribute:NSLayoutAttributeRight
                                 multiplier:1
                                   constant:6]];
    
    //纵向约束 Vertical
    [self.view addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-192-[passwordView(41)]"
                                             options:0
                                             metrics:nil
                                               views:viewsDictionary]];
    
    [self.view addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:[alertLabel]-12-[passwordView]-7-[resetButton]"
                                             options:0
                                             metrics:nil
                                               views:viewsDictionary]];
}

/**
 *  点击忘记密码
 *
 *  @param sender 按钮
 */
- (void)didResetButton:(UIButton *)sender
{
    self.passwordType = PasswordTypeSet;
}

/**
 *  移除密码输入
 */
- (void)removePasswordVC
{
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

#pragma mark - setter
- (void)setPasswordType:(PasswordType)passwordType
{
    _passwordType = passwordType;
    
    switch (passwordType) {
        case PasswordTypeInput: {
            self.alertLabel.text = inputPassword;
            self.resetButton.hidden = YES;
            break;
        }
        case PasswordTypeRetry: {
            self.alertLabel.text = retryPassword;
            self.resetButton.hidden = NO;
            break;
        }
        case PasswordTypeSet: {
            self.alertLabel.text = setPassword;
            self.resetButton.hidden = YES;
            break;
        }
        case PasswordTypeSetAgain: {
            self.alertLabel.text = setAgainPassword;
            self.resetButton.hidden = YES;
            break;
        }
        case PasswordTypeReset: {
            self.alertLabel.text = resetPassword;
            self.resetButton.hidden = YES;
        }
    }
}

# pragma mark - getter
- (UILabel *)alertLabel
{
    if (_alertLabel == nil) {
        _alertLabel = [[UILabel alloc] init];
        _alertLabel.font = [UIFont systemFontOfSize:17];
        _alertLabel.numberOfLines = 0;
        _alertLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _alertLabel;
}

- (CZPasswordView *)passwordView
{
    if (_passwordView == nil) {
        _passwordView = [[CZPasswordView alloc] init];
        _passwordView.delegate = self;
        _passwordView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _passwordView;
}

- (UIButton *)resetButton
{
    if (_resetButton == nil) {
        _resetButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_resetButton setTitle:@"忘记密码？" forState:UIControlStateNormal];
        [_resetButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_resetButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        _resetButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_resetButton addTarget:self action:@selector(didResetButton:) forControlEvents:UIControlEventTouchUpInside];
        _resetButton.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _resetButton;
}

@end
