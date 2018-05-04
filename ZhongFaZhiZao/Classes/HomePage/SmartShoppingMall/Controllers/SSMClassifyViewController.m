//
//  SSMClassifyViewController.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/16.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "SSMClassifyViewController.h"
#import "SSMClassifyCell.h"
#import "SSMSearchViewController.h"
#import "SSMClassifyResult.h"

@interface SSMClassifyViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    
}
@property (nonatomic,strong)NSMutableArray *flagArray;
@property (nonatomic, copy) NSString *imageNameStr;
@property (nonatomic,strong)UIImageView *openOrCloseFounctionManagerImg;

@property (nonatomic,strong)NSArray *theDatas;
@end

@implementation SSMClassifyViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navBarView removeFromSuperview];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self makeData];
    [self setUpUI];
    // 初始化导航栏
    [self setupNavigationBar];
    [self loadSSMClassifyData];
    
}

#pragma mark -初始化子视图
- (void)setUpUI{
    
    self.imageNameStr = @"MineAuxiliaryIcon";//默认功能管理辅助视图的图片的名字
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, kScreenWidth, kScreenHeight - SafeAreaTopHeight - SafeAreaBottomHeight) style:UITableViewStylePlain];
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
    
    NavigationControllerView *navView = [[NavigationControllerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, SafeAreaTopHeight) andLeftBtn:@"分类"];
    navView.viewController = self;
    CGFloat rightBtnWidth = 35/2.0 * KWidth_ScaleW;
    CGFloat rightBtnHeight = 35/2.0 * KWidth_ScaleW;
    CGFloat rightBtnGapFromLeft = kScreenWidth - (24 + 35)/2.0 * KWidth_ScaleW;
        
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(rightBtnGapFromLeft, SafeAreaTopHeight -rightBtnHeight - 34/2.0 * KWidth_ScaleH, rightBtnWidth, rightBtnHeight);
    rightBtn.imageView.frame = rightBtn.bounds;
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"SSMRightNavSearchIcon"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(BarButtonItemClick:) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:rightBtn];
    [self.view addSubview:navView];
}

- (void)makeData{
    
    _flagArray  = [NSMutableArray array];
    NSInteger num = 6;
    for (int i = 0; i < num; i ++) {
        [_flagArray addObject:@"0"];
    }
}

#pragma mark -- loadData
- (void)loadSSMClassifyData{
    
    NSString *apiToken = [KUserDefault objectForKey:APIToken];
    if (apiToken == nil) {
        return;
    }
    
    NSString *url = [NSString stringWithFormat:@"%@%@%@",BaseTwoApi,HomePageSSMClassify_API,apiToken];
    [TNetworking getWithUrl:url params:nil success:^(id response) {
        [SSMClassifySubclass mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"classifySubclassId" : @"id"
                     };
        }];
        [SSMClassifyDatas mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"classifyId" : @"id"
                     };
        }];
        
        SSMClassifyResult *result = [SSMClassifyResult mj_objectWithKeyValues:response];
        if (result.success) {
            self.theDatas = result.data.datas;
            [_tableView reloadData];
        }else{
            
            NSLog(@"%@",result.message);
        }
    } fail:^(NSError *error) {
        NSLog(@"error = %@",error);
        
        [WKProgressHUD popMessage:@"请检查网络连接" inView:self.view duration:HUD_DURATION animated:YES];
    } showHUD:NO];
}

#pragma mark - Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.theDatas.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"SSMClassifyCellId";
    SSMClassifyCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[SSMClassifyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.clipsToBounds = YES;
    cell.datas = self.theDatas[indexPath.section];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    CGFloat height = 0.;
    if ([_flagArray[indexPath.section] isEqualToString:@"0"]) {
        return height;
    }else{
        height = (80 * 3 + 10 * 3)/2.0 * KWidth_ScaleH;
    }
    return height;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    CGFloat titleViewHeight = 80/2.0 * KWidth_ScaleH;
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, titleViewHeight)];
    titleView.backgroundColor = [UIColor whiteColor];
        
    UIView *topGapView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20/2.0 * KWidth_ScaleH)];
    topGapView.backgroundColor = UIColorFromRGBA(245, 245, 245, 1.0);
    [titleView addSubview:topGapView];
        
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, topGapView.bottom, 100, 40)];
    titleLabel.textColor = [UIColor colorWithHexString:@"#1C1C1C"];
    titleLabel.font = [UIFont systemFontOfSize:KFloat(16)];
    [titleView addSubview:titleLabel];
        
        
    UIImageView *openOrCloseImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, (titleView.height - 14) / 2.0, 8, 15)];
    openOrCloseImageView.right = titleView.right - 19;
    openOrCloseImageView.centerY = titleLabel.centerY;
//    openOrCloseImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    openOrCloseImageView.image = [UIImage imageNamed:self.imageNameStr];
    [titleView addSubview:openOrCloseImageView];
    self.openOrCloseFounctionManagerImg = openOrCloseImageView;
        
    UIView *gapLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 53.5, kScreenWidth, 0.5)];
    gapLineView.backgroundColor = UIColorFromRGBA(245, 245, 245, 1.0);
    [titleView addSubview:gapLineView];
        
    titleView.tag = 100 + section;
    titleView.userInteractionEnabled = YES;
        
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sectionClick:)];
    [titleView addGestureRecognizer:tap];
    
//    NSArray *sectionTitleArr = @[@"全部分类",@"智能控制",@"工业软件",@"智能制造装备",@"3D打印",];
    SSMClassifyDatas *classifyDatas = self.theDatas[section];
    titleLabel.text = classifyDatas.name;
        return titleView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 54;
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
    
    NSLog(@"点击的是搜索");
    SSMSearchViewController *searchVC = [[SSMSearchViewController alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
}

- (void)sectionClick:(UITapGestureRecognizer *)tap{
    int index = tap.view.tag % 100;
    
    NSMutableArray *indexArray = [[NSMutableArray alloc]init];
    
    
    if ([_flagArray[index] isEqualToString:@"0"]) {//展开
        _flagArray[index] = @"1";
//        self.imageNameStr = @"SSMClassifyCloseIcon";
//        self.openOrCloseFounctionManagerImg.image = [UIImage imageNamed:self.imageNameStr];
        [_tableView reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationBottom];  //使用下面注释的方法就 注释掉这一句
    } else { //收起
        _flagArray[index] = @"0";
//        self.imageNameStr = @"SSMClassifyOpenIcon";
//        self.openOrCloseFounctionManagerImg.image = [UIImage imageNamed:self.imageNameStr];
        [_tableView reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationTop]; //使用下面注释的方法就 注释掉这一句
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
