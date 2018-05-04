//
//  RuleMacros.h
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/3/1.
//  Copyright © 2018年 中发. All rights reserved.
//

// 获取当前设备屏幕的宽和高
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define iOS7 ([UIDevice currentDevice].systemVersion.doubleValue >= 7.0)

//iphone6适配
#define WIDTH [UIScreen mainScreen].bounds.size.width/375
#define HEIGHT [UIScreen mainScreen].bounds.size.height/667


//屏幕比例
#define KWidth_ScaleW [UIScreen mainScreen].bounds.size.width/375.0f
#define KWidth_ScaleH [UIScreen mainScreen].bounds.size.height/667.0f


/// 刷新框架的适配iOS11,第一个参数是当下的控制器适配iOS11 一下的，第二个参数表示scrollview或子类
#define AdjustsScrollViewInsetNever(controller,view) if(@available(iOS 11.0, *)) {view.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;} else if([controller isKindOfClass:[UIViewController class]]) {controller.automaticallyAdjustsScrollViewInsets = false;}

/// 高度系数 812.0 是iPhoneX的高度尺寸，667.0表示是iPhone 8 的高度，如果你觉的它会变化，那我也很无奈
#define heightCoefficient (kScreenHeight == 812.0 ? 667.0/667.0 : kWJScreenHeight/667.0)
///状态栏高度，iPhone X的状态栏由原来的20变更为现在的44,来凸现齐刘海
#define StatuBarHeight (kScreenHeight == 812.0 ? 44 : 20)
///导航的高度为64，在哪个手机上面都是不变的,iPhone X没出来之前是对的，随便写64,iPhone X出来后，导航栏高度变为88
#define SafeAreaTopHeight (kScreenHeight == 812.0 ? 88 : 64)
/// 底部宏，底部角圆角的距离是34，设置底部的按钮按钮底部距离底部34
#define SafeAreaBottomHeight (kScreenHeight == 812.0 ? 34 : 0)
//NavBar高度
#define NavigationBar_HEIGHT 44
//TabBar高度
#define TabBar_HEIGHT 49


//数据库表名字
#define PUSH_DATA    @"pushdata"

//间距
#define Margin 12

//颜色
#define UIColorFromRGBA(r, g, b , a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

//常用
#define MAIN_BGD_COLOR   [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1]]

//红色
#define RED_COLOR   [UIColor colorWithHexString:@"#F35833"]

//蓝色
#define BLUE_COLOR  [UIColor colorWithHexString:@"#31B3EF"]

//灰字颜色
#define TEXT_GREY_COLOR  [UIColor colorWithHexString:@"#9B9B9B"]

#define TEXT_SUMMARY_COLOR [UIColor colorWithHexString:@"#4a4a4a"]

//下划线颜色
#define TEXT_LINE_COLOR  [UIColor colorWithHexString:@"#EBEBEB"]

// 主颜色
#define MAIN_COLOR [UIColor colorWithHexString:@"23aBec"]

// 横线颜色
#define LINE_COLOR [UIColor colorWithHexString:@"#e5e5e5"]

// 背景颜色
#define BACK_COLOR [UIColor colorWithHexString:@"#F5F5F5"]

#define BACK2_COLOR  [UIColor colorWithHexString:@"#F1F1F1"]


//缓存
#define KUserDefault [NSUserDefaults standardUserDefaults]
#define isTemp ![USER_DEFAULTS objectForKey:@"token"]

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self

#define IconFont  @"宋体"

#define HUD_DURATION         1.0



