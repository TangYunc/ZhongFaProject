//
//  AccountAndPWLognScrollView.h
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/3/1.
//  Copyright © 2018年 中发. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountAndPWLognScrollView : UIScrollView

@property (strong, nonatomic) UIView *backgroundView;
@property (nonatomic, assign) Float32 keyboardHeight;
@property (nonatomic, assign) Float32 inputViewMaxY;

@property (nonatomic,strong) UIImageView *logoView;      //logo
@property (nonatomic,strong) UILabel *phoneNumLbl;   //手机号
@property (nonatomic,strong) UITextField *phoneNumTF;
@property (nonatomic,strong) UIView *firstLine;          //下划线
@property (nonatomic,strong) UILabel *passWdLbl;     // 密码
@property (nonatomic,strong) UITextField *passWdTF;
@property (nonatomic,strong) UIView *secondLine;
@property (nonatomic,strong) UIButton *pwVisibleBtn;     //密码可见按钮
@property (nonatomic,strong) UIButton *vfLoginBtn;       //验证码登录按钮
@property (nonatomic,strong) UIButton *rememberPwBtn;    //记住密码按钮
@property (nonatomic,strong) UILabel *rememberPwLbl;     //记住密码文字
@property (nonatomic,strong) UIButton *loginBtn;         //登录按钮
@property (nonatomic,strong) UIButton *forgetPwBtn;      //忘记密码按钮
@property (nonatomic,strong) UIButton *quickRegisterBtn; //快速注册按钮
@property (nonatomic,strong) UIImageView *bottomImage;   //底部图案
@property (nonatomic,strong) UIButton *closeBtn;         //关闭按钮
@property (nonatomic,strong) UIView *userView;
@property (nonatomic,strong) UIView *pwdView;
//第三方登录按钮
@property (nonatomic,strong)UIButton *QQbutton;           //QQ按钮
@property (nonatomic,strong)UIButton *WXbutton;           //微信按钮
@property (nonatomic,strong)UIButton *sinaButton;         //新浪微博按钮


@property (nonatomic,strong)UILabel *QQLbl;
@property (nonatomic,strong)UILabel *WXLbl;
@property (nonatomic,strong)UILabel *sinaLbl;

@property (nonatomic,strong)UILabel *leftThirdLbl;
@property (nonatomic,strong)UILabel *rightThirdLbl;
@property (nonatomic,strong)UILabel *titleThirdLbl;

@end
