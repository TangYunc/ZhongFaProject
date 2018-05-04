//
//  MessageLoginScrollView.h
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/3/1.
//  Copyright © 2018年 中发. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageLoginScrollView : UIScrollView

@property (nonatomic,strong) UIImageView *logoView; // logo
@property (nonatomic,strong) UILabel *phoneNumLbl; // 手机号
@property (nonatomic,strong) UITextField *phoneNumTF;
@property (nonatomic,strong) UIView *firstLine;
@property (nonatomic,strong) UILabel *vfCodeLbl; // 验证码
@property (nonatomic,strong) UITextField *vfCodeTF;
@property (nonatomic,strong) UIView *secondLine;
@property (nonatomic,strong) UIButton *getvfCodeBtn; // 获取验证码按钮
@property (nonatomic,strong) UIButton *pwLoginBtn; // 密码登录按钮
@property (nonatomic,strong) UIButton *loginBtn; // 登录按钮
@property (nonatomic,strong) UIButton *forgetPwBtn; // 忘记密码按钮
@property (nonatomic,strong) UIButton *quickRegisterBtn; // 快速注册按钮
@property (nonatomic,strong) UIImageView *bottomImage; // 底部图案
@property (nonatomic,strong) UIButton *closeBtn; // 关闭按钮
@property (nonatomic,strong) UIView *userView;
@property (nonatomic,strong) UIView *pwdView;
@end
