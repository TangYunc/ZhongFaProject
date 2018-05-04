//
//  MessageLoginScrollView.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/3/1.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "MessageLoginScrollView.h"

@implementation MessageLoginScrollView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame: frame];
    
    if (self) {
        
        [self initUI];
    }
    
    return self;
    
}

- (void)initUI{
    
    self.backgroundColor = BACK_COLOR;
    
    self.logoView = [[UIImageView alloc]init];
    self.logoView.image = [UIImage imageNamed:@"LoginLogoIcon"];
    [self addSubview:self.logoView];
    
    self.userView = [[UIView alloc]init];
    self.userView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.userView];
    
    //    self.phoneNumLbl = [[UILabel alloc]init];
    //    self.phoneNumLbl.image = [UIImage imageNamed:@"账号登录"];
    self.phoneNumLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 58, 41)];
    UIImageView *NumImg = [[UIImageView alloc]initWithFrame:CGRectMake(27, (41-17)/2.0, 14, 17)];
    NumImg.image = [UIImage imageNamed:@"LoginAccountNumIcon"];
    [self.phoneNumLbl addSubview:NumImg];
    //    [self.phoneNumLbl sizeToFit];
    [self.userView addSubview:self.phoneNumLbl];
    
    self.phoneNumTF = [[UITextField alloc]init];
    self.phoneNumTF.leftView = self.phoneNumLbl;
    self.phoneNumTF.leftViewMode = UITextFieldViewModeAlways;
    self.phoneNumTF.placeholder = @"请输入11位手机号";
    self.phoneNumTF.font = [UIFont systemFontOfSize:15];
    self.phoneNumTF.textColor = TEXT_GREY_COLOR;
    self.phoneNumTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.phoneNumTF.keyboardType = UIKeyboardTypePhonePad;
    
    [self.userView addSubview:self.phoneNumTF];
    
    self.firstLine = [[UIView alloc]init];
    self.firstLine.backgroundColor = [UIColor colorWithHexString:@"#ebebeb"];
    [self addSubview:self.firstLine];
    
    self.pwdView = [[UIView alloc]init];
    self.pwdView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.pwdView];
    
    self.vfCodeLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 58, 41)];
    //    self.vfCodeLbl.image = [UIImage imageNamed:@"验证icon"];
    //    [self.vfCodeLbl sizeToFit];
    
    UIImageView *passImg = [[UIImageView alloc]initWithFrame:CGRectMake(27, (41-15)/2.0, 15, 15)];
    passImg.image = [UIImage imageNamed:@"LoginVerificationCodeIcon"];
    [self.vfCodeLbl addSubview:passImg];
    
    [self.pwdView addSubview:self.vfCodeLbl];
    
    
    
    self.vfCodeTF = [[UITextField alloc]init];
    self.vfCodeTF.leftView = self.vfCodeLbl;
    self.vfCodeTF.leftViewMode = UITextFieldViewModeAlways;
    self.vfCodeTF.rightView = self.getvfCodeBtn;
    self.vfCodeTF.rightViewMode = UITextFieldViewModeAlways;
    self.vfCodeTF.placeholder = @"请输入验证码";
    self.vfCodeTF.font = [UIFont systemFontOfSize:15];
    self.vfCodeTF.textColor = TEXT_GREY_COLOR;
    
    self.vfCodeTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.pwdView addSubview:self.vfCodeTF];
    
    self.getvfCodeBtn = [[UIButton alloc]init];
    [self.getvfCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.getvfCodeBtn setTitleColor:[UIColor colorWithHexString:@"#9b9b9b"] forState:UIControlStateNormal];
    self.getvfCodeBtn.layer.cornerRadius = 2;
    self.getvfCodeBtn.layer.borderColor = [UIColor colorWithHexString:@"#9b9b9b"].CGColor;
    self.getvfCodeBtn.layer.borderWidth = 1;
    self.getvfCodeBtn.layer.masksToBounds = YES;
    self.getvfCodeBtn.titleLabel.font  = [UIFont systemFontOfSize:11];
    //    self.getvfCodeBtn.backgroundColor =[UIColor redColor];
    [self.pwdView addSubview:self.getvfCodeBtn];
    
    
    self.secondLine = [[UIView alloc]init];
    self.secondLine.backgroundColor = [UIColor colorWithHexString:@"#787878"];
    [self addSubview:self.secondLine];
    
    self.pwLoginBtn = [[UIButton alloc]init];
    [self.pwLoginBtn setTitle:@"会员登录 >" forState:UIControlStateNormal];
    [self.pwLoginBtn setTitleColor:TEXT_GREY_COLOR forState:UIControlStateNormal];
    self.pwLoginBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    //    self.pwLoginBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    self.pwLoginBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    //    _pwLoginBtn.backgroundColor = [UIColor redColor];
    [self addSubview:self.pwLoginBtn];
    
    self.loginBtn = [[UIButton alloc]init];
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.loginBtn setBackgroundColor:BLUE_COLOR];
    self.loginBtn.alpha = 0.5;
    self.loginBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    //    [self.loginBtn setBackgroundColor:[UIColor colorWithHexString:@"#9b9b9b"]];
    self.loginBtn.layer.cornerRadius = 3;
    self.loginBtn.layer.masksToBounds = YES;
    [self addSubview:self.loginBtn];
    
    self.forgetPwBtn = [[UIButton alloc]init];
    [self.forgetPwBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [self.forgetPwBtn setTitleColor:[UIColor colorWithHexString:@"8c8c8c"] forState:UIControlStateNormal];
    self.forgetPwBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:self.forgetPwBtn];
    
    self.quickRegisterBtn = [[UIButton alloc]init];
    [self.quickRegisterBtn setTitle:@"快速注册" forState:UIControlStateNormal];
    [self.quickRegisterBtn setTitleColor:[UIColor colorWithHexString:@"8c8c8c"] forState:UIControlStateNormal];
    self.quickRegisterBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:self.quickRegisterBtn];
    
    self.bottomImage = [[UIImageView alloc]init];
    self.bottomImage.image = [UIImage imageNamed:@"bottom"];
    [self addSubview:self.bottomImage];
    
    self.closeBtn = [[UIButton alloc]init];
    [self.closeBtn setBackgroundImage:[UIImage imageNamed:@"chahao_"] forState:UIControlStateNormal];
    [self addSubview:self.closeBtn];
    
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self.logoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(108*WIDTH, 108*WIDTH));
        make.top.equalTo(@(53*HEIGHT));
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    [self.pwLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-18);
        make.top.mas_equalTo(self.logoView.mas_bottom).offset(24*HEIGHT);
        make.height.mas_equalTo(@17);
        make.width.mas_equalTo(@120);
    }];
    
    [self.userView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 41));
        make.top.mas_equalTo(self.pwLoginBtn.mas_bottom).offset(HEIGHT*10);
        make.left.mas_equalTo(@0);
    }];
    [self.pwLoginBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.userView.mas_right).offset(-18);
    }];
    [self.phoneNumTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(20));
        make.left.mas_equalTo(self.userView.mas_left);
        make.right.mas_equalTo(self.userView.mas_right).offset(-18);
        make.centerY.equalTo(self.userView.mas_centerY);
    }];
    
    //    [self.phoneNumLbl mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.size.mas_equalTo(CGSizeMake(14, 17));
    //        make.left.equalTo(self.phoneNumTF.mas_left);
    //        make.centerY.equalTo(self.userView.mas_centerY);
    //    }];
    
    [self.firstLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(kScreenWidth));
        make.height.equalTo(@1);
        make.top.equalTo(self.userView.mas_bottom);
        make.centerX.equalTo(self.userView.mas_centerX);
    }];
    
    [self.pwdView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(self.userView);
        make.top.mas_equalTo(self.userView.mas_bottom).offset(1);
        make.left.mas_equalTo(self.userView.mas_left);
    }];
    
    
    [self.vfCodeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(20));
        make.left.mas_equalTo(self.phoneNumTF.mas_left);
        //        make.right.mas_equalTo(self.phoneNumTF.mas_right).offset(-68);
        make.width.mas_equalTo(@180);
        make.centerY.equalTo(self.pwdView.mas_centerY);
    }];
    
    //    [self.vfCodeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.size.mas_equalTo(CGSizeMake(15, 15));
    //        make.left.equalTo(self.vfCodeTF.mas_left);
    //        make.centerY.equalTo(self.pwdView.mas_centerY);
    //    }];
    
    [self.getvfCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(73, 26));
        make.right.equalTo(self.pwdView.mas_right).offset(-17);
        make.top.equalTo(self.vfCodeTF.mas_top);
    }];
    
    //    [self.secondLine mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.width.equalTo(self.vfCodeTF);
    //        make.height.equalTo(@1);
    //        make.top.equalTo(self.vfCodeTF.mas_bottom).offset(-1);
    //        make.centerX.equalTo(self.vfCodeTF.mas_centerX);
    //    }];
    
    
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pwdView.mas_bottom).offset(34*HEIGHT);
        make.centerX.equalTo(self.mas_centerX);
        make.height.equalTo(@35);
        make.width.equalTo(@(kScreenWidth-36));
    }];
    
    //    [self.forgetPwBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.equalTo(self.loginBtn.mas_bottom).offset(10*HEIGHT);
    //        make.left.equalTo(self.loginBtn.mas_left);
    //    }];
    //
    //    [self.quickRegisterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.equalTo(self.loginBtn.mas_bottom).offset(10*HEIGHT);
    //        make.right.equalTo(self.loginBtn.mas_right);
    //    }];
    //
    //    [self.bottomImage mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.size.mas_equalTo(CGSizeMake(screenWidth, screenWidth*160/375));
    //        make.bottom.equalTo(@(screenHeight));
    //    }];
    
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(12, 12));
        make.top.equalTo(self.mas_top).offset(10);
        make.right.equalTo(@(kScreenWidth-10));
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}

@end
