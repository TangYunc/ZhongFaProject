//
//  SSMSearchResultViewController.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/18.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "SSMSearchResultViewController.h"
#import "SSMSearchNoResultCell.h"
#import "SSMTableViewCell.h"
#import "SSMFiltrateViewController.h"
#import "SSMTableResult.h"

@interface SSMSearchResultViewController ()
{
    UIView *_headerBJView;
}

@property (nonatomic, assign) BOOL isSelectedPriceBtn;
@property (nonatomic, strong) NSNumber *pageTotal;
@property (nonatomic, strong) NSNumber *numberPage;
@property (nonatomic, strong) NSMutableArray *searchResultGoodsArr;
@property (nonatomic, strong) SSMTableDatas *theTableDatas;
@property (nonatomic, strong) NSIndexPath *theIndexPath;
@end

@implementation SSMSearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleColorChange:) name:@"searchBarDidChange" object:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self headerRereshing];
}

- (void)headerRereshing{
    self.numberPage = @1;
    //下拉刷新
    [self loadSSMTableData];
}
- (void)footerRereshing{
    //上拉加载
    self.numberPage = [NSNumber numberWithDouble:[self.numberPage intValue] + 1];
    [self loadSSMTableDownDatas];
}

#pragma mark -- loadData
- (void)loadSSMTableData{
    
    NSString *apiToken = [KUserDefault objectForKey:APIToken];
    if (apiToken == nil) {
        return;
    }
    if (self.sort == nil) {
        self.sort = @"";
    }
    if (self.classid == nil) {
        self.classid = @"";
    }
    if (self.min_price == nil) {
        self.min_price = @"";
    }
    if (self.max_price == nil) {
        self.max_price = @"";
    }
    if (self.location == nil) {
        self.location = @"";
    }
    if (self.brand_id == nil) {
        self.brand_id = @"";
    }
    if (self.level == nil) {
        self.level = @"";
    }
    if (self.name == nil) {
        self.name = @"";
    }
    
    NSMutableDictionary *tempPara = [NSMutableDictionary dictionary];
    [tempPara setObject:self.sort forKey:@"sort"];
    [tempPara setObject:self.classid forKey:@"classid"];
    [tempPara setObject:self.min_price forKey:@"min_price"];
    [tempPara setObject:self.max_price forKey:@"max_price"];
    [tempPara setObject:self.location forKey:@"location"];
    [tempPara setObject:self.brand_id forKey:@"brand_id"];
    [tempPara setObject:self.level forKey:@"level"];
    [tempPara setObject:self.name forKey:@"name"];
    [tempPara setObject:self.numberPage forKey:@"page"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@%@",BaseTwoApi,HomePageSSMTable_API,apiToken];
    [TNetworking removeTask:url];
    [TNetworking getWithUrl:url params:tempPara success:^(id response) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
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
            self.theTableDatas = result.data.datas;
            self.searchResultGoodsArr = nil;
            [self.searchResultGoodsArr addObjectsFromArray:result.data.datas.items];
            
            self.pageTotal = result.data.datas.page.pageCount;
            if (self.searchResultGoodsArr.count == 0) {
                [self.tableView.mj_footer setHidden:YES];
            }
            
            [self.tableView reloadData];
            
            if ([result.data.datas.page.pageCount isEqual:self.numberPage]) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            
        }else {
            NSLog(@"%@",result.message);
        }
        
    } fail:^(NSError *error) {
        NSLog(@"error = %@",error);
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [WKProgressHUD popMessage:error.localizedDescription inView:self.view duration:HUD_DURATION animated:YES];
    } showHUD:NO];
}

-(void)loadSSMTableDownDatas
{
    // 1.请求参数
    NSString *apiToken = [KUserDefault objectForKey:APIToken];
    if (apiToken == nil) {
        return;
    }
    if (self.sort == nil) {
        self.sort = @"";
    }
    if (self.classid == nil) {
        self.classid = @"";
    }
    if (self.min_price == nil) {
        self.min_price = @"";
    }
    if (self.max_price == nil) {
        self.max_price = @"";
    }
    if (self.location == nil) {
        self.location = @"";
    }
    if (self.brand_id == nil) {
        self.brand_id = @"";
    }
    if (self.level == nil) {
        self.level = @"";
    }
    if (self.name == nil) {
        self.name = @"";
    }
    
    NSMutableDictionary *tempPara = [NSMutableDictionary dictionary];
    [tempPara setObject:self.sort forKey:@"sort"];
    [tempPara setObject:self.classid forKey:@"classid"];
    [tempPara setObject:self.min_price forKey:@"min_price"];
    [tempPara setObject:self.max_price forKey:@"max_price"];
    [tempPara setObject:self.location forKey:@"location"];
    [tempPara setObject:self.brand_id forKey:@"brand_id"];
    [tempPara setObject:self.level forKey:@"level"];
    [tempPara setObject:self.name forKey:@"name"];
    [tempPara setObject:self.numberPage forKey:@"page"];
    NSString *url = [NSString stringWithFormat:@"%@%@%@",BaseTwoApi,HomePageSSMTable_API,apiToken];
    
    // 发送请求
    [TNetworking removeTask:url];
    [TNetworking getWithUrl:url params:tempPara success:^(id response) {
        [self.tableView.mj_footer endRefreshing];
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
            [self.searchResultGoodsArr addObjectsFromArray:result.data.datas.items];
            
            self.pageTotal = result.data.datas.page.pageCount;
            
            [self.tableView reloadData];
            
            if ([result.data.datas.page.pageCount isEqual:self.numberPage]) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
        }else{
            NSLog(@"%@",result.message);
            self.numberPage = [NSNumber numberWithDouble:[self.numberPage intValue] - 1];
        }
    } fail:^(NSError *error) {
        [self.tableView.mj_footer endRefreshing];
    } showHUD:NO];
}

- (NSMutableArray *)searchResultGoodsArr{
    if (!_searchResultGoodsArr) {
        _searchResultGoodsArr = [NSMutableArray array];
    }
    return _searchResultGoodsArr;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.searchResultGoodsArr.count == 0) {
        return 1;
    }
    return self.searchResultGoodsArr.count;;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.searchResultGoodsArr.count == 0) {
        static NSString *identifier = @"SSMSearchNoResultCellID";
        SSMSearchNoResultCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[SSMSearchNoResultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        return cell;
    }
    static NSString *identifier = @"SSMTableViewCellId";
    SSMTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[SSMTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.theItems = self.searchResultGoodsArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 0;
    if (self.searchResultGoodsArr.count == 0) {
        return kScreenHeight - SafeAreaTopHeight - 106/2.0 * KWidth_ScaleH;
    }else{
        height = 280/2.0 * KWidth_ScaleH;
    }
    return height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    _headerBJView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 86/2.0 * KWidth_ScaleH)];
    [self.view addSubview:_headerBJView];
    NSArray *btnNameArr = @[@"综合",@"价格",@"筛选"];
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
    UIView *headerBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, priceBtn.bottom, kScreenWidth, 20/2.0 * KWidth_ScaleH)];
    headerBottomView.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    [_headerBJView addSubview:headerBottomView];
    return _headerBJView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 106/2.0 * KWidth_ScaleH;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.searchResultGoodsArr.count == 0) {
        return;
    }
    
    self.theIndexPath = indexPath;
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //先将未到时间执行前的任务取消。
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(todoSomething:) object:cell];
    [self performSelector:@selector(todoSomething:)withObject:cell afterDelay:0.2f];
}

- (void)todoSomething:(id)sender
{
    //    NSLog(@"点击率");
    SSMTableItems *theItems = self.searchResultGoodsArr[self.theIndexPath.row];
    NSString *url = [NSString stringWithFormat:@"http://wap.cecb2b.com/corp/nicInfo/%@?corpId=123",theItems.tableItemsId];
    [self choiceTheImageUrl:url];
}

#pragma mark -- method
- (void)choiceTheImageUrl:(NSString *)url{
    WKWebViewViewController *vc = [[WKWebViewViewController alloc]initWithUrlStr:[NSString stringWithFormat:@"%@",url] title:@"商品详情"];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.didSelectText(@"");
}

#pragma mark -- 按钮事件
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
        defaultBtn.selected = YES;
        priceBtn.selected = NO;
        filtrateBtn.selected = NO;
        self.isSelectedPriceBtn = NO;
        self.sort = @"";
        self.classid = @"";
        self.min_price = @"";
        self.max_price = @"";
        self.location = @"";
        self.brand_id = @"";
        self.level = @"";
        self.name = @"";
        [self loadSSMTableData];
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
        filtrateVC.theDatas = self.theTableDatas;
        WS(weakSelf);
        filtrateVC.block = ^(NSString *locationStr, NSString *brandStr, NSString *minPriceStr, NSString *maxPriceStr) {
            weakSelf.location = locationStr;
            weakSelf.brand_id = brandStr;
            weakSelf.max_price = maxPriceStr;
            weakSelf.min_price = minPriceStr;
            [weakSelf loadSSMTableData];
        };
        [self.navigationController pushViewController:filtrateVC animated:YES];
    }
}
- (void)setIsSelectedPriceBtn:(BOOL)isSelectedPriceBtn{
    if (_isSelectedPriceBtn != isSelectedPriceBtn) {
        _isSelectedPriceBtn = isSelectedPriceBtn;
        UIButton *priceBtn = (UIButton *)[_headerBJView viewWithTag:21];
        if (!self.isSelectedPriceBtn) {
            [priceBtn setImage:[UIImage imageNamed:@"SSMHeaderPriceRiseBtnIcon"] forState:UIControlStateSelected];
            self.sort = @"price asc";
        }else{
            [priceBtn setImage:[UIImage imageNamed:@"SSMHeaderPriceDownBtnIcon"] forState:UIControlStateSelected];
            self.sort = @"price desc";
        }
        [self loadSSMTableData];
    }
}


#pragma mrak -- 通知
-(void)handleColorChange:(NSNotification* )sender
{
    NSString *text = sender.userInfo[@"searchText"];
    self.name = text;
    [self loadSSMTableData];
    NSLog(@"%@", text);
    self.didSelectText(text);
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
