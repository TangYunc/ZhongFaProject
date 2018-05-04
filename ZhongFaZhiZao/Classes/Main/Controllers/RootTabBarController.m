//
//  RootTabBarController.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/3/1.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "RootTabBarController.h"
#import "BaseNavigationController.h"
#import "CustomBarButton.h"
#import "CustomTabBar.h"

#import "HomeViewController.h"
//#import "CounselingViewController.h"
#import "MessageCenterViewController.h"
#import "PurchaseViewController.h"
#import "MineViewController.h"

@interface RootTabBarController ()<CustomTabBarDelegate>

@property(nonatomic, weak)CustomTabBar *customTabBar;

@end

@implementation RootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CustomTabBar *customTabBar = [[CustomTabBar alloc] init];
    customTabBar.frame = self.tabBar.bounds;
    [self.tabBar addSubview:customTabBar];
    self.customTabBar = customTabBar;
    
    self.customTabBar.delegate = self;
    [self loadDateAPIToken];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    for (UIView *subView in self.tabBar.subviews) {
        if ([subView isKindOfClass:[UIControl class]]) {
            [subView removeFromSuperview];
        }
    }
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSLog(@"self======%@",self);
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [child removeFromSuperview];
        }
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //01 首页
        HomeViewController *homeVC = [[HomeViewController alloc] init];
        homeVC.view.backgroundColor = [UIColor whiteColor];
        [self addOneChildViewController:homeVC title:@"首页" norImage:@"HomeNormal" selectedImage:@"HomeSelected"];
        //02 咨询
        MessageCenterViewController *messageVC = [[MessageCenterViewController alloc] init];
        messageVC.view.backgroundColor = [UIColor whiteColor];
//        CounselingViewController *counselingVC = [[CounselingViewController alloc] init];
//        counselingVC.view.backgroundColor = [UIColor whiteColor];
        [self addOneChildViewController:messageVC title:@"消息" norImage:@"CounselingNormal" selectedImage:@"CounselingSelected"];
        //03 采购料单
        PurchaseViewController *purchaseVC = [[PurchaseViewController alloc] init];
        purchaseVC.view.backgroundColor = [UIColor whiteColor];
        [self addOneChildViewController:purchaseVC title:@"购物车" norImage:@"PurchaseNormal" selectedImage:@"PurchaseSelected"];
        //02 我的
        MineViewController *mineVC = [[MineViewController alloc] init];
        mineVC.view.backgroundColor = [UIColor whiteColor];
        [self addOneChildViewController:mineVC title:@"我的" norImage:@"MineNormal" selectedImage:@"MineSelected"];
    }
    return self;
}

-(void)addOneChildViewController:(UIViewController *)childVc title:(NSString *)title norImage:(NSString *)norImage selectedImage:(NSString *)selectedImage
{
    childVc.title = title;
    
    childVc.tabBarItem.image = [UIImage imageNamed:norImage];
    
    UIImage *selImage = [UIImage imageNamed:selectedImage];
    if (iOS7) {
        selImage = [selImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    childVc.tabBarItem.selectedImage = selImage;
    
    
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
    
    [self.customTabBar  addTabBarButton:childVc.tabBarItem];
    
}

#pragma mark -- 加载数据
- (void)loadDateAPIToken{
    
    //获取与接口约定的Token
    NSMutableDictionary *tempPara = [NSMutableDictionary dictionary];
    [tempPara setObject:@"admin" forKey:@"username"];
    [tempPara setObject:@"admin" forKey:@"password"];
    [TNetworking postWithUrl:accessToken_API params:tempPara success:^(id response) {
        if ([response[@"success"] boolValue]) {
            NSString *theAPIToken = response[@"data"][@"token"];
            [KUserDefault setObject:theAPIToken forKey:APIToken];
            [KUserDefault synchronize];
        }
    } fail:^(NSError *error) {
        
    } showHUD:NO];
}

#pragma mark - YDTabBarDelegate
-(void)tabBar:(CustomTabBar *)tabBar from:(NSInteger)from to:(NSInteger)to
{
    NSLog(@"%zd",to);
    
    self.selectedIndex = to;
}

-(void)tabBarPresentViewController:(CustomTabBar *)tabBar{
    
}
-(void)selectTabItem:(NSInteger)index{
    NSLog(@"index:%ld",(long)index);
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
