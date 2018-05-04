//
//  WXPayViewController.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/2/26.
//  Copyright © 2018年 chenzhiqiang. All rights reserved.
//

#import "WXPayViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import <JavaScriptCore/JavaScript.h>
#import "WXApi.h"

@interface WXPayViewController ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView *webView;
@property(nonatomic,copy)NSString *pay_sn;//订单支付码
@end

@implementation WXPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(50, 100, 100, 20);
    [btn setBackgroundColor:[UIColor yellowColor]];
    [btn setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    [btn setTitle:@"wxPay" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(wxPay:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];

    _webView.delegate = nil;
    [_webView removeFromSuperview];
    
}
- (void)wxPay:(UIButton *)btn{
    
    //微信支付
    NSLog(@"微信支付");
    // 支付方式 微信原生：wxpay_native 支付宝 alipay
//    [self useThePayWithPaymentCode:@"wxpay_native"];
    [self useTheWXPayWithPaymentCode:@"wxpay_native"];
}


- (void)useTheWXPayWithPaymentCode:(NSString *)payment_code{
    
    PayReq *request = [[PayReq alloc] init];
    [WXApi sendReq:request];
    /*NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *key = [userDefaults objectForKey:userKey];
    
    NSString *adventure_id = self.adventure_id;
    NSString *num = self.num;
    
    NSMutableDictionary *tempPara = [NSMutableDictionary dictionary];
    [tempPara setObject:key forKey:@"key"];
    [tempPara setObject:payment_code forKey:@"payment_code"];
    [tempPara setObject:adventure_id forKey:@"adventure_id"];
    [tempPara setObject:num forKey:@"num"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@&payment_code=%@",BaseApi,act_activityOrder,payment_code];
    //    NSString *url = [NSString stringWithFormat:@"%@%@",BaseApi,act_activityOrder];
    NSLog(@"select: %@ pay , adventure_id: %@,num:%@,url:%@",payment_code,adventure_id ,num,url);
    
    [GWHttpTool postWithURL:url params:tempPara success:^(id responseObject) {
        NSLog(@"result:===%@",responseObject);
        if([responseObject[@"succ"] integerValue] == 1){
            NSLog(@"pay send ok");
            self.order_id = responseObject[@"datas"][@"orderdata"][@"order_id"];
            // 微信支付
            if([payment_code isEqualToString:@"wxpay_native"]){
                NSLog(@"wxpay_native:paymentdata:%@",responseObject[@"datas"][@"paymentdata"]);
                PayReq *request = [[PayReq alloc] init];
                request.partnerId = responseObject[@"datas"][@"paymentdata"][@"partnerid"];
                request.prepayId =  responseObject[@"datas"][@"paymentdata"][@"prepayid"];
                request.package =  responseObject[@"datas"][@"paymentdata"][@"package"];
                request.nonceStr =  responseObject[@"datas"][@"paymentdata"][@"noncestr"];
                request.timeStamp =  [responseObject[@"datas"][@"paymentdata"][@"timestamp"] intValue];
                request.sign=  responseObject[@"datas"][@"paymentdata"][@"sign"];
                [WXApi sendReq:request];
                
            }
            
        }else {
            if (responseObject[@"datas"][@"error"]) {
                [MBProgressHUD showError:responseObject[@"datas"][@"error"]];
            }
        }
        
    } failure:^(NSError *error) {
        NSLog(@"pay:%@",error);
    }];
    */
    
    
}

- (void)useThePayWithPaymentCode:(NSString *)payment_code{
    
    NSString *key = @"userkey";
    NSString *payBaseApi = @"http://www.121mai.com/mobile";
    NSString *theBaseApi = [NSString stringWithFormat:@"%@/mobile" , payBaseApi];
    NSString *WXPayOrder_pay = @"/index.php?act=member_payment&op=wxpay_native";
    NSString *wxpayUrl = [NSString stringWithFormat:@"%@%@&key=%@&pay_sn=%@&payment_code=%@&paytype=ios",theBaseApi,WXPayOrder_pay,key,self.pay_sn,payment_code];
    
    if([payment_code isEqualToString:@"wxpay_native"]){
        
        [self creatWebView:wxpayUrl];
        NSLog(@"wxpayUrl:%@",wxpayUrl);
        
    }
    
}

-(void)creatWebView:(NSString *)urlStr
{
    _webView = [[UIWebView alloc] init];
    _webView.backgroundColor = [UIColor colorWithRed:249/255.0 green:249/255.0 blue:251/255.0 alpha:1];
    _webView.delegate = self;
    [self.view addSubview:_webView];
    _webView.scrollView.showsVerticalScrollIndicator = YES;
    _webView.scrollView.showsHorizontalScrollIndicator = NO;
    
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    
    [self loadString:urlStr];
    
    //     自动对页面进行缩放以适应屏幕
    //    _webView.scalesPageToFit = YES;
}


// 让浏览器加载指定的字符串,使用m.baidu.com进行搜索
- (void)loadString:(NSString *)str
{
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60];
    // 3. 发送请求给服务器
    [self.webView loadRequest:request];
}


#pragma mark - UIWebDelegate
/**
 *  作用：一般用来拦截webView发出的所有请求（加载新的网页）
 *  每当webView即将发送一个请求之前，会先调用这个方法
 *
 *  @param request        即将要发送的请求
 *
 *  @return YES ：允许发送这个请求  NO ：不允许发送这个请求，禁止加载这个请求
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    return  YES;
}

/**
 *  UIWevView开始加载内容时调用
 */
- (void)webViewDidStartLoad:(UIWebView *)webView {
    //    // 开始旋转
    //    [_indicatorView startAnimating];
    NSLog(@"正在开始加载.......");
}

/**
 *  UIWevView加载完毕时调用
 */
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"lz:goods_detail:webViewDidFinishLoad:--start--");
    
    //在这里唤起wxapppay add by lz 2016-11-18
    //定义好JS要调用的方法, share就是调用的share方法名
    __weak typeof(self) weakSelf = self;
    JSContext *context = [_webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    //方法一
    context[@"wxpay_native_ios"] = ^(){
        NSLog(@"lz:goods_detail:webViewDidFinishLoad:--1--");
        NSArray *args = [JSContext currentArguments] ;
        dispatch_async(dispatch_get_main_queue(),^{
            NSLog(@"lz:goods_detail:webViewDidFinishLoad:--2--");
            JSValue *jsVal = [args objectAtIndex:0];
            NSString *json =jsVal.toString ;
            id result = [NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
            
            NSLog(@"lz:goods_detail:webViewDidFinishLoad:--%@--",result);
            
            if([result[@"code"] integerValue] == 200){
                PayReq *request = [[PayReq alloc] init];
                request.partnerId = result[@"datas"][@"partnerid"];
                request.prepayId =  result[@"datas"][@"prepayid"];
                request.package =  result[@"datas"][@"package"];
                request.nonceStr =  result[@"datas"][@"noncestr"];
                request.timeStamp =  [result[@"datas"][@"timestamp"] intValue];
                request.sign=  result[@"datas"][@"sign"];
                [WXApi sendReq:request];
          
            }
            NSLog(@"lz:goods_detail:webViewDidFinishLoad:--3--");
        });
        NSLog(@"lz:goods_detail:webViewDidFinishLoad:--4--");
    };
    
    NSLog(@"lz:goods_detail:webViewDidFinishLoad:--end--");
}

/**
 *  加载失败时调用
 */
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    //    hasError = YES;
    //    [_indicatorView stopAnimating];
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        // 0.5秒之后执行操作
    //        [[HRPopView popView] showStatus:@"亲，似乎您已断开与互联网的连接"];
    //    });
    NSLog(@"加载失败.......");
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
