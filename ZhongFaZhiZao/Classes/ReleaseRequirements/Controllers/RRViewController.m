//
//  RRViewController.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/12.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "RRViewController.h"
#import "RRCustomizedViewController.h"
#import "RRRecruitmentViewController.h"
#import "RRAgencyViewController.h"
#import "RRSegmentView.h"

@interface RRViewController ()

@end

@implementation RRViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navBarView removeFromSuperview];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 初始化
    [self setUpUI];

    // 初始化导航栏
    [self setupNavigationBar];
}

#pragma mark -初始化子视图
- (void)setUpUI{
    [self setupChildVc];
}

#pragma mark -初始化导航栏
- (void)setupNavigationBar {

    NavigationControllerView *navView = [[NavigationControllerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, SafeAreaTopHeight) andLeftBtn:@"发布需求"];
    navView.viewController = self;
    [self.view addSubview:navView];
}

- (void)setupChildVc{
    
    RRCustomizedViewController *rrVC1 = [[RRCustomizedViewController alloc] init];
    [self addChildViewController:rrVC1];
    
    RRRecruitmentViewController *rrVC2 = [[RRRecruitmentViewController alloc] init];
    [self addChildViewController:rrVC2];
    
    RRAgencyViewController *rrVC3 = [[RRAgencyViewController alloc] init];
    [self addChildViewController:rrVC3];
    
    
    NSArray *controllers = @[rrVC1,rrVC2,rrVC3];
    NSArray *titleArray = @[@"定制需求",@"招代理需求",@"找代理需求 "];
//    NSInteger tempCount = moneyArr.count;
//    for (NSInteger i = 0; i < tempCount; i++) {
//        [controllers[i] setCumulativeValue:moneyArr[i]];
//    }
    RRSegmentView *rrs = [[RRSegmentView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, kScreenWidth, kScreenHeight - SafeAreaTopHeight - SafeAreaBottomHeight) buttonName:titleArray contrllers:controllers parentController:self defaultIndex:0];
    [rrs clickDefaultIndex:3];
    [self.view addSubview:rrs];
    
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
