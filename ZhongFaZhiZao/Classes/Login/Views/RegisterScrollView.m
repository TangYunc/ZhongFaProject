//
//  RegisterScrollView.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/3/2.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "RegisterScrollView.h"

@implementation RegisterScrollView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame: frame];
    
    if (self) {
        
        [self initUI];
    }
    
    return self;
    
}

- (void)initUI{
    
    //    self.navView = [[CreateNavgationView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 63) andBgd:@"#ffffff" andtitle:@"注册内啥" andtitleColor:@"#505050"];
    //    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 63, screenWidth, 1)];
    //    lineView.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    //    [self addSubview:lineView];
    //    [self addSubview:self.navView];
    
    
    self.backgroundColor = BACK_COLOR;
    
    //    self.websiteLogo = [[UILabel alloc]init];
    //    self.websiteLogo.text = @"NEISHA.CC";
    //    self.websiteLogo.textColor = MAIN_COLOR;
    //    self.websiteLogo.font = [UIFont boldSystemFontOfSize:24];
    //    [self.scrollView addSubview:self.websiteLogo];
    
    self.view1 = [[UIView alloc]init];
    self.view1.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.view1];
    
    self.phoneNumLbl = [[UILabel alloc]init];
    self.phoneNumLbl.text = @"+86";
    self.phoneNumLbl.textAlignment = NSTextAlignmentLeft;
    //    self.phoneNumLbl.backgroundColor = [UIColor redColor];
    self.phoneNumLbl.font = [UIFont boldSystemFontOfSize:14.0];
    self.phoneNumLbl.textColor = [UIColor colorWithHexString:@"#4a4a4a"];
    //    [self.phoneNumLbl sizeToFit];
    [self.view1 addSubview:self.phoneNumLbl];
    
    self.phoneNumTF = [[UITextField alloc]init];
    self.phoneNumTF.leftView = self.phoneNumLbl;
    self.phoneNumTF.leftViewMode = UITextFieldViewModeAlways;
    self.phoneNumTF.placeholder = @"手机号";
    self.phoneNumTF.font = [UIFont systemFontOfSize:14.0];
    self.phoneNumTF.textColor = TEXT_GREY_COLOR;
    self.phoneNumTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.phoneNumTF.backgroundColor = [UIColor whiteColor];
    [self.view1 addSubview:self.phoneNumTF];
    
    self.firstLine = [[UIView alloc]init];
    self.firstLine.backgroundColor = TEXT_LINE_COLOR;
    [self addSubview:self.firstLine];
    
    self.view2 = [[UIView alloc]init];
    self.view2.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.view2];
    
    self.vfCodeLbl = [[UILabel alloc]init];
    self.vfCodeLbl.font = [UIFont boldSystemFontOfSize:14.0];
    self.vfCodeLbl.text = @"验证码";
    self.vfCodeLbl.textColor = [UIColor colorWithHexString:@"#4a4a4a"];
    //    [self.vfCodeLbl sizeToFit];
    [self.view2 addSubview:self.vfCodeLbl];
    
    
    UILabel *vfcoderightlbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 73+17, 40)];
    vfcoderightlbl.userInteractionEnabled = YES;
    self.getvfCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.getvfCodeBtn.frame = CGRectMake(0, (40-26)/2.0, 73, 26);
    [self.getvfCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.getvfCodeBtn setTitleColor:[UIColor colorWithHexString:@"#787878"] forState:UIControlStateNormal];
    self.getvfCodeBtn.layer.cornerRadius = 2;
    self.getvfCodeBtn.layer.borderColor = [UIColor colorWithHexString:@"#b4b4b4"].CGColor;
    self.getvfCodeBtn.layer.borderWidth = 1;
    self.getvfCodeBtn.layer.masksToBounds = YES;
    self.getvfCodeBtn.titleLabel.font  = [UIFont systemFontOfSize:12];
    [vfcoderightlbl addSubview:self.getvfCodeBtn];
    
    self.vfCodeTF = [[UITextField alloc]init];
    self.vfCodeTF.leftView = self.vfCodeLbl;
    self.vfCodeTF.leftViewMode = UITextFieldViewModeAlways;
    self.vfCodeTF.rightView = vfcoderightlbl;
    self.vfCodeTF.rightViewMode = UITextFieldViewModeAlways;
    self.vfCodeTF.placeholder = @"请输入验证码";
    self.vfCodeTF.font = [UIFont systemFontOfSize:15];
    self.vfCodeTF.textColor = TEXT_GREY_COLOR;
    self.vfCodeTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    [self.view2 addSubview:self.vfCodeTF];
    
    self.secondLine = [[UIView alloc]init];
    self.secondLine.backgroundColor = TEXT_LINE_COLOR;
    [self addSubview:self.secondLine];
    
    
    self.view3 = [[UIView alloc]init];
    self.view3.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.view3];
    
    self.passWdLbl = [[UILabel alloc]init];
    self.passWdLbl.font = [UIFont boldSystemFontOfSize:14.0];
    self.passWdLbl.text = @"密码";
    self.passWdLbl.textColor = [UIColor colorWithHexString:@"#4a4a4a"];
    //    [self.passWdLbl sizeToFit];
    [self.view3 addSubview:self.passWdLbl];
    
    self.passWdTF = [[UITextField alloc]init];
    self.passWdTF.leftView = self.passWdLbl;
    self.passWdTF.leftViewMode = UITextFieldViewModeAlways;
    self.passWdTF.rightView = self.pwVisibleBtn;
    self.passWdTF.rightViewMode = UITextFieldViewModeAlways;
    self.passWdTF.placeholder = @"请输入至少6-16位字符的密码";
    self.passWdTF.font = [UIFont systemFontOfSize:14.0];
    self.passWdTF.secureTextEntry = YES;
    self.passWdTF.textColor = TEXT_GREY_COLOR;
    self.passWdTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view3 addSubview:self.passWdTF];
    
    
    self.thirdLine = [[UIView alloc]init];
    self.thirdLine.backgroundColor = TEXT_LINE_COLOR;
    [self addSubview:self.thirdLine];
    
    
    self.pwVisibleBtn = [[UIButton alloc]init];
    self.pwVisibleBtn.titleLabel.font = [UIFont fontWithName:IconFont size:26];
    [self.pwVisibleBtn setImage:[UIImage imageNamed:@"LoginSecurtEyeIcon"] forState:UIControlStateNormal];
    //    [self.pwVisibleBtn setTitleColor:[UIColor colorWithHexString:@"#787878"] forState:UIControlStateNormal];
    [self.pwVisibleBtn sizeToFit];
    [self.view3 addSubview:self.pwVisibleBtn];
    
    
    self.view4 = [[UIView alloc]init];
    self.view4.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.view4];
    //
    self.passWdLbl2 = [[UILabel alloc]init];
    self.passWdLbl2.font = [UIFont boldSystemFontOfSize:14.0];
    self.passWdLbl2.text = @"确认密码";
    self.passWdLbl2.textColor = [UIColor colorWithHexString:@"#4a4a4a"];
    //    [self.passWdLbl sizeToFit];
    [self.view4 addSubview:self.passWdLbl2];
    //
    self.passWdTF2 = [[UITextField alloc]init];
    self.passWdTF2.leftView = self.passWdLbl2;
    self.passWdTF2.leftViewMode = UITextFieldViewModeAlways;
    self.passWdTF2.rightView = self.pwVisibleBtn2;
    self.passWdTF2.rightViewMode = UITextFieldViewModeAlways;
    self.passWdTF2.placeholder = @"请再次输入设置的密码";
    self.passWdTF2.font = [UIFont systemFontOfSize:14.0];
    self.passWdTF2.secureTextEntry = YES;
    self.passWdTF2.textColor = TEXT_GREY_COLOR;
    self.passWdTF2.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view4 addSubview:self.passWdTF2];
    
    
    self.pwVisibleBtn2 = [[UIButton alloc]init];
    self.pwVisibleBtn2.titleLabel.font = [UIFont fontWithName:IconFont size:26];
    [self.pwVisibleBtn2 setImage:[UIImage imageNamed:@"LoginSecurtEyeIcon"] forState:UIControlStateNormal];
    //    [self.pwVisibleBtn setTitleColor:[UIColor colorWithHexString:@"#787878"] forState:UIControlStateNormal];
    [self.pwVisibleBtn2 sizeToFit];
    [self.view4 addSubview:self.pwVisibleBtn2];
    
    
    //    self.pwPromoteLbl = [[UILabel alloc]init];
    //    self.pwPromoteLbl.text = @"密码长度为6-16位，支持数字，字母和字符";
    //    self.pwPromoteLbl.textColor = [UIColor colorWithHexString:@"#787878"];
    //    self.pwPromoteLbl.font = [UIFont systemFontOfSize:12];
    //    [self.scrollView addSubview:self.pwPromoteLbl];
    
    self.registerBtn = [[UIButton alloc]init];
    [self.registerBtn setTitle:@"立即注册" forState:UIControlStateNormal];
    [self.registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.registerBtn setBackgroundColor:BLUE_COLOR];
    self.registerBtn.alpha = 0.5;
    self.registerBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    self.registerBtn.layer.cornerRadius = 3;
    self.registerBtn.layer.masksToBounds = YES;
    [self addSubview:self.registerBtn];
    
    self.delegateLbl = [[UILabel alloc]init];
    self.delegateLbl.text = @"*注册即表示您同意";
    self.delegateLbl.textColor = [UIColor colorWithHexString:@"#787878"];
    self.delegateLbl.font = [UIFont systemFontOfSize:12];
    [self addSubview:self.delegateLbl];
    
    self.delegateBtn = [[UIButton alloc]init];
    [self.delegateBtn setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    [self.delegateBtn setTitleColor:[UIColor yellowColor] forState:UIControlStateHighlighted];
    self.delegateBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.delegateBtn setTitle:@"《中发智造》用户使用条例" forState:UIControlStateNormal];
    [self addSubview:self.delegateBtn];
    //    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"《中发智造》用户使用条例"];
    ////    NSRange strRange = {0,[str length]};
    ////    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
    //    [self.delegateBtn setAttributedTitle:str forState:UIControlStateNormal];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    //    [self.websiteLogo mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.equalTo(@(35*HEIGHT));
    //        make.centerX.equalTo(self.mas_centerX);
    //    }];
    
    //    view1
    [self.view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(@(414));
        make.left.equalTo(@0);
        make.height.equalTo(@41);
        make.top.equalTo(@10);
        
    }];
    
    [self.phoneNumTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(kScreenWidth-41-18));
        make.height.equalTo(@20);
        make.centerY.equalTo(self.view1.mas_centerY);
        //        make.centerX.equalTo(self.mas_centerX);
        make.left.equalTo(@18);
    }];
    
    [self.phoneNumLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60+15,20));
        //        make.left.equalTo(self.phoneNumTF.mas_left).offset(18);
        make.centerY.equalTo(self.phoneNumTF.mas_centerY);
    }];
    
    [self.firstLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view1);
        make.height.equalTo(@1);
        make.top.equalTo(self.view1.mas_bottom);
        make.centerX.equalTo(self.view1.mas_centerX);
    }];
    
    //    view2
    [self.view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(self.view1);
        make.left.equalTo(self.view1.mas_left);
        make.height.equalTo(@41);
        make.top.equalTo(self.firstLine.mas_bottom).offset(1);
        
    }];
    
    [self.vfCodeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.width.equalTo(self.phoneNumTF);
        make.height.equalTo(self.phoneNumTF);
        make.centerY.equalTo(self.view2.mas_centerY);
        //        make.centerX.equalTo(self.mas_centerX);
        make.left.equalTo(self.phoneNumTF.mas_left);
        //        make.right.mas_equalTo(self.view2.mas_right).offset(-91);
        make.width.equalTo(@(kScreenWidth-18));
        
        //        make.height.equalTo(@(20));
        //        make.left.mas_equalTo(self.phoneNumTF.mas_left);
        //        //        make.right.mas_equalTo(self.phoneNumTF.mas_right).offset(-68);
        //        make.width.mas_equalTo(@160);
        //        make.centerY.equalTo(self.view2.mas_centerY);
        
    }];
    
    [self.vfCodeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.phoneNumLbl);
        make.left.equalTo(self.vfCodeTF.mas_left);
        make.centerY.equalTo(self.vfCodeTF.mas_centerY);
    }];
    
    //    [self.getvfCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.size.mas_equalTo(CGSizeMake(73, 26));
    //        make.right.equalTo(self.view2.mas_right).offset(-17);
    //
    //        make.top.equalTo(self.vfCodeTF.mas_top);
    //    }];
    
    [self.secondLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.firstLine);
        make.height.equalTo(self.firstLine);
        make.top.equalTo(self.view2.mas_bottom);
        make.centerX.equalTo(self.firstLine.mas_centerX);
    }];
    
    
    [self.view3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view1);
        make.left.equalTo(self.view1.mas_left);
        make.height.equalTo(self.view1);
        make.top.equalTo(self.secondLine.mas_bottom).offset(1);
        
        
    }];
    
    [self.passWdTF mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.width.equalTo(self.phoneNumTF);
        make.height.equalTo(self.phoneNumTF);
        make.centerY.equalTo(self.view3.mas_centerY);
        //        make.centerX.equalTo(self.mas_centerX);
        make.right.mas_equalTo(self.phoneNumTF.mas_right).offset(-38);
        make.left.equalTo(self.phoneNumTF.mas_left);
    }];
    
    [self.passWdLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.phoneNumLbl);
        //        make.left.equalTo(self.vfCodeTF.mas_left);
        make.centerY.equalTo(self.passWdTF.mas_centerY);
    }];
    
    [self.pwVisibleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(17, 10));
        make.right.equalTo(self.view3.mas_right).offset(-20);
        make.centerY.equalTo(self.view3.mas_centerY);
    }];
    
    
    
    [self.thirdLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.secondLine);
        make.height.equalTo(@1);
        make.top.equalTo(self.view3.mas_bottom).offset(1);
        make.centerX.equalTo(self.view3.mas_centerX);
    }];
    
    [self.view4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view1);
        make.left.equalTo(self.view1.mas_left);
        make.height.equalTo(self.view1);
        make.top.equalTo(self.thirdLine.mas_bottom).offset(1);
        
        
    }];
    //
    [self.passWdTF2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.passWdTF);
        make.height.equalTo(self.phoneNumTF);
        make.centerY.equalTo(self.view4.mas_centerY);
        //        make.centerX.equalTo(self.mas_centerX);
        make.left.equalTo(self.phoneNumTF.mas_left);
    }];
    
    [self.passWdLbl2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.phoneNumLbl);
        //        make.left.equalTo(self.vfCodeTF.mas_left);
        make.centerY.equalTo(self.passWdTF2.mas_centerY);
    }];
    
    [self.pwVisibleBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(17, 10));
        make.right.equalTo(self.view4.mas_right).offset(-20);
        make.centerY.equalTo(self.view4.mas_centerY);
    }];
    
    
    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view4.mas_bottom).offset(34*HEIGHT);
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(@(kScreenWidth-36));
        make.height.equalTo(@35);
    }];
    
    
    //    用户协议
    [self.delegateLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.registerBtn.mas_bottom).offset(14.5*HEIGHT);
        make.left.equalTo(self.registerBtn.mas_left);
        make.height.equalTo(@15);
        //            make.width.equalTo(self.registerBtn);
    }];
    
    [self.delegateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.delegateLbl);
        make.left.equalTo(self.delegateLbl.mas_right).offset(2);
        
    }];
    
    //
    ////    [self.pwPromoteLbl mas_makeConstraints:^(MASConstraintMaker *make) {
    ////        make.top.equalTo(self.passWdTF.mas_bottom).offset(14.5*HEIGHT);
    ////        make.left.equalTo(self.passWdTF.mas_left);
    ////    }];
    //
    
}
@end
