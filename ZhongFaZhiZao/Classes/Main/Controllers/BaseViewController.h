//
//  BaseViewController.h
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/3/1.
//  Copyright © 2018年 中发. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

/** 导航条View */
@property (nonatomic, strong) UIView *navBarView;

@property (nonatomic, assign) BOOL isBackButton;
- (void)hideNavigationBarShadowLine:(BOOL)hide;
-(void)setNavigationBarTitle:(NSString *)title;
@end
