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

@interface SSMSearchResultViewController ()
{
    UIView *_headerBJView;
}
@property (nonatomic, assign) BOOL isSelectedPriceBtn;
@end

@implementation SSMSearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleColorChange:) name:@"searchBarDidChange" object:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    if (self.searchResults.count > 0) {
       [self setUpUI];
    }
}

#pragma mark -初始化子视图
- (void)setUpUI{
    
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
    UIView *headerBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, priceBtn.bottom, kScreenWidth, 0.5)];
    [self.view addSubview:headerBottomView];
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.searchResults.count == 0) {
        return 1;
    }
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.searchResults.count == 0) {
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
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 0;
    if (self.searchResults.count == 0) {
        return kScreenHeight - SafeAreaTopHeight - SafeAreaBottomHeight;
    }else{
        height = 280/2.0 * KWidth_ScaleH;
    }
    return height;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.didSelectText([tableView cellForRowAtIndexPath:indexPath].textLabel.text);
    
    UIViewController *vc = [[UIViewController alloc] init];
    vc.title = @"结果搜索的控制器";
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


#pragma mrak -- 通知
-(void)handleColorChange:(NSNotification* )sender
{
    NSString *text = sender.userInfo[@"searchText"];
    
    NSLog(@"%@", text);
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
