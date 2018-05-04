//
//  NavigationControllerView.h
//  ZhongFaZhiZao
//
//  Created by chenzhiqiang on 2016/12/17.
//  Copyright © 2016年 chenzhiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavigationControllerView : UIView

@property (weak,nonatomic)UIViewController *viewController;

@property (nonatomic ,assign) NSString *title;
//左侧返回
- (instancetype)initWithFrame:(CGRect)frame andLeftBtn:(NSString *)title;

//右侧返回
- (instancetype)initWithFrame:(CGRect)frame andRightBtn:(NSString *)title;

//无返回
- (instancetype)initWithFrame:(CGRect)frame andtitle:(NSString *)title;

@end
