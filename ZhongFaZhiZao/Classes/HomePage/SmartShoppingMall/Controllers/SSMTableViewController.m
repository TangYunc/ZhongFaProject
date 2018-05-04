//
//  SSMTableViewController.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/16.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "SSMTableViewController.h"
#import "SSMClassifyViewController.h"
#import "SSMTableViewCell.h"
#import "SSMFiltrateViewController.h"
#import "SSMSearchViewController.h"
#import "SSMTableResult.h"

@interface SSMTableViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    UIView *_headerBJView;
}
@property (nonatomic, assign) BOOL isSelectedPriceBtn;
@property (nonatomic, strong) NSNumber *pageTotal;
@property (nonatomic, strong) NSNumber *numberPage;
@property (nonatomic, strong) NSMutableArray *searchResultGoodsArr;
@end

@implementation SSMTableViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navBarView removeFromSuperview];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isSelectedPriceBtn = NO;
    self.numberPage = @1;
    [self setUpUI];
    // 初始化导航栏
    [self setupNavigationBar];
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    
}

- (void)headerRereshing{
    //下拉刷新
    [self loadSSMTableData];
}
- (void)footerRereshing{
    //上拉加载
    self.numberPage = [NSNumber numberWithDouble:[self.numberPage intValue] + 1];
    [self loadSSMTableDownDatas];
}


#pragma mark -初始化子视图
- (void)setUpUI{
    
    _headerBJView = [[UIView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, kScreenWidth, 86/2.0 * KWidth_ScaleH)];
    [self.view addSubview:_headerBJView];
    NSArray *btnNameArr = @[@"默认",@"价格",@"筛选"];
    NSInteger tempCount = btnNameArr.count;
    CGFloat mainBtnWidth = kScreenWidth/tempCount * KWidth_ScaleW;
    CGFloat mainBtnHeight = _headerBJView.height - 0.5;
    for (NSInteger i = 0 ; i < tempCount; i++) {
         UIButton *headerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        headerBtn.frame = CGRectMake(i * mainBtnWidth, 0, mainBtnWidth, mainBtnHeight);
        headerBtn.tag = i + 20;
        headerBtn.titleLabel.font = [UIFont systemFontOfSize:KFloat(13.f)];
        [headerBtn setBackgroundColor:[UIColor whiteColor]];
        [headerBtn setTitle:btnNameArr[i] forState:UIControlStateNormal];
        [headerBtn setTitleColor:[UIColor colorWithHexString:@"#4A4A4A"] forState:UIControlStateNormal];
        [headerBtn setTitleColor:[UIColor colorWithHexString:@"#31B3EF"] forState:UIControlStateSelected];
        [headerBtn addTarget:self action:@selector(headerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_headerBJView addSubview:headerBtn];
    }
    
    UIButton *defaultBtn = (UIButton *)[_headerBJView viewWithTag:20];
    defaultBtn.selected = YES;
    UIButton *priceBtn = (UIButton *)[_headerBJView viewWithTag:21];
    [priceBtn setImage:[UIImage imageNamed:@"SSMHeaderPriceNormalBtnIcon"] forState:UIControlStateNormal];
    if (self.isSelectedPriceBtn) {
        [priceBtn setImage:[UIImage imageNamed:@"SSMHeaderPriceRiseBtnIcon"] forState:UIControlStateSelected];
    }else{
        [priceBtn setImage:[UIImage imageNamed:@"SSMHeaderPriceDownBtnIcon"] forState:UIControlStateSelected];
    }
    priceBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -40);
    priceBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 40);
    UIButton *filtrateBtn = (UIButton *)[_headerBJView viewWithTag:22];
    [filtrateBtn setImage:[UIImage imageNamed:@"SSMHeaderfiltrateBtnNormalIcon"] forState:UIControlStateNormal];
    [filtrateBtn setImage:[UIImage imageNamed:@"SSMHeaderfiltrateBtnSelectedIcon"] forState:UIControlStateSelected];
    filtrateBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -5);
    filtrateBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
//    [filtrateBtn setImage:[UIImage imageNamed:@"SSMHeaderPriceDownBtnIcon"] forState:UIControlStateSelected];
    UIView *headerBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, priceBtn.bottom, kScreenWidth, 0.5)];
    [self.view addSubview:headerBottomView];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _headerBJView.bottom, kScreenWidth, kScreenHeight - SafeAreaTopHeight - _headerBJView.height - SafeAreaBottomHeight) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor colorWithHexString:@"#F4F4F4"];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    //    _tableView.tableHeaderView = contentView;
    _tableView.tableFooterView = [[UIView alloc] init];
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
- (void)loadSSMTableData{
    
    NSString *apiToken = [KUserDefault objectForKey:APIToken];
    if (apiToken == nil) {
        return;
    }
    NSMutableDictionary *tempPara = [NSMutableDictionary dictionary];
    [tempPara setObject:@"" forKey:@"sort"];
    [tempPara setObject:@"" forKey:@"classid"];
    [tempPara setObject:@"" forKey:@"min_price"];
    [tempPara setObject:@"" forKey:@"max_price"];
    [tempPara setObject:@"" forKey:@"location"];
    [tempPara setObject:@"" forKey:@"brand_id"];
    [tempPara setObject:@"" forKey:@"level"];
    [tempPara setObject:self.numberPage forKey:@"page"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@%@",BaseTwoApi,HomePageSSMTable_API,apiToken];
    [TNetworking getWithUrl:url params:tempPara success:^(id response) {
        
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
        [SSMTableBrand mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"tableBrandId" : @"id"
                     };
        }];
        [SSMTableItems mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"tableItemsId" : @"id"
                     };
        }];
        
        SSMTableResult *result = [SSMTableResult mj_objectWithKeyValues:response];
        if(result.success){
            
            self.searchResultGoodsArr = nil;
            [self.searchResultGoodsArr addObjectsFromArray:result.data.datas.items];
            
            self.pageTotal = result.data.datas.page.pageCount;
            if (self.searchResultGoodsArr.count == 0) {
                [_tableView.mj_footer setHidden:YES];
            }
            
            [_tableView reloadData];
            
            if ([result.data.datas.page.pageCount isEqual:self.numberPage]) {
                [_tableView.mj_footer endRefreshingWithNoMoreData];
            }
            
        }else {
            NSLog(@"%@",result.message);
        }

    } fail:^(NSError *error) {
        NSLog(@"error = %@",error);
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
        [WKProgressHUD popMessage:@"请检查网络连接" inView:self.view duration:HUD_DURATION animated:YES];
    } showHUD:NO];
}

-(void)loadSSMTableDownDatas
{
    // 1.请求参数
    NSString *apiToken = [KUserDefault objectForKey:APIToken];
    if (apiToken == nil) {
        return;
    }
    
    NSMutableDictionary *tempPara = [NSMutableDictionary dictionary];
    [tempPara setObject:@"" forKey:@"sort"];
    [tempPara setObject:@"" forKey:@"classid"];
    [tempPara setObject:@"" forKey:@"min_price"];
    [tempPara setObject:@"" forKey:@"max_price"];
    [tempPara setObject:@"" forKey:@"location"];
    [tempPara setObject:@"" forKey:@"brand_id"];
    [tempPara setObject:@"" forKey:@"level"];
    [tempPara setObject:self.numberPage forKey:@"page"];
    NSString *url = [NSString stringWithFormat:@"%@%@%@",BaseTwoApi,HomePageSSMTable_API,apiToken];
    
    // 发送请求
    [TNetworking getWithUrl:url params:tempPara success:^(id response) {
        [_tableView.mj_footer endRefreshing];
        
        SSMTableResult *result = [SSMTableResult mj_objectWithKeyValues:response];
        if(result.success){
            [self.searchResultGoodsArr addObjectsFromArray:result.data.datas.items];
            
            self.pageTotal = result.data.datas.page.pageCount;
            
            [_tableView reloadData];
            
            if ([result.data.datas.page.pageCount isEqual:self.numberPage]) {
                [_tableView.mj_footer endRefreshingWithNoMoreData];
            }
        }else{
            NSLog(@"%@",result.message);
            self.numberPage = [NSNumber numberWithDouble:[self.numberPage intValue] - 1];
        }
    } fail:^(NSError *error) {
        [_tableView.mj_footer endRefreshing];
    } showHUD:NO];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"SSMTableViewCellId";
    SSMTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[SSMTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSInteger section = indexPath.section;
    CGFloat height = 0.;
    height = 280/2.0 * KWidth_ScaleH;
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //    self.theIndexPath = indexPath;
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //先将未到时间执行前的任务取消。
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(todoSomething:) object:cell];
    [self performSelector:@selector(todoSomething:)withObject:cell afterDelay:0.2f];
    
}
- (void)todoSomething:(id)sender
{
    //    NSLog(@"点击率");
}

#pragma mark -- 按钮事件
- (void)BarButtonItemClick:(UIButton *)button{
    
    if (button.tag == 10) {
        NSLog(@"点击的是搜索");
        SSMSearchViewController *searchVC = [[SSMSearchViewController alloc] init];
        [self.navigationController pushViewController:searchVC animated:YES];
    }else if (button.tag == 11){
        NSLog(@"点击的是分类");
        SSMClassifyViewController *classifyTVC = [[SSMClassifyViewController alloc] init];
        [self.navigationController pushViewController:classifyTVC animated:YES];
    }
}

- (void)headerBtnClick:(UIButton *)button{
    
    UIButton *defaultBtn = (UIButton *)[_headerBJView viewWithTag:20];
    UIButton *priceBtn = (UIButton *)[_headerBJView viewWithTag:21];
    UIButton *filtrateBtn = (UIButton *)[_headerBJView viewWithTag:22];
    button.selected = !button.selected;
    if (button.selected) {
        [button setTitleColor:[UIColor colorWithHexString:@"#31B3EF"] forState:UIControlStateSelected];
    }else{
        [button setTitleColor:[UIColor colorWithHexString:@"#4A4A4A"] forState:UIControlStateNormal];
    }

    if (button.tag == 20) {
        NSLog(@"点击的是默认");
        priceBtn.selected = NO;
        filtrateBtn.selected = NO;
        self.isSelectedPriceBtn = NO;
    }else if (button.tag == 21){
        NSLog(@"点击的是价格");
        defaultBtn.selected = NO;
        filtrateBtn.selected = NO;
        priceBtn.selected = YES;
        self.isSelectedPriceBtn = !self.isSelectedPriceBtn;
    }else if (button.tag == 22){
       NSLog(@"点击的是筛选");
        defaultBtn.selected = NO;
        priceBtn.selected = NO;
        self.isSelectedPriceBtn = NO;
        SSMFiltrateViewController *filtrateVC = [[SSMFiltrateViewController alloc] init];
        [self.navigationController pushViewController:filtrateVC animated:YES];
    }
}

- (void)setIsSelectedPriceBtn:(BOOL)isSelectedPriceBtn{
    if (_isSelectedPriceBtn != isSelectedPriceBtn) {
        _isSelectedPriceBtn = isSelectedPriceBtn;
         UIButton *priceBtn = (UIButton *)[_headerBJView viewWithTag:21];
        if (!self.isSelectedPriceBtn) {
            [priceBtn setImage:[UIImage imageNamed:@"SSMHeaderPriceRiseBtnIcon"] forState:UIControlStateSelected];
        }else{
            [priceBtn setImage:[UIImage imageNamed:@"SSMHeaderPriceDownBtnIcon"] forState:UIControlStateSelected];
        }
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
