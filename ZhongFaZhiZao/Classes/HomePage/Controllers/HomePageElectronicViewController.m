//
//  HomePageElectronicViewController.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/18.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "HomePageElectronicViewController.h"
#import "ElectronicCollectionViewCell.h"
#import "NewHomePageCollectionSectionHeaderView.h"

@interface HomePageElectronicViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    UIButton *_fifButton;

}
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,assign) NSInteger cityNumber;
@property (nonatomic,strong) UIButton *tmpbtn;

@end

@implementation HomePageElectronicViewController

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
    
    UICollectionViewFlowLayout *theFlowLayout= [[UICollectionViewFlowLayout alloc] init];
    //设置滚动方向
    theFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake( 0, SafeAreaTopHeight, kScreenWidth, kScreenHeight - SafeAreaTopHeight - SafeAreaBottomHeight) collectionViewLayout:theFlowLayout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = BACK_COLOR;
    
    
    //注册cell
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];

    [_collectionView registerClass:[ElectronicCollectionViewCell class] forCellWithReuseIdentifier:@"eletronicCell"];
    
    //注册header
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView2"];
    
    [self.view addSubview:_collectionView];
}

#pragma mark -初始化导航栏
- (void)setupNavigationBar {
    
    NavigationControllerView *navView = [[NavigationControllerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, SafeAreaTopHeight) andLeftBtn:@"电子市场"];
    navView.viewController = self;
    [self.view addSubview:navView];
}


//collectionHeaderView
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath;
{
    UICollectionReusableView *reusableview = nil;
        
    UIView *fifView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 80/2.0 * KWidth_ScaleH+53)];
    fifView.backgroundColor = BACK_COLOR;
    fifView.userInteractionEnabled = YES;
        
    NewHomePageCollectionSectionHeaderView *sectionHeaderView = [[NewHomePageCollectionSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 80/2.0 * KWidth_ScaleH)];
    sectionHeaderView.sectionType = @"Electronic";
    [fifView addSubview:sectionHeaderView];
    CGFloat fifBtnX = (kScreenWidth-78*4)/5.0;
    NSArray *fifArr = @[@"全部",@"北京",@"西安",@"深圳"];
    for (NSInteger i = 0; i < 4; i++) {
            
        _fifButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _fifButton.frame = CGRectMake(78*i+(i+1)*fifBtnX, (53-25)/2.0+CGRectGetMaxY(sectionHeaderView.frame), 78, 25);
        [_fifButton setTitle:fifArr[i] forState:UIControlStateNormal];
        [_fifButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_fifButton setTitleColor:TEXT_GREY_COLOR forState:UIControlStateNormal];
        _fifButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
        _fifButton.layer.masksToBounds = YES;
        _fifButton.layer.cornerRadius = 12;
        _fifButton.tag = 3000+i;
        [_fifButton addTarget:self action:@selector(fifBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [fifView addSubview:_fifButton];
            
        if (i == self.cityNumber ) {
                
            _fifButton.backgroundColor = BLUE_COLOR;
            self.tmpbtn = _fifButton;
            _fifButton.selected = YES;
            _fifButton.layer.borderWidth = 0;
                
        }else{
                
            _fifButton.backgroundColor = [UIColor whiteColor];
            _fifButton.layer.borderWidth = 1;
            _fifButton.layer.borderColor = TEXT_LINE_COLOR.CGColor;
        }
            
    }
        
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView2" forIndexPath:indexPath];
        
        [headerView addSubview: fifView];
        
        reusableview = headerView;
        
        return reusableview;
        
    return reusableview;
}



#pragma mark - UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return _cityArray.count;
    }
    return 0;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0){
        //电子市场
        static NSString * CellIdentifier = @"eletronicCell";
        ElectronicCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        cell.dataDic = _cityArray[indexPath.row];
        // 让系统调用layoutSubView方法
        [cell setNeedsLayout];
        return cell;
    }
    
    static NSString * CellIdentifier = @"cell";
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    // 让系统调用layoutSubView方法
    [cell setNeedsLayout];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0){
        
        return CGSizeMake(kScreenWidth, 141*KWidth_ScaleH);
    }
    return CGSizeZero;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 0){
        
        return UIEdgeInsetsMake(0, 0, 30/2.0 * KWidth_ScaleH, 0);
    }
    return UIEdgeInsetsZero;
    //     UIEdgeInsets insets = {top, left, bottom, right};
}

#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0){
        
        [self pushToWKWebViewCtrlUrl:[NSString stringWithFormat:@"%@",_cityArray[indexPath.row][@"url"]] withTitle:@"商品详情页"];
    }
}


-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//设置页头高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    if (section == 0){
        
        return CGSizeMake(kScreenWidth, 80/2.0 * KWidth_ScaleH+53);
    }
    return CGSizeMake(kScreenWidth, 80/2.0 * KWidth_ScaleH);
}

//设置页尾高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    return CGSizeMake(0, 0);
}

//cell的最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}

//cell的最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1.0f;
}


#pragma mark -- method
- (void)pushToWKWebViewCtrlUrl:(NSString *)urlStr withTitle:(NSString *)title{
    
    WKWebViewViewController *vc = [[WKWebViewViewController alloc]initWithUrlStr:urlStr title:title];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -- 按钮事件
- (void)fifBtnClick:(UIButton *)button{
    
    self.cityNumber = (NSInteger)button.tag-3000;
    
    //    [self loadCityData];
    
    for(int i = 0 ; i < 4 ;i ++) {
        
        UIButton *btn = (UIButton *)[_collectionView viewWithTag:i + 3000];
        if(button.tag == btn.tag) {
            
            [btn setBackgroundColor:BLUE_COLOR];
            btn.layer.borderWidth = 0;
            btn.selected = YES;
        }else {
            
            [btn setBackgroundColor:[UIColor whiteColor]];
            btn.layer.borderWidth = 1;
            btn.selected = NO;
        }
    }
    //    self.tmpbtn.selected  = NO;
    //    button.selected = YES;
    //    self.tmpbtn = button;
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
