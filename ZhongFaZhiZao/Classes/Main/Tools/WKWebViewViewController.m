//
//  WKWebViewViewController.m
//  ZhongFaZhiZao
//
//  Created by chenzhiqiang on 2016/11/24.
//  Copyright © 2016年 chenzhiqiang. All rights reserved.
//

#import "WKWebViewViewController.h"
#import "AccountAndPWLoginViewController.h"
//#import "PwLoginViewController.h"
#import "HomeViewController.h"

@interface WKWebViewViewController ()<WKNavigationDelegate,WKUIDelegate,UIWebViewDelegate,WKScriptMessageHandler>{

    
    NSString *_jumpUrl;
}

@property (nonatomic,strong) WKWebView *webView;
@property (nonatomic,copy) NSString *urlStr;
@property (nonatomic,copy) NSString *navigatorTitle;
@property (nonatomic,assign) BOOL isLoaing;
@property (nonatomic,strong) UIProgressView *progressView;
@property (nonatomic,strong) UIImageView *imageView;


@end

@implementation WKWebViewViewController
{
    NavigationControllerView *navView;
}

- (instancetype)initWithUrlStr:(NSString *)urlStr{
    return [self initWithUrlStr:urlStr title:nil];
}

- (instancetype)initWithUrlStr:(NSString *)urlStr title:(NSString *)navigatorTitle{
    self=[super init];
    if (self) {
        _urlStr=urlStr;
        _navigatorTitle=navigatorTitle;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    self.tabBarController.tabBar.hidden = YES;
    self.tabBarController.tabBar.frame = CGRectZero;
    
//    NSLog(@"%@",_navigatorTitle);
    self.title=_navigatorTitle;
    //self.navigationController.navigationItem.title=_navigatorTitle;
    //self.navigationController.title=_navigatorTitle;
    self.navigationController.navigationBar.barTintColor=[UIColor blueColor];
    
    if(_jumpUrl) {
        _urlStr = _jumpUrl;
        _jumpUrl = nil;
        _isLoaing = NO;
        [self loadWebViewData];
        
    }
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.frame = CGRectMake(0, kScreenHeight-49, kScreenWidth, 49);
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     navView = [[NavigationControllerView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, SafeAreaTopHeight) andLeftBtn:_navigatorTitle];
    navView.viewController = self;
    [self.view addSubview:navView];
    
    _jumpUrl = nil;
//    创建webview
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc]init];
    
    // 设置偏好设置
    config.preferences = [[WKPreferences alloc] init];
    // 默认为0
    config.preferences.minimumFontSize = 10;
    // 默认认为YES
    config.preferences.javaScriptEnabled = YES;
    // 在iOS上默认为NO，表示不能自动通过窗口打开
    config.preferences.javaScriptCanOpenWindowsAutomatically = NO;
    
    // web内容处理池
    config.processPool = [[WKProcessPool alloc] init];
    
    // 通过JS与webview内容交互
    config.userContentController = [[WKUserContentController alloc] init];
    // 注入JS对象名称AppModel，当JS通过AppModel来调用时，
    // 我们可以在WKScriptMessageHandler代理中接收到
    [config.userContentController addScriptMessageHandler:self name:@"AppModel"];
    

    
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, kScreenWidth, kScreenHeight-SafeAreaTopHeight - SafeAreaBottomHeight)configuration:config];
    _webView.navigationDelegate=self;
    
    _webView.UIDelegate = self;
    
//    [_webView goBack];
//    
//    [_webView goForward];
//    
//    [_webView setMultipleTouchEnabled:YES];
//    
//    [_webView.scrollView setAlwaysBounceVertical:YES];
//    
//    [_webView setAllowsBackForwardNavigationGestures:true];
    
    _progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight+1, CGRectGetWidth(self.view.frame),2)];
    [self.view addSubview:_progressView];
    
    [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew| NSKeyValueObservingOptionOld context:nil];
    
    [self.view addSubview:_webView];
    
    
    _imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"会员2"]];
    _imageView.frame = CGRectMake(kScreenWidth/2.0-15, kScreenHeight/2.0-15, 30, 30);
    [self.view addSubview:_imageView];
    
    _isLoaing=NO;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
 
    
    [self loadWebViewData];
    
    
    [_webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];

}


- (void)loadWebViewData{
    if (!_urlStr.length||_isLoaing) {
        return;
    }
    
    if ([_urlStr hasPrefix:@"http"]) {
        NSURL *url = [NSURL URLWithString:_urlStr];
        
//        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        NSMutableDictionary *cookieDic = [NSMutableDictionary dictionary];
        NSMutableString *cookieValue = [NSMutableString stringWithFormat:@""];
        NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (NSHTTPCookie *cookie in [cookieJar cookies]) {
            [cookieDic setObject:cookie.value forKey:cookie.name];
        }
        
        if ([KUserDefault objectForKey:@"token"]) {
            [cookieDic setObject:[KUserDefault objectForKey:@"token"] forKey:@"zfa_token"];
            
        }else{
        
            [cookieDic setObject:@"" forKey:@"zfa_token"];

        }
        
        // cookie重复，先放到字典进行去重，再进行拼接
        for (NSString *key in cookieDic) {
            NSString *appendString = [NSString stringWithFormat:@"%@=%@;", key, [cookieDic valueForKey:key]];
            [cookieValue appendString:appendString];
        }


        WKUserContentController *userContentController = _webView.configuration.userContentController;
        WKUserScript *script = [[WKUserScript alloc] initWithSource:cookieValue injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
        [userContentController addUserScript:script];
        [request addValue:cookieValue forHTTPHeaderField:@"Cookie"];

        [request addValue:@"ios" forHTTPHeaderField:@"app"];
        [self.webView loadRequest:request];
    }else{
        NSURL *fileURL = [NSURL URLWithString:_urlStr];
//        //        NSURL *fileURL = _urlStr;
        if (!fileURL) {
            return;
        }
//        NSURLRequest *request = [NSURLRequest requestWithURL:fileURL];
//
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:fileURL];
        
        [request addValue:@"ios" forHTTPHeaderField:@"app"];
        
        NSMutableDictionary *cookieDic = [NSMutableDictionary dictionary];
        NSMutableString *cookieValue = [NSMutableString stringWithFormat:@""];
        NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (NSHTTPCookie *cookie in [cookieJar cookies]) {
            [cookieDic setObject:cookie.value forKey:cookie.name];
        }
        
        if ([KUserDefault objectForKey:@"token"]) {
            [cookieDic setObject:[KUserDefault objectForKey:@"token"] forKey:@"zfa_token"];
            
        }else{
            
            [cookieDic setObject:@"" forKey:@"zfa_token"];
            
        }
        
        // cookie重复，先放到字典进行去重，再进行拼接
        for (NSString *key in cookieDic) {
            NSString *appendString = [NSString stringWithFormat:@"%@=%@;", key, [cookieDic valueForKey:key]];
            [cookieValue appendString:appendString];
        }
        
        WKUserContentController *userContentController = _webView.configuration.userContentController;
        WKUserScript *script = [[WKUserScript alloc] initWithSource:cookieValue injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
        [userContentController addUserScript:script];
        
        [request addValue:cookieValue forHTTPHeaderField:@"Cookie"];
//        NSLog(@"添加cookie");
        [self.webView loadRequest:request];
//        [self.webView loadFileURL:fileURL allowingReadAccessToURL:fileURL];
    }
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
    
    _imageView.frame = CGRectZero;
}

// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {

    NSString *url = webView.URL.absoluteString;

    if([url containsString:memberLogin_api]) {
        
        decisionHandler(WKNavigationResponsePolicyCancel);
        
        
        NSArray *separatedStr = [url componentsSeparatedByString:@"service="];
        
//        NSString *jumpStr = [separatedStr objectAtIndex:1];
        
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
    
//    NSLog(@"4.%@",navigationAction.request);
    
    
//    NSString *url = [navigationAction.request.URL.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
//    
//    NSMutableURLRequest *mutableRequest = [navigationAction.request mutableCopy];
//    
//    [mutableRequest addValue:@"ios" forHTTPHeaderField:@"app"];
//    
//    
//  
//    [self.webView loadRequest:mutableRequest];
    //需要判断targetFrame是否为nil，如果为空则重新请求


    
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
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    
    
    UIAlertView* dialogue = [[UIAlertView alloc]initWithTitle:nil message:message delegate:self cancelButtonTitle:NSLocalizedString(@"ok", @"Ok") otherButtonTitles:NSLocalizedString(@"Cancel", @"cancel"), nil];
    
    [dialogue show];
    if ([message hasPrefix:@"alipay"]) {
        
        NSLog(@"跳转");
    }
    
    completionHandler();

}

//- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {    LILog(@"runJavaScriptAlertPanelWithMessage");    [LIUseFunc alertWithMessage:message];    completionHandler();}

//- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler {    LILog(@"runJavaScriptConfirmPanelWithMessage");    completionHandler(NO);}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler{

}


#pragma mark - pay方法
- (void)requesttheAli{

    
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{

    if ([keyPath isEqualToString:@"title"])
    {
//        NSLog(@"webviewtitle :%@",self.webView.title);
        if (object == self.webView) {
            navView.title = self.webView.title;
        }
        else {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }else if ([keyPath isEqual: @"estimatedProgress"] && object == _webView) {
            [self.progressView setAlpha:1.0f];
            [self.progressView setProgress:_webView.estimatedProgress animated:YES];
            if(_webView.estimatedProgress >= 1.0f)
            {
                [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    [self.progressView setAlpha:0.0f];
                } completion:^(BOOL finished) {
                    [self.progressView setProgress:0.0f animated:NO];
                }];
            }
        }
        else {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }

    
}

//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
//    if (navigationType==UIWebViewNavigationTypeBackForward) {
//        self.webView.canGoBack?[self.webView goBack]:[self.navigationController popViewControllerAnimated:YES];
//    }
//    return YES;
//}


-(WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures
{
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController

      didReceiveScriptMessage:(WKScriptMessage *)message {
    
    if ([message.name isEqualToString:@"AppModel"]) {
        
        // 打印所传过来的参数，只支持NSNumber, NSString, NSDate, NSArray,
        
        // NSDictionary, and NSNull类型
        
        NSLog(@"%@",message.body);
        
    }
    
}


- (void)dealloc {
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
    
    [_webView removeObserver:self forKeyPath:@"title"];
    
    // if you have set either WKWebView delegate also set these to nil here
    [_webView setNavigationDelegate:nil];
    [_webView setUIDelegate:nil];
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
