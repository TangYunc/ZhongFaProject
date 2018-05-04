//
//  WKWebViewViewController.h
//  ZhongFaZhiZao
//
//  Created by chenzhiqiang on 2016/11/24.
//  Copyright © 2016年 chenzhiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface WKWebViewViewController : UIViewController

- (instancetype)initWithUrlStr:(NSString *)urlStr;

- (instancetype)initWithUrlStr:(NSString *)urlStr title:(NSString *)title;

@end
