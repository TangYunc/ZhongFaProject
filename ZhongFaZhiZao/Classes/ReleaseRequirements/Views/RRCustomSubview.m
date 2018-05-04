//
//  RRCustomSubview.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/12.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "RRCustomSubview.h"
#import "UIButton+TYC.h"
#import "NSString+Mobile.h"

@interface RRCustomSubview ()<UITextFieldDelegate>
{
    UIView *_userNameView;
    UILabel *_userNameLabel;
    UITextField *_userNameTF;
    UIView *_phoneNumView;
    UILabel *_phoneNumLabel;
    UITextField *_phoneNumTF;
    UIButton *_obtainBtn;
    UIView *_vericationCodeView;
    UILabel *_vericationCodeLabel;
    UITextField *_vericationCodeTF;
    UIButton *_confirmBtn;
}
@end

@implementation RRCustomSubview

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setUpSubviews];
    }
    return self;
}

- (void)setUpSubviews{
    
    //用户名背景视图
    _userNameView = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:_userNameView];
    //用户名
    _userNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _userNameLabel.textAlignment = NSTextAlignmentLeft;
    _userNameLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    _userNameLabel.font = [UIFont systemFontOfSize:14.f];
    _userNameLabel.text = @"联系人:";
    [_userNameView addSubview:_userNameLabel];
    //用户名输入框
    _userNameTF = [[UITextField alloc] init];
    _userNameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _userNameTF.font = [UIFont systemFontOfSize:14 * KWidth_ScaleW];
//    [_userNameTF setValue:UIColorFromRGBA(153, 153, 153, 1.0) forKeyPath:@"_placeholderLabel.textColor"];
    _userNameTF.borderStyle = UITextBorderStyleRoundedRect;
    _userNameTF.delegate = self;
    [_userNameView addSubview:_userNameTF];
    //电话号码背景视图
    _phoneNumView = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:_phoneNumView];
    //电话号码
    _phoneNumLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _phoneNumLabel.textAlignment = NSTextAlignmentLeft;
    _phoneNumLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    _phoneNumLabel.font = [UIFont systemFontOfSize:14.f];
    _phoneNumLabel.text = @"手机号:";
    [_phoneNumView addSubview:_phoneNumLabel];
    //电话号码输入框
    _phoneNumTF = [[UITextField alloc] init];
    _phoneNumTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _phoneNumTF.font = [UIFont systemFontOfSize:14 * KWidth_ScaleW];
    //    [_userNameTF setValue:UIColorFromRGBA(153, 153, 153, 1.0) forKeyPath:@"_placeholderLabel.textColor"];
    _phoneNumTF.borderStyle = UITextBorderStyleRoundedRect;
    _phoneNumTF.delegate = self;
    [_phoneNumView addSubview:_phoneNumTF];
    //验证码按钮
    _obtainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_obtainBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    _obtainBtn.titleLabel.font = [UIFont systemFontOfSize:14 * KWidth_ScaleW];
    [_obtainBtn setBackgroundColor:[UIColor colorWithHexString:@"#FF6600"]];
    [_obtainBtn setTitleColor:UIColorFromRGBA(255, 255, 255, 1.0) forState:UIControlStateNormal];
    [_obtainBtn setTitleColor:UIColorFromRGBA(251, 52, 52, 1.0) forState:UIControlStateHighlighted];
    [_obtainBtn setTitleColor:UIColorFromRGBA(170, 170, 170, 1.0) forState:UIControlStateDisabled];
    [_obtainBtn addTarget:self action:@selector(obtainBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_phoneNumView addSubview:_obtainBtn];
    //验证码背景视图
     _vericationCodeView = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:_vericationCodeView];
    //验证码
    _vericationCodeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _vericationCodeLabel.textAlignment = NSTextAlignmentLeft;
    _vericationCodeLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    _vericationCodeLabel.font = [UIFont systemFontOfSize:14.f];
    _vericationCodeLabel.text = @"验证码:";
    [_vericationCodeView addSubview:_vericationCodeLabel];
    //验证码输入框
    _vericationCodeTF = [[UITextField alloc] init];
    _vericationCodeTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _vericationCodeTF.font = [UIFont systemFontOfSize:14 * KWidth_ScaleW];
    //    [_userNameTF setValue:UIColorFromRGBA(153, 153, 153, 1.0) forKeyPath:@"_placeholderLabel.textColor"];
    _vericationCodeTF.borderStyle = UITextBorderStyleRoundedRect;
    _vericationCodeTF.delegate = self;
    [_vericationCodeView addSubview:_vericationCodeTF];
    
    //confirmBtn
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_confirmBtn setTitle:@"立即发布" forState:UIControlStateNormal];
    [_confirmBtn setBackgroundColor:[UIColor colorWithHexString:@"#31B3EF"]];
    [_confirmBtn addTarget:self action:@selector(confirmBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_confirmBtn];
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    CGFloat userNameViewGapFromTop = 30/2.0 * KWidth_ScaleH;
    CGFloat userNameViewHeight = 66/2.0 * KWidth_ScaleH;
    _userNameView.frame = CGRectMake(0, userNameViewGapFromTop, kScreenWidth, userNameViewHeight);
    CGFloat userNameLabelWidth = 120/2.0 * KWidth_ScaleH;
    CGFloat userNameLabelGapFromLeft = 94/2.0 * KWidth_ScaleH;
    _userNameLabel.frame = CGRectMake(userNameLabelGapFromLeft, 0, userNameLabelWidth, userNameViewHeight);
    CGFloat userNameTFWidth = 450/2.0 * KWidth_ScaleH;
    _userNameTF.frame = CGRectMake(_userNameLabel.right, 0, userNameTFWidth, userNameViewHeight);
    
    
    CGFloat obtainBtnWidth = 170/2.0 * KWidth_ScaleW;
    CGFloat phoneNumViewGapFromTop = 26/2.0 * KWidth_ScaleH;
    CGFloat phoneNumTFWidth = _userNameTF.width - obtainBtnWidth;
    _phoneNumView.frame = CGRectMake(_userNameView.left, _userNameView.bottom + phoneNumViewGapFromTop, _userNameView.width, _userNameView.height);
    _phoneNumLabel.frame = CGRectMake(_userNameLabel.left, 0, _userNameLabel.width, _userNameLabel.height);
    _phoneNumTF.frame = CGRectMake(_phoneNumLabel.right, 0, phoneNumTFWidth, _userNameTF.height);
    _obtainBtn.frame = CGRectMake(_phoneNumTF.right, 0, obtainBtnWidth, userNameViewHeight);
    
    _vericationCodeView.frame = CGRectMake(_userNameView.left, _phoneNumView.bottom + phoneNumViewGapFromTop, _userNameView.width, _userNameView.height);
    _vericationCodeLabel.frame = CGRectMake(_userNameLabel.left, 0, _userNameLabel.width, _userNameLabel.height);
    _vericationCodeTF.frame = CGRectMake(_vericationCodeLabel.right, 0, _userNameTF.width, _userNameTF.height);
    
    CGFloat confirmBtnWidth = 446/2.0 * KWidth_ScaleW;
    CGFloat confirmBtnHeight = 70/2.0 * KWidth_ScaleW;
    CGFloat confirmBtnGapFromTop = 39/2.0 * KWidth_ScaleW;
    _confirmBtn.frame = CGRectMake(0, _vericationCodeView.bottom + confirmBtnGapFromTop, confirmBtnWidth, confirmBtnHeight);
    _confirmBtn.centerX = _vericationCodeView.centerX;
    _confirmBtn.layer.cornerRadius = confirmBtnWidth / 12;
}
#pragma mark -- 按钮事件
- (void)obtainBtn:(UIButton *)button{
    [self endEditing:YES]; // 关闭键盘
    
    [_obtainBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_obtainBtn setBackgroundColor:[UIColor lightGrayColor]];
    _obtainBtn.userInteractionEnabled = NO;

    // 1.请求参数
    NSMutableDictionary *tempPara = [NSMutableDictionary dictionary];
    [tempPara setObject:_phoneNumTF.text forKey:@"mobile"];
//    NSString *url = [NSString stringWithFormat:@"%@%@",BaseApi,LoginSmscode];
    
    // 发送请求
    [TNetworking postWithUrl:nil params:tempPara success:^(id response) {
        NSLog(@"验证码====%@",response);
        
        if ([response[@"succ"] intValue] == 1) {
            
            [MBProgressHUD showSuccess:@"验证码已发送!"];
            
            [_obtainBtn startWithTime:59 title:@"获取验证码" countDownTitle:@"s" mainColor:nil countColor:nil withObjectStr:nil];
            
        }else {
            if (response[@"datas"][@"error"]) {
                [MBProgressHUD showError:response[@"datas"][@"error"]];
            }
            [_obtainBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            _obtainBtn.userInteractionEnabled = YES;
            
        }
    } fail:^(NSError *error) {
        
    } showHUD:NO] ;
    
}

- (void)confirmBtnAction:(UIButton *)button{
    //    NSLog(@"找回密码");
    [self endEditing:YES]; // 关闭键盘
    
    NSString *mobile = [_phoneNumTF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *pwd =[_userNameTF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *verication =[_vericationCodeTF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    
    //如果是11位的手机号码
    NSString *phoneNum = _phoneNumTF.text;
    if ([mobile isMobileNum] == NO) {
        [MBProgressHUD showError:@"请确认您输入的是正确的手机信息"];
        return ;
    }
    
    if(verication.length != 6){
        [MBProgressHUD showError:@"请输入正确的验证码"];
        return ;
    }
    
    [MBProgressHUD showMessage:@"正在帮你重置密码!"];
    
    // 1.请求参数
    NSMutableDictionary *tempPara = [NSMutableDictionary dictionary];
    
    [tempPara setObject:mobile forKey:@"mobile"];
    [tempPara setObject:verication forKey:@"auth_code"];
    [tempPara setObject:pwd forKey:@"new_password"];
    [tempPara setObject:@"modify" forKey:@"type"];
//    NSString *url = [NSString stringWithFormat:@"%@%@",BaseApiTwo,FindPW];
    
    // 发送请求

    
}
@end
