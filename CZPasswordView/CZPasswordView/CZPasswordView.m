//
//  CZPasswordView.m
//  doctor
//
//  Created by chenzhen on 16/4/1.
//  Copyright © 2016年 chenzhen. All rights reserved.
//

#import "CZPasswordView.h"

#define ITEM_SIZE 40

@implementation PasswordTextField

//禁用手势
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return NO;
}

@end

@interface CZPasswordView ()
{
    NSString *_lastPassword;
}

@end

@implementation CZPasswordView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [UIColor blackColor].CGColor;
        
        //分割线
        for (int i = 1; i < 6; i ++) {
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake((ITEM_SIZE + 0.5) * i, 0.5, 0.5, ITEM_SIZE)];
            lineView.backgroundColor = [UIColor blackColor];
            [self addSubview:lineView];
        }
        
        //输入框
        self.textFiled = [[PasswordTextField alloc] initWithFrame:self.bounds];
        self.textFiled.tintColor = [UIColor clearColor];
        self.textFiled.textColor = [UIColor clearColor];
        self.textFiled.keyboardType = UIKeyboardTypeNumberPad;
        [self.textFiled addTarget:self action:@selector(textFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
        [self addSubview:self.textFiled];
        
        //打开键盘
        [self.textFiled becomeFirstResponder];
    }
    return self;
}

//重写drawRect方法
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //绘制圆
    for (int i = 0; i < self.textFiled.text.length; i++) {
        CGRect frame = CGRectMake((ITEM_SIZE + 0.5) * i + 0.5 + (ITEM_SIZE / 2 - 8), 0.5 + (ITEM_SIZE / 2 - 8), 16, 16);
        CGContextAddEllipseInRect(context, frame);
        [[UIColor blackColor] set];
        CGContextFillPath(context);
    }
}

#pragma mark - private
/**
 *  输入框文字改变
 *
 *  @param sender 输入框
 */
- (void)textFieldEditingChanged:(UITextField *)sender
{
    [self setNeedsDisplay];
    
    NSString *password = sender.text;
    
    if (password.length == 6) {
        if ([_delegate respondsToSelector:@selector(czPasswordView:completedWithPassword:lastPassword:)]) {
            [_delegate czPasswordView:self completedWithPassword:password lastPassword:_lastPassword];
        }
        
        //设置上一次密码
        _lastPassword = password;
        
        //清空密码
        sender.text = nil;
    }
}

@end
