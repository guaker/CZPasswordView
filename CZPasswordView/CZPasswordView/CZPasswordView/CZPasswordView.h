//
//  CZPasswordView.h
//  doctor
//
//  Created by chenzhen on 16/4/1.
//  Copyright © 2016年 chenzhen. All rights reserved.
//

/**
 *  我的钱包密码输入框
 */
#import <UIKit/UIKit.h>
@protocol CZPasswordViewDelegate;

/**
 *  输入框
 */
@interface PasswordTextField : UITextField

@end

/**
 *  CZPasswordView
 */
@interface CZPasswordView : UIView

@property (nonatomic, weak) id<CZPasswordViewDelegate> delegate;
@property (nonatomic, strong) PasswordTextField *textFiled; //输入框

@end

/**
 *  代理
 */
@protocol CZPasswordViewDelegate <NSObject>

/**
 *  密码输入完成回调
 *
 *  @param passwordView CZPasswordView
 *  @param password     本次输入密码
 *  @param lastPassword 上次输入密码
 */
- (void)czPasswordView:(CZPasswordView *)passwordView
 completedWithPassword:(NSString *)password
          lastPassword:(NSString *)lastPassword;

@end
