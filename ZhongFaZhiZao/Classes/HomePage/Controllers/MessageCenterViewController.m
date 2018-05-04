//
//  MessageCenterViewController.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/3/2.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "MessageCenterViewController.h"
#import "MessageCenterCell.h"

@interface MessageCenterViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    UIImageView *_noImgeView;
    UILabel *_noLabel;
}
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation MessageCenterViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navBarView removeFromSuperview];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    //    刷新数据库信息
    //    NSString *path = [NSString stringWithFormat:@"%@/Documents/data.db",NSHomeDirectory()];
    //    FMDatabase *database = [FMDatabase databaseWithPath:path];
    //    [database open];
    //
    //    [database executeUpdate:@"update push_data"];
    
    //    查找并赋值
    //    按日期排序 order by date desc
    //    _dataArr = [[NSMutableArray alloc]init];
    _dataArr = [ZhongFaDataBase getPushMessage];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 初始化
    [self creatWebView];
    
    // 初始化导航栏
    [self setupNavigationBar];
}

#pragma mark -初始化子视图
- (void)creatWebView{
    
    self.view.backgroundColor = [UIColor whiteColor];
    _noImgeView = [[UIImageView alloc]init];
    _noLabel = [[UILabel alloc]init];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(12*KWidth_ScaleW, SafeAreaTopHeight, kScreenWidth-12*KWidth_ScaleW*2, kScreenHeight-SafeAreaTopHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:_tableView];
    
    if (self.dataArr.count == 0) {
        
        _noImgeView.frame = CGRectMake((kScreenWidth-258)/2.0, 122, 258, 171);
        _noImgeView.image = [UIImage imageNamed:@"InfoTravelsInSpaceIcon"];
        [self.view addSubview:_noImgeView];
        
        _noLabel.frame = CGRectMake((kScreenWidth-258)/2.0, 18+122+171, 258, 14);
        _noLabel.text = @"消息游走于太空";
        _noLabel.font = [UIFont systemFontOfSize:12.0];
        _noLabel.textColor = TEXT_GREY_COLOR;
        _noLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_noLabel];
        
    }else{
        
        _noImgeView.frame = CGRectZero;
        _noLabel.frame = CGRectZero;
    }
}

#pragma mark -初始化导航栏

- (void)setupNavigationBar {
    
    NavigationControllerView *navView = [[NavigationControllerView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, SafeAreaTopHeight) andLeftBtn:@"消息中心"];
    navView.viewController = self;
    [self.view addSubview:navView];
}

#pragma mark - datasource
//有多少个分组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    //    return 6;
    return self.dataArr.count;
}

//每一个分组cell的个数，分组中某一行的cell叫做row
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //按分类查询设备
    static NSString *cellID = @"CellID";
    MessageCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[MessageCenterCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //        cell.userInteractionEnabled = NO;
    
    //    if (self.dataArr[indexPath.section]) {
    
    cell.titleLabel.text = [NSString stringWithFormat:@"%@",self.dataArr[indexPath.section][@"title"]];
    [cell.mainImgView sd_setImageWithURL:[NSURL URLWithString:self.dataArr[indexPath.section][@"imgurl"]] placeholderImage:[UIImage imageNamed:@"InfoPlaceholderIcon"]];
    cell.sumLabel.text = [NSString stringWithFormat:@"%@",self.dataArr[indexPath.section][@"summury"]];
    //    }
    return cell;
}

#pragma mark - delegate
//返回cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 240;
}

//返回页头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 55;
}

//自定义区头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc]init];
    view.frame = CGRectMake(0 , 0, kScreenWidth, 55);
    view.backgroundColor = BACK_COLOR;
    
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-98)/2.0, (55-27)/2.0, 98, 27)];
    timeLabel.text = @"2016年11月23日";
    if (self.dataArr[section]) {
        
        timeLabel.text = [NSString stringWithFormat:@"%@",self.dataArr[section][@"date"]];
    }
    //
    timeLabel.backgroundColor = [UIColor colorWithHexString:@"#9b9b9b"];
    timeLabel.alpha = 0.4;
    timeLabel.font = [UIFont systemFontOfSize:11.0];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.textColor = [UIColor whiteColor];
    timeLabel.layer.masksToBounds = YES;
    timeLabel.layer.cornerRadius = 4;
    [view addSubview:timeLabel];
    return view;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0;
}


//cell点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    AskDetailsViewController *vc = [[AskDetailsViewController alloc]init];
    //    vc.detailUrl = @"http://www.baidu.com";
    //
    //
    //    [self.navigationController pushViewController:vc animated:YES];
    
    WKWebViewViewController *wkvc = [[WKWebViewViewController alloc]initWithUrlStr:[NSString stringWithFormat:@"%@",self.dataArr[indexPath.section][@"url"]] title:@"消息中心"];
    //    WKWebViewViewController *wkvc = [[WKWebViewViewController alloc]initWithUrlStr:@"http://www.baidu.com" title:@"消息中心"];
    [self.navigationController pushViewController:wkvc animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == _tableView) {
        CGFloat sectionHeaderHeight = 55;
        if (scrollView.contentOffset.y<=sectionHeaderHeight && scrollView.contentOffset.y>0) {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        }
        else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
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
