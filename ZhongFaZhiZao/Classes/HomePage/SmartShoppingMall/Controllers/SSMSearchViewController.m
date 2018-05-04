//
//  SSMSearchViewController.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/18.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "SSMSearchViewController.h"
#import "SSMSearchResultViewController.h"
#import <MJRefresh/MJRefresh.h>

#define PYSEARCH_SEARCH_HISTORY_CACHE_PATH [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"MLSearchhistories.plist"] // 搜索历史存储路径


@interface SSMSearchViewController ()<UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>

/** 搜索建议（推荐）控制器 */
@property (nonatomic, weak) SSMSearchResultViewController *searchSuggestionVC;
/** 搜索历史记录缓存数量，默认为20 */
@property (nonatomic, assign) NSUInteger searchHistoriesCount;
/** 搜索历史 */
@property (nonatomic, strong) NSMutableArray *searchHistories;
/** 搜索历史缓存保存路径, 默认为PYSEARCH_SEARCH_HISTORY_CACHE_PATH(PYSearchConst.h文件中的宏定义) */
@property (nonatomic, copy) NSString *searchHistoriesCachePath;


@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *tagsView;

@end

@implementation SSMSearchViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navBarView removeFromSuperview];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (SSMSearchResultViewController *)searchSuggestionVC
{
    if (!_searchSuggestionVC) {
        SSMSearchResultViewController *searchSuggestionVC = [[SSMSearchResultViewController alloc] initWithStyle:UITableViewStylePlain];
        __weak typeof(self) _weakSelf = self;
        searchSuggestionVC.didSelectText = ^(NSString *didSelectText) {
            
            if ([didSelectText isEqualToString:@""]) {
                [self.searchBar resignFirstResponder];
            }
            else
            {
                // 设置搜索信息
                _weakSelf.searchBar.text = didSelectText;
                
                // 缓存数据并且刷新界面
                [_weakSelf saveSearchCacheAndRefreshView];
            }
        };
        searchSuggestionVC.view.frame = CGRectMake(0, 64, self.view.mj_w, self.view.mj_h);
        searchSuggestionVC.view.backgroundColor = [UIColor whiteColor];
        
        [self.view addSubview:searchSuggestionVC.view];
        [self addChildViewController:searchSuggestionVC];
        _searchSuggestionVC = searchSuggestionVC;
    }
    return _searchSuggestionVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 初始化
    [self setUpUI];
    
    // 初始化导航栏
    [self setupNavigationBar];
}

/** 视图完全显示 */
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // 弹出键盘
    [self.searchBar becomeFirstResponder];
}

/** 视图即将消失 */
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // 回收键盘
    [self.searchBar resignFirstResponder];
}

#pragma mark -初始化子视图
- (void)setUpUI{
    
    //tableview
    self.searchHistoriesCount = 20;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, kScreenWidth, kScreenHeight - SafeAreaTopHeight - SafeAreaBottomHeight) style:UITableViewStylePlain];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    /*
    self.headerView = [[UIView alloc] init];
    self.headerView.mj_x = 0;
    self.headerView.mj_y = 0;
    self.headerView.mj_w = kScreenWidth;
    
    UIView *titleLabelBJView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 80/2.0 * KWidth_ScaleH)];
    titleLabelBJView.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    [self.headerView addSubview:titleLabelBJView];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, kScreenWidth-20, 30)];
    titleLabel.text = @"热搜";
    titleLabel.font = [UIFont systemFontOfSize:KFloat(16.f)];
    titleLabel.textColor = [UIColor colorWithHexString:@"#4A4A4A"];
    [titleLabel sizeToFit];
    [titleLabelBJView addSubview:titleLabel];
    titleLabel.centerY = titleLabelBJView.centerY;
    self.tagsView = [[UIView alloc] init];
    self.tagsView.mj_x = 10;
    self.tagsView.mj_y = titleLabel.mj_y+30;
    self.tagsView.mj_w = kScreenWidth-20;
    
    [self.headerView addSubview:self.tagsView];
    
    
//    self.tagsView.backgroundColor = [UIColor redColor];
//    self.headerView.backgroundColor = [UIColor orangeColor];
//    titleLabel.backgroundColor = [UIColor yellowColor];
//    self.tableView.backgroundColor = [UIColor greenColor];
    
    self.tableView.tableHeaderView = self.headerView;
     */
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    UILabel *footLabel = [[UILabel alloc] initWithFrame:footView.frame];
    footLabel.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5 "];
    footLabel.textColor = [UIColor colorWithHexString:@"#4A4A4A"];
    footLabel.font = [UIFont systemFontOfSize:KFloat(14.f)];
    footLabel.userInteractionEnabled = YES;
    footLabel.text = @"清空搜索记录";
    footLabel.textAlignment = NSTextAlignmentCenter;
    
    [footLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(emptySearchHistoryDidClick)]];
    [footView addSubview:footLabel];
    
    
    self.tableView.tableFooterView = footView;
    
    
    [self tagsViewWithTag];
}

#pragma mark -初始化导航栏
- (void)setupNavigationBar {
    
    NavigationControllerView *navView = [[NavigationControllerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, SafeAreaTopHeight) andtitle:@""];
    
    navView.viewController = self;
    // 创建搜索框
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth-64-20, 30)];
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(-10, 0, titleView.frame.size.width, 30)];
    searchBar.placeholder = @"搜索产品名称或型号";
    searchBar.delegate = self;
    searchBar.backgroundColor = [UIColor whiteColor];
    searchBar.layer.cornerRadius = 12;
    searchBar.layer.masksToBounds = YES;
    [searchBar.layer setBorderWidth:8];
    [searchBar.layer setBorderColor:[UIColor whiteColor].CGColor];
    [titleView addSubview:searchBar];
    self.searchBar = searchBar;
    [navView addSubview:titleView];
    titleView.center = CGPointMake(kScreenWidth/2.0 - 10, SafeAreaTopHeight - 22);
    
    NSString *cancelStr = @"取消";
    CGSize cancelStrSize =[cancelStr sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:KFloat(14.f)]}];
    CGFloat rightBtnWidth = cancelStrSize.width;
    CGFloat rightBtnHeight = 40/2.0 * KWidth_ScaleW;
    CGFloat rightBtnGapFromLeft = 13/2.0 * KWidth_ScaleW;
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(titleView.right + rightBtnGapFromLeft, 0, rightBtnWidth, rightBtnHeight);
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelBtn setTitle:cancelStr forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:KFloat(14.f)];
    [cancelBtn addTarget:self action:@selector(cancelDidClick) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:cancelBtn];
    cancelBtn.centerY = titleView.centerY;
    
    [self.view addSubview:navView];
}

#pragma mark -- method
- (void)tagsViewWithTag
{
    CGFloat allLabelWidth = 0;
    CGFloat allLabelHeight = 0;
    int rowHeight = 0;
    
    for (int i = 0; i < self.tagsArray.count; i++) {
        
        
        if (i != self.tagsArray.count-1) {
            
            CGFloat width = [self getWidthWithTitle:self.tagsArray[i+1] font:[UIFont systemFontOfSize:KFloat(14.f)]];
            if (allLabelWidth + width+10 > self.tagsView.frame.size.width) {
                rowHeight++;
                allLabelWidth = 0;
                allLabelHeight = rowHeight*40;
            }
        }else{
            
            CGFloat width = [self getWidthWithTitle:self.tagsArray[self.tagsArray.count-1] font:[UIFont systemFontOfSize:KFloat(14.f)]];
            if (allLabelWidth + width+10 > self.tagsView.frame.size.width) {
                rowHeight++;
                allLabelWidth = 0;
                allLabelHeight = rowHeight*40;
            }
        }
        
        UILabel *rectangleTagLabel = [[UILabel alloc] init];
        // 设置属性
        rectangleTagLabel.userInteractionEnabled = YES;
        rectangleTagLabel.font = [UIFont systemFontOfSize:KFloat(14.f)];
        rectangleTagLabel.textColor = [UIColor colorWithHexString:@"#31B3EF"];
        rectangleTagLabel.layer.borderWidth = 1;
        rectangleTagLabel.layer.borderColor = [UIColor colorWithHexString:@"#31B3EF"].CGColor;
        rectangleTagLabel.layer.cornerRadius = 3;
        [rectangleTagLabel.layer setMasksToBounds:YES];
        rectangleTagLabel.text = self.tagsArray[i];
        rectangleTagLabel.textAlignment = NSTextAlignmentCenter;
        [rectangleTagLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagDidCLick:)]];
        
        CGFloat labelWidth = [self getWidthWithTitle:self.tagsArray[i] font:[UIFont systemFontOfSize:KFloat(14.f)]];
        
        rectangleTagLabel.frame = CGRectMake(allLabelWidth, allLabelHeight + 31/2.0 * KWidth_ScaleH, labelWidth, 25);
        [self.tagsView addSubview:rectangleTagLabel];
        
        allLabelWidth = allLabelWidth+10+labelWidth;
    }
    
    self.tagsView.mj_h = rowHeight*40+40;
    self.headerView.mj_h = self.tagsView.mj_y+self.tagsView.mj_h+10;
}

- (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 0)];
    label.text = title;
    label.font = font;
    [label sizeToFit];
    return label.frame.size.width+10;
}

- (void)setSearchHistoriesCachePath:(NSString *)searchHistoriesCachePath
{
    _searchHistoriesCachePath = [searchHistoriesCachePath copy];
    // 刷新
    self.searchHistories = nil;
    
    [self.tableView reloadData];
}

/** 进入搜索状态调用此方法 */
- (void)saveSearchCacheAndRefreshView
{
    UISearchBar *searchBar = self.searchBar;
    // 回收键盘
    [searchBar resignFirstResponder];
    // 先移除再刷新
    [self.searchHistories removeObject:searchBar.text];
    [self.searchHistories insertObject:searchBar.text atIndex:0];
    
    // 移除多余的缓存
    if (self.searchHistories.count > self.searchHistoriesCount) {
        // 移除最后一条缓存
        [self.searchHistories removeLastObject];
    }
    // 保存搜索信息
    [NSKeyedArchiver archiveRootObject:self.searchHistories toFile:self.searchHistoriesCachePath];
    
    [self.tableView reloadData];
}

#pragma mark -- 懒加载
- (NSMutableArray *)searchHistories
{
    if (!_searchHistories) {
        self.searchHistoriesCachePath = PYSEARCH_SEARCH_HISTORY_CACHE_PATH;
        _searchHistories = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithFile:self.searchHistoriesCachePath]];
    }
    return _searchHistories;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    self.tableView.tableFooterView.hidden = self.searchHistories.count == 0;
    return self.searchHistories.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // 添加关闭按钮
    UIButton *closetButton = [[UIButton alloc] init];
    // 设置图片容器大小、图片原图居中
    closetButton.mj_size = CGSizeMake(cell.mj_h, cell.mj_h);
    [closetButton setTitle:@"x" forState:UIControlStateNormal];
    [closetButton addTarget:self action:@selector(closeDidClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.accessoryView = closetButton;
    [closetButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    cell.textLabel.textColor = [UIColor grayColor];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.text = self.searchHistories[indexPath.row];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (self.searchHistories.count != 0) {
        
        return @"历史记录";
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth-10, 80/2.0 * KWidth_ScaleH)];
    view.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:view.frame];
    titleLabel.text = @"历史记录";
    titleLabel.font = [UIFont systemFontOfSize:KFloat(16.f)];
    [titleLabel sizeToFit];
    [view addSubview:titleLabel];
    titleLabel.centerY = view.centerY;
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 80/2.0 * KWidth_ScaleH;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 取出选中的cell
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.searchBar.text = cell.textLabel.text;
    
    // 缓存数据并且刷新界面
    [self saveSearchCacheAndRefreshView];
    
    [self searchBarSearchButtonClicked:self.searchBar];
    
    self.searchSuggestionVC.view.hidden = NO;
    self.tableView.hidden = YES;
    [self.view bringSubviewToFront:self.searchSuggestionVC.view];
    
    //发送消息
    [[NSNotificationCenter defaultCenter] postNotificationName:@"searchBarDidChange" object:nil userInfo:@{@"searchText":cell.textLabel.text}];
}

#pragma mark -- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 滚动时，回收键盘
    [self.searchBar resignFirstResponder];
}

#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if ([searchText isEqualToString:@""]) {
        self.searchSuggestionVC.view.hidden = YES;
        self.tableView.hidden = NO;
    }
    else
    {
        self.searchSuggestionVC.view.hidden = NO;
        self.tableView.hidden = YES;
        [self.view bringSubviewToFront:self.searchSuggestionVC.view];
        
        //发送消息
        [[NSNotificationCenter defaultCenter] postNotificationName:@"searchBarDidChange" object:nil userInfo:@{@"searchText":searchText}];
    }
}


#pragma mark -- 手势
/** 选中标签 */
- (void)tagDidCLick:(UITapGestureRecognizer *)gr
{
    UILabel *label = (UILabel *)gr.view;
    self.searchBar.text = label.text;
    
    // 缓存数据并且刷新界面
    [self saveSearchCacheAndRefreshView];
    
    self.tableView.tableFooterView.hidden = NO;
    
    self.searchSuggestionVC.view.hidden = NO;
    self.tableView.hidden = YES;
    [self.view bringSubviewToFront:self.searchSuggestionVC.view];
    
    //发送消息
    [[NSNotificationCenter defaultCenter] postNotificationName:@"searchBarDidChange" object:nil userInfo:@{@"searchText":label.text}];
}


#pragma mark -- 按钮事件
- (void)cancelDidClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)closeDidClick:(UIButton *)sender
{
    // 获取当前cell
    UITableViewCell *cell = (UITableViewCell *)sender.superview;
    // 移除搜索信息
    [self.searchHistories removeObject:cell.textLabel.text];
    // 保存搜索信息
    [NSKeyedArchiver archiveRootObject:self.searchHistories toFile:PYSEARCH_SEARCH_HISTORY_CACHE_PATH];
    if (self.searchHistories.count == 0) {
        self.tableView.tableFooterView.hidden = YES;
    }
    
    // 刷新
    [self.tableView reloadData];
}

/** 点击清空历史按钮 */
- (void)emptySearchHistoryDidClick
{
    
    self.tableView.tableFooterView.hidden = YES;
    // 移除所有历史搜索
    [self.searchHistories removeAllObjects];
    // 移除数据缓存
    [NSKeyedArchiver archiveRootObject:self.searchHistories toFile:self.searchHistoriesCachePath];
    
    [self.tableView reloadData];
    
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

