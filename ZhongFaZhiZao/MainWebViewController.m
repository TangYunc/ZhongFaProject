//
//  MainWebViewController.m
//  ZhongFaZhiZao
//
//  Created by chenzhiqiang on 2016/11/30.
//  Copyright © 2016年 chenzhiqiang. All rights reserved.
//

#import "MainWebViewController.h"


@interface MainWebViewController ()<WKNavigationDelegate,WKUIDelegate>

@property (nonatomic,strong) WKWebView *webView;
@property (nonatomic,strong) UIProgressView *progressView;

@property (nonatomic,strong) UIImageView *imageView;
@property(nonatomic,assign) BOOL isLoaing;

@end

@implementation MainWebViewController

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, kScreenHeight-20)];
    _webView.navigationDelegate=self;
    
    _webView.UIDelegate = self;
    
    [_webView.scrollView setAlwaysBounceVertical:YES];
    
//    允许右滑退出
    [_webView setAllowsBackForwardNavigationGestures:true];
    
//    [_webView loadRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:HOST_URL]]];
    
    _progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 21, CGRectGetWidth(self.view.frame),2)];
    [self.view addSubview:_progressView];
    
    [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew| NSKeyValueObservingOptionOld context:nil];
    
    [self.view addSubview:_webView];
    
    
    _imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"会员2"]];
    _imageView.frame = CGRectMake(kScreenWidth/2.0-15, kScreenHeight/2.0-15, 30, 30);
//    [self.view addSubview:_imageView];
    
    
    
    
    _isLoaing=NO;
    
//    _urlStr = URLStr;
    
    if (!_urlStr) {
        
        _urlStr = [[NSString alloc]init];
    }
    
    [self loadWebViewData];
}

//重写set方法
- (void)setUrlStr:(NSString *)urlStr {

    _urlStr = urlStr;
    
    _isLoaing = NO;
    
    [self loadWebViewData];

}


- (void)loadWebViewData{
    if (!_urlStr.length||_isLoaing) {
        return;
    }
    
    if ([_urlStr hasPrefix:@"http"]) {
        NSURL *url = [NSURL URLWithString:_urlStr];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
    }else{
        NSURL *fileURL = [NSURL URLWithString:_urlStr];
        //        NSURL *fileURL = _urlStr;
        if (!fileURL) {
            return;
        }
                NSURLRequest *request = [NSURLRequest requestWithURL:fileURL];
                [self.webView loadRequest:request];
//        [self.webView loadFileURL:fileURL allowingReadAccessToURL:fileURL];
    }
}


#pragma mark - navdelegate
//页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation { // 类似UIWebView的 -webViewDidStartLoad:
    NSLog(@"didStartProvisionalNavigation");
    //    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
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
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
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
    
//    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

//页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{

//    [MBProgressHUD showError:@"加载失败"];
    
    _isLoaing = NO;
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    
    return;
}


// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    
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

    
//    .jsp .html可以跳转新页面
//    if (navigationAction.targetFrame == nil ) {
//        
//        [webView loadRequest:navigationAction.request];
//    }
    
    decisionHandler(WKNavigationActionPolicyAllow);
    
}





#pragma mark - WKUIdelegate

//创建一个新的webView
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{

    //    .jsp .html可以跳转新页面
    if (navigationAction.targetFrame == nil ) {
        
        [webView loadRequest:navigationAction.request];
    }

    
    return nil;
}

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
    
    if ([keyPath isEqual: @"estimatedProgress"] && object == _webView) {
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


- (void)dealloc {
    
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
    
    
    // if you have set either WKWebView delegate also set these to nil here
    [_webView setNavigationDelegate:nil];
    [_webView setUIDelegate:nil];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
