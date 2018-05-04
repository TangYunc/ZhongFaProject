//
//  MineViewController.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/3/1.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "MineViewController.h"
#import "MineHeaderView.h"
#import "MineTableView.h"
#import "MinePersonalInfoModel.h"

@interface MineViewController ()<UIScrollViewDelegate>{
    
    MineHeaderView *_contentView;

}
// tableView
@property (nonatomic, strong) MineTableView *tableView;
// headerHeight
@property (nonatomic, assign) CGFloat headerHeight;
// headerImageView
@property (nonatomic, strong) UIImageView *headerImageView;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 初始化TableView
    [self setupTableView];
    NSLog(@"theTokenMine:%@",[KUserDefault objectForKey:@"token"]);
    if ([KUserDefault objectForKey:@"token"]) {

        [self loadData];
    }
    
    //    定义通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess) name:@"sucess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginOut:) name:@"loginOut" object:nil];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
#pragma mark -初始化TableView

- (void)setupTableView {
    
    // TableView
    self.tableView = [[MineTableView alloc] init];
    self.tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - TabBar_HEIGHT - SafeAreaBottomHeight);
    [self.view addSubview:self.tableView];
    
    NSLog(@"宽：%f----高：%f",KWidth_ScaleW,KWidth_ScaleH);
    //header
    self.headerHeight = 291 * KWidth_ScaleH;
    CGRect bounds = CGRectMake(0, 0, kScreenWidth, self.headerHeight);
    _contentView = [[MineHeaderView alloc] initWithFrame:bounds];
    _contentView.backgroundColor = BLUE_COLOR;
    self.tableView.tableHeaderView = _contentView;
}

- (void)loadData{
    
    [TNetworking getWithUrl:[NSString stringWithFormat:@"%@%@",BaseApi,MineMember_api] params:nil success:^(id response) {
        MinePersonalInfoModel *result = [MinePersonalInfoModel mj_objectWithKeyValues:response];
        if (result.resultCode == 1000) {
            
            _contentView.personalInformation = result.data;
            
            self.tableView.theOrderCount = result.data.orderCount;
            [self.tableView reloadData];
            id waitpayCount = response[@"data"][@"orderCount"][@"waitpayCount"];
            if ([waitpayCount isKindOfClass:[NSNull class]]) {
                NSLog(@"返回的数据类型有问题");
                return ;
            }
        }else if (result.resultCode == 1001){
            
            NSLog(@"会员中心请求失败");
        }else if (result.resultCode == 1002){
            
            NSLog(@"未登录");
            _contentView.loginBtn.hidden = NO;
            _contentView.nameLabel.hidden = YES;
            _contentView.informationBtn.hidden = YES;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"NoLogin" object:nil];
            });
//            _redLbl1.hidden = YES;
//            _redLbl2.hidden = YES;
//            _redLbl3.hidden = YES;
//            _redLbl4.hidden = YES;
            
            _contentView.bqLbl.hidden =YES;
        }
    } fail:^(NSError *error) {
        
        NSLog(@"%@",error);
        [WKProgressHUD popMessage:@"请检查网络连接" inView:self.view duration:HUD_DURATION animated:YES];
    } showHUD:NO];
}

#pragma mark -- 通知
//定义将要调用的方法
- (void)loginSuccess{
    
    [self loadData];
}

#pragma mark --通知
- (void)loginOut:(NSNotification *)notify{
    
    [self.tableView reloadData];
}
- (void)dealloc
{
    // 删除监听认领商品的通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"dealloc:MineViewController");
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
