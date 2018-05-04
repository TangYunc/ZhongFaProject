//
//  RegisterViewController.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/3/2.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterScrollView.h"
#import "AccountAndPWLoginViewController.h"
#import "WKWebViewViewController.h"

@interface RegisterViewController ()<UITextFieldDelegate>

@property (nonatomic,strong) RegisterScrollView *registView;

@end

@implementation RegisterViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navBarView removeFromSuperview];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.// 初始化TableView
    [self setUpUI];
    
    // 初始化导航栏
    [self setupNavigationBar];
}


#pragma mark -初始化子视图
- (void)setUpUI{
    
    self.registView = [[RegisterScrollView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, kScreenWidth, kScreenHeight-SafeAreaTopHeight)];
    [self.view addSubview:self.registView];
    
    //    self.registView.navView.viewController = self;
    
    [self.registView.getvfCodeBtn addTarget:self action:@selector(getVfCode:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.registView.delegateBtn addTarget:self action:@selector(delegate) forControlEvents:UIControlEventTouchUpInside];
    
    [self.registView.pwVisibleBtn addTarget:self action:@selector(pwVisible) forControlEvents:UIControlEventTouchUpInside];
    
    [self.registView.pwVisibleBtn2 addTarget:self action:@selector(pwVisible2) forControlEvents:UIControlEventTouchUpInside];
    
    [self.registView.registerBtn addTarget:self action:@selector(regist) forControlEvents:UIControlEventTouchUpInside];
    
    self.registView.vfCodeTF.delegate = self;
    self.registView.phoneNumTF.delegate = self;
    self.registView.passWdTF.delegate = self;
    self.registView.passWdTF2.delegate = self;
    
}

#pragma mark -初始化导航栏

- (void)setupNavigationBar {
    
    NavigationControllerView *navView = [[NavigationControllerView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, SafeAreaTopHeight) andLeftBtn:@"注册"];
    navView.viewController = self;
    [self.view addSubview:navView];
}

// 获取验证码
- (void)getVfCode:(UIButton *)sender{
    
    self.phoneNum = self.registView.phoneNumTF.text;
    
    if ([self.phoneNum isEqualToString:@""]) {
        [WKProgressHUD popMessage:@"请输入手机号" inView:self.view duration:HUD_DURATION animated:YES];
    }else if (![self.phoneNum isMobileNumber]){
        [WKProgressHUD popMessage:@"请输入正确的手机号" inView:self.view duration:HUD_DURATION animated:YES];
    }else{
        
        //        NSDictionary *parameters = @{@"mob":self.phoneNum};
        [TNetworking postWithUrl:[NSString stringWithFormat:@"%@%@/%@",BaseApi,getDynamicCode_api,self.phoneNum] params:nil success:^(id response) {
            if ([response[@"resultCode"]integerValue] == 1000) {
                [WKProgressHUD popMessage:@"    验证码已发送" inView:self.view duration:HUD_DURATION animated:YES];
                __block int timeout = 60; // 倒计时时间
                dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
                dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0); // 每秒执行
                dispatch_source_set_event_handler(_timer, ^{
                    if (timeout <= 1) // 倒计时结束关闭
                    {
                        dispatch_source_cancel(_timer);
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            [sender setTitle:@"获取验证码" forState:UIControlStateNormal];
                            sender.userInteractionEnabled = YES;
                        });
                    }
                    else
                    {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            [UIView beginAnimations:nil context:nil];
                            [UIView setAnimationDuration:1.0f];
                            [sender setTitle:[NSString stringWithFormat:@"%ds", timeout] forState:UIControlStateNormal];
                            [UIView commitAnimations];
                            sender.userInteractionEnabled = NO;
                        });
                        
                        timeout--;
                    }
                });
                
                dispatch_resume(_timer);
            }
            
            else if ([response[@"resultCode"]integerValue] == 1001){
                
                [WKProgressHUD popMessage:@"发送失败" inView:self.view duration:HUD_DURATION animated:YES];
            }
        } fail:^(NSError *error) {
            [WKProgressHUD popMessage:@"请检查网络连接" inView:self.view duration:HUD_DURATION animated:YES];
        } showHUD:NO];
    }
}

- (void)delegate{
    //    DelegateViewController *delegate =[[DelegateViewController alloc]init];
    //    [self.navigationController pushViewController:delegate animated:YES];
    
    WKWebViewViewController *vc = [[WKWebViewViewController alloc]initWithUrlStr:@"http://www.cecb2b.com/zt/register/read.html" title:@"用户协议"];
    
    [self.navigationController pushViewController:vc animated:YES];
}

// 密码可见
- (void)pwVisible{
    self.registView.pwVisibleBtn.selected = !self.registView.pwVisibleBtn.isSelected;
    
    if (self.registView.pwVisibleBtn.isSelected) {
        [self.registView.pwVisibleBtn setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
        self.registView.passWdTF.secureTextEntry = NO;
    }else{
        [self.registView.pwVisibleBtn setTitleColor:[UIColor colorWithHexString:@"#787878"] forState:UIControlStateNormal];
        self.registView.passWdTF.secureTextEntry = YES;
    }
}


// 密码可见2
- (void)pwVisible2{
    self.registView.pwVisibleBtn2.selected = !self.registView.pwVisibleBtn2.isSelected;
    
    if (self.registView.pwVisibleBtn2.isSelected) {
        [self.registView.pwVisibleBtn2 setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
        self.registView.passWdTF2.secureTextEntry = NO;
    }else{
        [self.registView.pwVisibleBtn2 setTitleColor:[UIColor colorWithHexString:@"#787878"] forState:UIControlStateNormal];
        self.registView.passWdTF2.secureTextEntry = YES;
    }
}

// 注册
- (void)regist{
    
    self.phoneNum = self.registView.phoneNumTF.text;
    self.verifyCode = self.registView.vfCodeTF.text;
    self.passWd = self.registView.passWdTF.text;
    self.passWd2 = self.registView.passWdTF2.text;
    
    if ([self.phoneNum isEqualToString:@""]) {
        [WKProgressHUD popMessage:@"请输入手机号" inView:self.view duration:HUD_DURATION animated:YES];
    }else if ([self.verifyCode isEqualToString:@""]){
        [WKProgressHUD popMessage:@"请输入验证码" inView:self.view duration:HUD_DURATION animated:YES];
    }else if ([self.passWd isEqualToString:@""]){
        [WKProgressHUD popMessage:@"请输入密码" inView:self.view duration:HUD_DURATION animated:YES];
    }else if ([self.passWd2 isEqualToString:@""]){
        [WKProgressHUD popMessage:@"请确认密码" inView:self.view duration:HUD_DURATION animated:YES];
    }else if (![self.passWd isEqualToString:self.passWd2]){
        [WKProgressHUD popMessage:@"确认密码与设置密码不一致" inView:self.view duration:HUD_DURATION animated:YES];
    }else if (![self.phoneNum isMobileNumber]){
        [WKProgressHUD popMessage:@"请输入正确的手机号" inView:self.view duration:HUD_DURATION animated:YES];
    }else if (self.passWd.length < 6){
        [WKProgressHUD popMessage:@"密码长度不能小于6位" inView:self.view duration:HUD_DURATION animated:YES];
    }else if (self.passWd.length > 16){
        [WKProgressHUD popMessage:@"密码长度不能大于16位" inView:self.view duration:HUD_DURATION animated:YES];
    }else{
        //        NSDictionary *parameters = @{@"logmob":self.phoneNum,@"logpassword":self.passWd,@"logincode":self.verifyCode};
        [TNetworking postWithUrl:[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseApi,register_api,self.phoneNum,self.passWd,self.verifyCode] params:nil success:^(id response) {
            if ([response[@"resultCode"]integerValue ] == 1000) {
                [WKProgressHUD popMessage:@"注册成功" inView:self.view duration:HUD_DURATION animated:YES];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    AccountAndPWLoginViewController *pwLogin = [[AccountAndPWLoginViewController alloc]init];
                    [self.navigationController pushViewController:pwLogin animated:YES];
                });
            }else if ([response[@"resultCode"]integerValue ] == 1001){
                [WKProgressHUD popMessage:@"注册失败" inView:self.view duration:HUD_DURATION animated:YES];
            }else if ( [response[@"resultCode"]integerValue ] == 1005){
                
                [WKProgressHUD popMessage:@"验证错误" inView:self.view duration:HUD_DURATION animated:YES];
            }else if ( [response[@"resultCode"]integerValue ] == 1007){
                
                //UIAlertController风格：UIAlertControllerStyleAlert
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"该手机号码已注册"
                                                                                         message:nil
                                                                                  preferredStyle:UIAlertControllerStyleAlert ];
                
                //添加取消到UIAlertController中
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
                [alertController addAction:cancelAction];
                //                [self presentViewController:alertController animated:YES completion:nil];
                
                //添加确定到UIAlertController中
                //                UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"去登陆" style:UIAlertActionStyleDefault handler:nil];
                //                [alertController addAction:OKAction];
                //                PwLoginViewController *vc = [[PwLoginViewController alloc]init];
                //                [self.navigationController pushViewController:vc animated:YES];
                
                UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"去登陆" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    AccountAndPWLoginViewController *vc = [[AccountAndPWLoginViewController alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                }];
                
                [alertController addAction:OKAction];
                [self presentViewController:alertController animated:YES completion:nil];
                
            }
        } fail:^(NSError *error) {
            [WKProgressHUD popMessage:@"请检查网络连接" inView:self.view duration:HUD_DURATION animated:YES];
        } showHUD:NO];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
