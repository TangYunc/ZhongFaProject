//
//  SSMViewController.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/14.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "SSMViewController.h"
#import "SSMTableView.h"
#import "SSMClassifyViewController.h"
#import "SSMSearchViewController.h"
#import "SSMResult.h"

@interface SSMViewController ()
{
    SSMTableView *_SSMTableView;
}

@end

@implementation SSMViewController

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
    [self loadSSMData];
}
#pragma mark -初始化子视图
- (void)setUpUI{
    _SSMTableView = [[SSMTableView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, kScreenWidth, kScreenHeight - SafeAreaTopHeight - SafeAreaBottomHeight) style:UITableViewStylePlain];
    _SSMTableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_SSMTableView];
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

#pragma mark -- loadData
- (void)loadSSMData{
    
    NSString *apiToken = [KUserDefault objectForKey:APIToken];
    if (apiToken == nil) {
        return;
    }
    
    NSString *url = [NSString stringWithFormat:@"%@%@%@",BaseTwoApi,HomePageSSM_API,apiToken];
    [TNetworking getWithUrl:url params:nil success:^(id response) {
        [SSMDatasBanner mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"bannerId" : @"id",@"bannerDescription" : @"description"
                     };
        }];
        [SSMDatasBusiness mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"businessId" : @"id",@"businessDescription" : @"description"
                     };
        }];
        [SSMDatasGoodProduct mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"goodProductId" : @"id"
                     };
        }];
        [SSMDatasCatesItems mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"catesItemId" : @"id"
                     };
        }];
        SSMResult *result = [SSMResult mj_objectWithKeyValues:response];
        if (result.success) {
            _SSMTableView.theDatas = result.data.datas;
            [_SSMTableView reloadData];
        }else{
            
            NSLog(@"%@",result.message);
        }
    } fail:^(NSError *error) {
        NSLog(@"error = %@",error);
        
        [WKProgressHUD popMessage:@"请检查网络连接" inView:self.view duration:HUD_DURATION animated:YES];
    } showHUD:NO];
}


#pragma mark -- 按钮事件
- (void)BarButtonItemClick:(UIButton *)button{
    
    if (button.tag == 10) {
        NSLog(@"点击的是搜索");
        SSMSearchViewController *searchVC = [[SSMSearchViewController alloc] init];
        searchVC.tagsArray = @[@"卜卜芥", @"卜人参", @"卜卜人发", @"儿茶", @"八角", @"三卜七", @"广白", @"大黄", @"大黄", @"广卜卜卜丹",@"卜卜芥", @"卜人参", @"卜卜人发", @"儿茶", @"八角"];
        [self.navigationController pushViewController:searchVC animated:YES];
    }else if (button.tag == 11){
        NSLog(@"点击的是分类");
        SSMClassifyViewController *classifyTVC = [[SSMClassifyViewController alloc] init];
        [self.navigationController pushViewController:classifyTVC animated:YES];
    }
}

- (void)dealloc
{
    NSLog(@"释放了");
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
