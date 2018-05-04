//
//  AccountAndPWLognScrollView.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/3/1.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "AccountAndPWLognScrollView.h"

@implementation AccountAndPWLognScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //初始化UI
        [self initUI];
//        self.isSecurtBtnSelected = NO;
        // 监听键盘变化
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChanged:) name:UIKeyboardWillChangeFrameNotification object:nil];
        // 增加一个键盘监听方法（为了能够在键盘弹起完成后，让视图内容滚动）
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidChanged) name:UIKeyboardDidChangeFrameNotification object:nil];
    }
    return self;
}

//初始化子视图
- (void)initUI{
    
    self.backgroundColor = BACK_COLOR;
    
    self.logoView = [[UIImageView alloc]init];
    self.logoView.image = [UIImage imageNamed:@"LoginLogoIcon"];
    [self addSubview:self.logoView];
    
    self.userView = [[UIView alloc]init];
    self.userView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.userView];
    
    self.phoneNumLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 58, 41)];
    UIImageView *NumImg = [[UIImageView alloc]initWithFrame:CGRectMake(27, (41-17)/2.0, 14, 17)];
    NumImg.image = [UIImage imageNamed:@"LoginAccountNumIcon"];
    [self.phoneNumLbl addSubview:NumImg];
    
    [self.userView addSubview:self.phoneNumLbl];
    
    self.phoneNumTF = [[UITextField alloc]init];
    self.phoneNumTF.leftView = self.phoneNumLbl;
    self.phoneNumTF.leftViewMode = UITextFieldViewModeAlways;
    self.phoneNumTF.placeholder = @"用户名/手机号/邮箱";
    self.phoneNumTF.font = [UIFont systemFontOfSize:15];
    self.phoneNumTF.textColor = TEXT_GREY_COLOR;
    self.phoneNumTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    //    self.phoneNumTF.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneNumTF.returnKeyType = UIReturnKeyNext;
    [self.userView addSubview:self.phoneNumTF];
    
    self.firstLine = [[UIView alloc]init];
    self.firstLine.backgroundColor = [UIColor colorWithHexString:@"#ebebeb"];
    [self addSubview:self.firstLine];
    
    self.pwdView = [[UIView alloc]init];
    self.pwdView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.pwdView];
    
    self.passWdLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 58, 41)];
    UIImageView *passImg = [[UIImageView alloc]initWithFrame:CGRectMake(27, (41-17)/2.0, 14, 17)];
    passImg.image = [UIImage imageNamed:@"LoginPWNumIcon"];
    [self.passWdLbl addSubview:passImg];
    
    [self.pwdView addSubview:self.passWdLbl];
    
    //    self.passWdTF = [[UITextField alloc]init];
    self.passWdTF = [[UITextField alloc]init];
    self.passWdTF.leftView = self.passWdLbl;
    self.passWdTF.leftViewMode = UITextFieldViewModeAlways;
    self.passWdTF.rightView = self.pwVisibleBtn;
    self.passWdTF.rightViewMode = UITextFieldViewModeAlways;
    self.passWdTF.placeholder = @"请输入密码";
    self.passWdTF.font = [UIFont systemFontOfSize:15];
    self.passWdTF.secureTextEntry = YES;
    self.passWdTF.textColor = TEXT_GREY_COLOR;
    self.passWdTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.pwdView addSubview:self.passWdTF];
    
    //    self.secondLine = [[UIView alloc]init];
    //    self.secondLine.backgroundColor = [UIColor colorWithHexString:@"#b4b4b4"];
    //    [self.scrollView addSubview:self.secondLine];
    
    
    self.pwVisibleBtn = [[UIButton alloc]init];
    self.pwVisibleBtn.titleLabel.font = [UIFont fontWithName:IconFont size:26];
    //    [self.pwVisibleBtn setTitle:@"\U0000e607" forState:UIControlStateNormal];
    [self.pwVisibleBtn setImage:[UIImage imageNamed:@"LoginSecurtEyeIcon"] forState:UIControlStateNormal];
    [self.pwVisibleBtn sizeToFit];
    [self.pwdView addSubview:self.pwVisibleBtn];
    
    self.vfLoginBtn = [[UIButton alloc]init];
    [self.vfLoginBtn setTitle:@"使用验证码登录 >" forState:UIControlStateNormal];
    [self.vfLoginBtn setTitleColor:TEXT_GREY_COLOR forState:UIControlStateNormal];
    self.vfLoginBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    //    self.vfLoginBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    self.vfLoginBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    //    [self.vfLoginBtn sizeToFit];
    [self addSubview:self.vfLoginBtn];
    
    //    self.rememberPwBtn = [[UIButton alloc]init];
    //    self.rememberPwBtn.layer.borderColor = [UIColor colorWithHexString:@"#a0a0a0"].CGColor;
    //    self.rememberPwBtn.layer.borderWidth = 1;
    //    self.rememberPwBtn.layer.masksToBounds = YES;
    //    [self.scrollView addSubview:self.rememberPwBtn];
    //
    //    self.rememberPwLbl = [[UILabel alloc]init];
    //    self.rememberPwLbl.text = @"记住密码";
    //    self.rememberPwLbl.textColor = [UIColor colorWithHexString:@"#a0a0a0"];
    //    self.rememberPwLbl.font = [UIFont systemFontOfSize:9];
    //    [self.scrollView addSubview: self.rememberPwLbl];
    
    self.loginBtn = [[UIButton alloc]init];
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.loginBtn setBackgroundColor:[UIColor colorWithHexString:@"#9b9b9b"]];
    self.loginBtn.alpha = 0.5;
    self.loginBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    self.loginBtn.layer.cornerRadius = 3;
    self.loginBtn.layer.masksToBounds = YES;
    [self addSubview:self.loginBtn];
    
    self.forgetPwBtn = [[UIButton alloc]init];
    [self.forgetPwBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [self.forgetPwBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.forgetPwBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:self.forgetPwBtn];
    
    self.quickRegisterBtn = [[UIButton alloc]init];
    [self.quickRegisterBtn setTitle:@"注册新账号" forState:UIControlStateNormal];
    [self.quickRegisterBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.quickRegisterBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:self.quickRegisterBtn];
    
    //    self.bottomImage = [[UIImageView alloc]init];
    //    self.bottomImage.image = [UIImage imageNamed:@"bottom"];
    //    [self.scrollView addSubview:self.bottomImage];
    
    
    //右上角关闭按钮
    self.closeBtn = [[UIButton alloc]init];
    [self.closeBtn setBackgroundImage:[UIImage imageNamed:@"chahao_"] forState:UIControlStateNormal];
    [self addSubview:self.closeBtn];
    /*
    //  第三方 登录
    self.QQbutton = [[UIButton alloc]init];
    [self.QQbutton setBackgroundImage:[UIImage imageNamed:@"ShareQQIcon"] forState:UIControlStateNormal];
    self.QQbutton.layer.masksToBounds = YES;
    self.QQbutton.layer.cornerRadius = 35/2.0;
    [self addSubview:self.QQbutton];
    
    self.WXbutton = [[UIButton alloc]init];
    [self.WXbutton setBackgroundImage:[UIImage imageNamed:@"ShareWechatIcon"] forState:UIControlStateNormal];
    self.WXbutton.layer.masksToBounds = YES;
    self.WXbutton.layer.cornerRadius = 35/2.0;
    [self addSubview:self.WXbutton];
    
    self.sinaButton = [[UIButton alloc]init];
    [self.sinaButton setBackgroundImage:[UIImage imageNamed:@"ShareWeiBoIcon"] forState:UIControlStateNormal];
    self.sinaButton.layer.masksToBounds = YES;
    self.sinaButton.layer.cornerRadius = 35/2.0;
    [self addSubview:self.sinaButton];
    
    self.leftThirdLbl = [[UILabel alloc]init];
    self.leftThirdLbl.backgroundColor = TEXT_GREY_COLOR;
    [self addSubview:self.leftThirdLbl];
    
    self.rightThirdLbl = [[UILabel alloc]init];
    self.rightThirdLbl.backgroundColor = TEXT_GREY_COLOR;
    [self addSubview:self.rightThirdLbl];
    
    self.titleThirdLbl = [[UILabel alloc]init];
    self.titleThirdLbl.text = @"第三方登录";
    self.titleThirdLbl.textAlignment = NSTextAlignmentCenter;
    self.titleThirdLbl.font = [UIFont systemFontOfSize:11.0];
    self.titleThirdLbl.textColor = TEXT_GREY_COLOR;
    [self addSubview:self.titleThirdLbl];
    
    self.QQLbl = [[UILabel alloc]init];
    self.QQLbl.text = @"QQ登录";
    self.QQLbl.textColor = TEXT_GREY_COLOR;
    self.QQLbl.textAlignment = NSTextAlignmentCenter;
    self.QQLbl.font = [UIFont systemFontOfSize:11.0];
    [self addSubview:self.QQLbl];
    
    self.WXLbl = [[UILabel alloc]init];
    self.WXLbl.text = @"微信登录";
    self.WXLbl.textColor = TEXT_GREY_COLOR;
    self.WXLbl.textAlignment = NSTextAlignmentCenter;
    self.WXLbl.font = [UIFont systemFontOfSize:11.0];
    [self addSubview:self.WXLbl];
    
    self.sinaLbl = [[UILabel alloc]init];
    self.sinaLbl.text = @"微博登录";
    self.sinaLbl.font = [UIFont systemFontOfSize:11.0];
    self.sinaLbl.textColor = TEXT_GREY_COLOR;
    self.sinaLbl.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.sinaLbl];
     */
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self.logoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(108*WIDTH, 108*WIDTH));
        make.top.equalTo(@(53*HEIGHT));
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    [self.vfLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.centerY.equalTo(self.rememberPwBtn.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-18);
        make.top.mas_equalTo(self.logoView.mas_bottom).offset(24*HEIGHT);
        make.height.mas_equalTo(@17);
        make.width.mas_equalTo(@120);
    }];
    
    
    [self.userView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 41));
        make.top.mas_equalTo(self.vfLoginBtn.mas_bottom).offset(HEIGHT*10);
        make.left.mas_equalTo(@0);
    }];
    
    [self.vfLoginBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.userView.mas_right).offset(-18);
    }];
    
    [self.phoneNumTF mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.width.equalTo(@(316*WIDTH));
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
    
    [self.passWdTF mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.width.equalTo(@(270.5*WIDTH));
        make.height.equalTo(@(20));
        make.left.mas_equalTo(self.phoneNumTF.mas_left);
        make.right.mas_equalTo(self.phoneNumTF.mas_right).offset(-38);
        make.centerY.equalTo(self.pwdView.mas_centerY);
    }];
    
    //    [self.passWdLbl mas_makeConstraints:^(MASConstraintMaker *make) {
    ////        make.size.mas_equalTo(CGSizeMake(14, 17));
    //        make.size.mas_equalTo(self.phoneNumLbl);
    //        make.left.equalTo(self.passWdTF.mas_left);
    //        make.centerY.equalTo(self.pwdView.mas_centerY);
    //    }];
    
    //    [self.secondLine mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.width.equalTo(self.passWdTF);
    //        make.height.equalTo(@1);
    //        make.top.equalTo(self.passWdTF.mas_bottom).offset(-1);
    //        make.centerX.equalTo(self.passWdTF.mas_centerX);
    //    }];
    
    [self.pwVisibleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(17, 10));
        make.right.equalTo(self.pwdView.mas_right).offset(-20);
        make.centerY.equalTo(self.passWdTF.mas_centerY);
    }];
    
    //    [self.rememberPwLbl mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.equalTo(self.passWdTF.mas_bottom).offset(19*HEIGHT);
    //        make.right.equalTo(self.passWdTF.mas_right);
    //    }];
    //
    //    [self.rememberPwBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.size.mas_equalTo(CGSizeMake(10.5, 10.5));
    //        make.top.equalTo(self.rememberPwLbl);
    //        make.right.equalTo(self.rememberPwLbl.mas_left).offset(-2);
    //
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
    
    [self.quickRegisterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginBtn.mas_bottom).offset(10*HEIGHT);
        make.right.equalTo(self.loginBtn.mas_right);
    }];
    
    //    [self.bottomImage mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.size.mas_equalTo(CGSizeMake(screenWidth, screenWidth*160/375));
    //        make.bottom.equalTo(@(screenHeight));
    //    }];
    
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(12, 12));
        make.top.equalTo(self.mas_top).offset(10*HEIGHT);
        make.right.equalTo(@(kScreenWidth-10));
        
    }];
    
    [self.leftThirdLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.quickRegisterBtn.mas_bottom).offset(68*HEIGHT);
        make.left.equalTo(self.loginBtn.mas_left);
        make.height.equalTo(@1);
        make.width.equalTo(@(kScreenWidth/2.0-18-46));
        
    }];
    
    [self.rightThirdLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.leftThirdLbl.mas_top);
        make.right.equalTo(self.loginBtn.mas_right);
        make.height.equalTo(@1);
        make.width.equalTo(self.leftThirdLbl.mas_width);
        
    }];
    
    [self.titleThirdLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.quickRegisterBtn.mas_bottom).offset(62*HEIGHT);
        make.left.equalTo(self.leftThirdLbl.mas_right);
        make.right.equalTo(self.rightThirdLbl.mas_left);
        make.height.equalTo(@13);
        
    }];
    
    [self.QQbutton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.rightThirdLbl.mas_bottom).offset(32);
        make.width.equalTo(@35);
        make.height.equalTo(@35);
        make.left.equalTo(@((kScreenWidth-35*3.0)/4.0));
        
    }];
    
    [self.WXbutton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.QQbutton.mas_top);
        make.width.equalTo(@35);
        make.height.equalTo(@35);
        make.left.equalTo(self.QQbutton.mas_right).offset((kScreenWidth-35*3.0)/4.0);
    }];
    
    [self.sinaButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.QQbutton.mas_top);
        make.width.equalTo(@35);
        make.height.equalTo(@35);
        make.left.equalTo(self.WXbutton.mas_right).offset((kScreenWidth-35*3.0)/4.0);
        
    }];
    
    [self.QQLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.QQbutton.mas_bottom).offset(HEIGHT*6);
        make.width.equalTo(@50);
        make.height.equalTo(@12);
        make.centerX.equalTo(self.QQbutton.mas_centerX);
        
    }];
    
    [self.WXLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.QQbutton.mas_bottom).offset(HEIGHT*6);
        make.width.equalTo(@50);
        make.height.equalTo(@12);
        make.centerX.equalTo(self.WXbutton.mas_centerX);
        
    }];
    
    [self.sinaLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.QQbutton.mas_bottom).offset(HEIGHT*6);
        make.width.equalTo(@50);
        make.height.equalTo(@12);
        make.centerX.equalTo(self.sinaButton.mas_centerX);
        
    }];
}
#pragma 根据keyboardChanged滚动scrollView
-(void)keyboardChanged:(NSNotification *)notification {
    // UIKeyboardFrameEndUserInfoKey =>将要变化的大小
    CGRect keyboardRect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.keyboardHeight = keyboardRect.size.height;
}

-(void)keyboardDidChanged
{
    [self scrollToBottom];
}


-(void)scrollToBottom
{
    Float32 keyboardMaxY = kScreenHeight - self.keyboardHeight;
    Float32 scrollOffset = self.inputViewMaxY - keyboardMaxY;
    if (scrollOffset >= 0) {
        [self setContentOffset:CGPointMake(0, scrollOffset) animated:YES];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
