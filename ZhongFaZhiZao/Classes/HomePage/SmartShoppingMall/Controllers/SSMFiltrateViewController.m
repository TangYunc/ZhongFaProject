//
//  SSMFiltrateViewController.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/16.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "SSMFiltrateViewController.h"
#import "SSMFiltrateTabelView.h"
#import "SSMClassifyViewController.h"

@interface SSMFiltrateViewController ()
{
    SSMFiltrateTabelView *_filtrateTableView;
}
@end

@implementation SSMFiltrateViewController

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
    NSArray *btnNameArr = @[@"重置",@"确定"];
    NSArray *btnBJColorArr = @[@"#FFFFFF",@"#31B3EF"];
    NSArray *btnTitleColorArr = @[@"#999999",@"#FFFFFF"];
    NSInteger tempCount = btnNameArr.count;
    CGFloat btnWidth = kScreenWidth / tempCount;
    CGFloat btnHeight = 128 / 2.0 * KWidth_ScaleH;
    
    _filtrateTableView = [[SSMFiltrateTabelView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, kScreenWidth, kScreenHeight - SafeAreaTopHeight - btnHeight - SafeAreaBottomHeight) style:UITableViewStylePlain];
    _filtrateTableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_filtrateTableView];
    
    
    for (NSInteger i = 0; i < tempCount; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i * btnWidth, kScreenHeight - btnHeight - SafeAreaBottomHeight, btnWidth, btnHeight);
        button.tag = 10 + i;
        [button setTitle:btnNameArr[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:btnTitleColorArr[i]] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor colorWithHexString:btnBJColorArr[i]]];
        [button addTarget:self action:@selector(bottomClick:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont systemFontOfSize:KFloat(14.f)];
        [self.view addSubview:button];
    }
}

#pragma mark -初始化导航栏
- (void)setupNavigationBar {
    
    NavigationControllerView *navView = [[NavigationControllerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, SafeAreaTopHeight) andLeftBtn:@"智造商城"];
    navView.viewController = self;
    NSArray *imageNames = @[@"SSMRightNavSearchIcon",@"SSMRightNavClassifyIcon"];
    CGFloat gapWidth = 24/2.0 * KWidth_ScaleW;
    CGFloat rightBtnWidth = 35/2.0 * KWidth_ScaleW;
    CGFloat rightBtnHeight = 35/2.0 * KWidth_ScaleW;
    CGFloat rightBtnGapFromLeft = kScreenWidth - (24 + 35 * 2 + 35)/2.0 * KWidth_ScaleW;
    for (NSInteger i = 0; i < 2; i++) {
        
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.frame = CGRectMake(rightBtnGapFromLeft + i * (rightBtnWidth + gapWidth), SafeAreaTopHeight -rightBtnHeight - 34/2.0 * KWidth_ScaleH, rightBtnWidth, rightBtnHeight);
        rightBtn.tag = 10 + i;
        rightBtn.imageView.frame = rightBtn.bounds;
        rightBtn.hidden = NO;
        [rightBtn setBackgroundImage:[UIImage imageNamed:imageNames[i]] forState:UIControlStateNormal];
        [rightBtn addTarget:self action:@selector(BarButtonItemClick:) forControlEvents:UIControlEventTouchUpInside];
        [navView addSubview:rightBtn];
    }
    [self.view addSubview:navView];
}

#pragma mark -- 按钮事件
- (void)BarButtonItemClick:(UIButton *)button{
    
    if (button.tag == 10) {
        NSLog(@"点击的是搜索");
    }else if (button.tag == 11){
        NSLog(@"点击的是分类");
        SSMClassifyViewController *classifyTVC = [[SSMClassifyViewController alloc] init];
        [self.navigationController pushViewController:classifyTVC animated:YES];
    }
}

- (void)bottomClick:(UIButton *)button{
    if (button.tag == 10) {
        NSLog(@"点击重置");
    }else if (button.tag == 11){
        NSLog(@"点击确认");
    }
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
