//
//  RegisterScrollView.h
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/3/2.
//  Copyright © 2018年 中发. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterScrollView : UIScrollView

//@property (nonatomic,strong) CreateNavgationView *navView;

@property (nonatomic,strong) UILabel *websiteLogo; // 网站logo
@property (nonatomic,strong) UILabel *phoneNumLbl; // 手机号
@property (nonatomic,strong) UITextField *phoneNumTF;
@property (nonatomic,strong) UIView *firstLine;
@property (nonatomic,strong) UILabel *vfCodeLbl; // 验证码
@property (nonatomic,strong) UITextField *vfCodeTF;
@property (nonatomic,strong) UIView *secondLine;
@property (nonatomic,strong) UIButton *getvfCodeBtn; // 获取验证码按钮
@property (nonatomic,strong) UILabel *delegateLbl; // 协议提示文字
@property (nonatomic,strong) UIButton *delegateBtn; // 用户协议按钮
@property (nonatomic,strong) UILabel *passWdLbl; // 密码
@property (nonatomic,strong) UITextField *passWdTF;
@property (nonatomic,strong) UIView *thirdLine;
@property (nonatomic,strong) UIButton *pwVisibleBtn; // 密码可见按钮
@property (nonatomic,strong) UILabel *pwPromoteLbl; // 密码提示
@property (nonatomic,strong) UIButton *registerBtn; // 注册按钮

@property (nonatomic,strong) UILabel *passWdLbl2; // 密码
@property (nonatomic,strong) UITextField *passWdTF2;
@property (nonatomic,strong) UIButton *pwVisibleBtn2; // 密码可见按钮



@property (nonatomic,strong) UIView *view1;
@property (nonatomic,strong) UIView *view2;
@property (nonatomic,strong) UIView *view3;
@property (nonatomic,strong) UIView *view4;

@end
