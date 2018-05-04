//
//  PurchaseViewController.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/3/1.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "PurchaseViewController.h"
#import "AccountAndPWLoginViewController.h"
#import "HomeViewController.h"

@interface PurchaseViewController ()<WKNavigationDelegate,WKUIDelegate,UIWebViewDelegate>{

    NSString *_jumpUrl;
}

@property (nonatomic,strong) WKWebView *webView;
@property(nonatomic,assign) BOOL isLoaing;

@end

@implementation PurchaseViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navBarView removeFromSuperview];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    NSString *theStr = [NSString stringWithFormat:@"%@%@",BaseApi,PurchaseList_api];
    [self loadString:theStr];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 设置导航栏标题
    // 初始化
    [self creatWebView];
    
    // 初始化导航栏
    [self setupNavigationBar];
}

#pragma mark -初始化子视图
- (void)creatWebView{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, kScreenWidth, kScreenHeight-49-SafeAreaBottomHeight-SafeAreaTopHeight)];
    
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    
    [self.view addSubview:self.webView];
    
    [self.webView setMultipleTouchEnabled:YES];
    
    [self.webView.scrollView setAlwaysBounceVertical:YES];
    
    [self.webView setAllowsBackForwardNavigationGestures:true];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _isLoaing=NO;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    NSString *theUrl = [NSString stringWithFormat:@"%@%@",BaseApi,PurchaseList_api];
    [self loadString:theUrl];
}

#pragma mark -初始化导航栏

- (void)setupNavigationBar {
    
    NavigationControllerView *navView = [[NavigationControllerView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, SafeAreaTopHeight) andtitle:@"采购料单"];
    navView.viewController = self;
    [self.view addSubview:navView];
}

// 让浏览器加载指定的字符串,使用m.baidu.com进行搜索
- (void)loadString:(NSString *)str{
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:str]];
    [request addValue:@"ios" forHTTPHeaderField:@"app"];
    NSMutableDictionary *cookieDic = [NSMutableDictionary dictionary];
    NSMutableString *cookieValue = [NSMutableString stringWithFormat:@""];
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [cookieJar cookies]) {
        [cookieDic setObject:cookie.value forKey:cookie.name];
    }
    if ([KUserDefault objectForKey:@"token"]) {
        [cookieDic setObject:[KUserDefault objectForKey:@"token"] forKey:@"zfa_token"];
    }
    else{
        [cookieDic setObject:@"" forKey:@"zfa_token"];
    }
    // cookie重复，先放到字典进行去重，再进行拼接
    for (NSString *key in cookieDic) {
        NSString *appendString = [NSString stringWithFormat:@"%@=%@;", key, [cookieDic valueForKey:key]];
        [cookieValue appendString:appendString];
    }
    
    [request addValue:cookieValue forHTTPHeaderField:@"Cookie"];
    NSLog(@"添加cookie");
    
    [self.webView loadRequest:request];
}

#pragma mark - navdelegate
//页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation { // 类似UIWebView的 -webViewDidStartLoad:
    NSLog(@"didStartProvisionalNavigation");
    //    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSLog(@"webview URL:%@",webView.URL);
    //    NSString *url = webView.URL.absoluteString;
    //    if([url containsString:LoginURL]) {
    //
    //        PwLoginViewController *vc = [[PwLoginViewController alloc]init];
    //
    //        [self.navigationController pushViewController:vc animated:YES];
    //    }
    _isLoaing = YES;
    
    //    NSString *path=[YKBDateHelper convertNull:[webView.URL absoluteString]];
    //    NSString * newPath = [path lowercaseString];
    //    if ([newPath hasPrefix:@"sms:"] || [newPath hasPrefix:@"tel:"]) {
    //        UIApplication * app = [UIApplication sharedApplication];
    //        if ([app canOpenURL:[NSURL URLWithString:newPath]]) {
    //            [app openURL:[NSURL URLWithString:newPath]];
    //        }
    //        return;
    //    }
    
    
}

//内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    NSLog(@"didCommitNavigation");
    
    //    [NSThread sleepForTimeInterval:1.0];
}

//页面加载完成时调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation { // 类似 UIWebView 的 －webViewDidFinishLoad:
    NSLog(@"didFinishNavigation");
    
    
    
    
    //    [self resetControl];
    //    if (webView.title.length > 0) {
    //        self.title = webView.title;
    //    }
    
    //    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
}

//-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
//    NSLog(@"webviewurl：%@",webView.);
//    return YES;
//}


// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    NSString *url = webView.URL.absoluteString;
    NSLog(@"收到响应url ===== %@",url);
    
    
    if([url containsString:memberLogin_api]) {
        
        decisionHandler(WKNavigationResponsePolicyCancel);
        
        
        NSArray *separatedStr = [url componentsSeparatedByString:@"service="];
        
        _jumpUrl = [separatedStr objectAtIndex:1];
        AccountAndPWLoginViewController *vc = [[AccountAndPWLoginViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    else if ([url containsString:memberIndex_api]){
 decisionHandler(WKNavigationResponsePolicyCancel);
        HomeViewController *vc = [[HomeViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }

    decisionHandler(WKNavigationResponsePolicyAllow);
}

// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    // 类似 UIWebView 的 -webView: shouldStartLoadWithRequest: navigationType:
    
    NSLog(@"4.%@",navigationAction.request);
    
    
    //    NSString *url = [navigationAction.request.URL.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    // 解决WKWebView替换UIWebView无法拨打电话
    NSURL *URL = navigationAction.request.URL;
    NSString *scheme = [URL scheme];
    if ([scheme isEqualToString:@"tel"]) {
        NSString *resourceSpecifier = [URL resourceSpecifier];
        NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@", resourceSpecifier];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
    }
    
    
    
    decisionHandler(WKNavigationActionPolicyAllow);
    
}



#pragma mark - WKUIdelegate
//捕获弹窗
//- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
//
//
//    UIAlertView* dialogue = [[UIAlertView alloc]initWithTitle:nil message:message delegate:self cancelButtonTitle:NSLocalizedString(@"ok", @"Ok") otherButtonTitles:NSLocalizedString(@"Cancel", @"cancel"), nil];
//
//    [dialogue show];
//    if ([message hasPrefix:@"alipay"]) {
//
//        NSLog(@"跳转");
//    }
//
//    completionHandler();
//
//}

//- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {    LILog(@"runJavaScriptAlertPanelWithMessage");    [LIUseFunc alertWithMessage:message];    completionHandler();}

//- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler {    LILog(@"runJavaScriptConfirmPanelWithMessage");    completionHandler(NO);}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler{
    
}




- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    //
    //    if ([keyPath isEqualToString:@"title"])
    //    {
    //        NSLog(@"webviewtitle :%@",self.webView.title);
    //        if (object == self.webView) {
    //            navView.title = self.webView.title;
    //        }
    //        else {
    //            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    //        }
    //    }else if ([keyPath isEqual: @"estimatedProgress"] && object == _webView) {
    //        [self.progressView setAlpha:1.0f];
    //        [self.progressView setProgress:_webView.estimatedProgress animated:YES];
    //        if(_webView.estimatedProgress >= 1.0f)
    //        {
    //            [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
    //                [self.progressView setAlpha:0.0f];
    //            } completion:^(BOOL finished) {
    //                [self.progressView setProgress:0.0f animated:NO];
    //            }];
    //        }
    //    }
    //    else {
    //        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    //    }
    
    
}

//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
//    if (navigationType==UIWebViewNavigationTypeBackForward) {
//        self.webView.canGoBack?[self.webView goBack]:[self.navigationController popViewControllerAnimated:YES];
//    }
//    return YES;
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [_webView setNavigationDelegate:nil];
    [_webView setUIDelegate:nil];
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
