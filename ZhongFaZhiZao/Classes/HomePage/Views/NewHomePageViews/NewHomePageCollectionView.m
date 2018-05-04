//
//  NewHomePageCollectionView.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/8.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "NewHomePageCollectionView.h"
#import "ScienceResultGoodsCell.h"
#import "ScienceResultFunctionCell.h"
#import "SolveCell.h"
#import "ElectronicCollectionViewCell.h"
#import "NewHomePageCollectionSectionHeaderView.h"
#import "SolveView.h"
#import "SamrtShoppingMallView.h"
#import "SamrtShoppingMallCell.h"


@interface NewHomePageCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>{
    
    UICollectionViewFlowLayout *_flowLayout;
    UIButton *_fifButton;
    UIScrollView *_solveScrollView;
    UIScrollView *_smartMallScrollView;
}
@property (nonatomic,assign) NSInteger cityNumber;
@property (nonatomic,strong) UIButton *tmpbtn;
//
@property (nonatomic,strong) NewHomePageCollectionSectionHeaderView *collectionHeaderView;
@end
@implementation NewHomePageCollectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    UICollectionViewFlowLayout *theFlowLayout= [[UICollectionViewFlowLayout alloc] init];
    //设置滚动方向
    theFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //设置headerView尺寸大小
    theFlowLayout.headerReferenceSize = CGSizeMake(kScreenWidth, (413 + 18.1 + 501 + 352 + 39)/2.0 * KWidth_ScaleH);
    
    //    _flowLayout.itemSize
    
    //    _flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self = [super initWithFrame:frame collectionViewLayout:theFlowLayout];
    if (self) {
        _flowLayout = theFlowLayout;
        self.dataSource = self;
        self.delegate = self;
        self.backgroundColor = BACK_COLOR;
        
        //    下拉刷新、上拉加载
        //    _collectionView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //        //Call this Block When enter the refresh status automatically
        //
        //        self.pageIndex = 1;
        //        [self loadData];
        //
        //        [_collectionView.header endRefreshing];
        //
        //    }];
        //
        //    _collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //        //Call this Block When enter the refresh status automatically
        //
        //        self.pageIndex++;
        //        [self loadData];
        //
        //        [_collectionView.footer endRefreshing];
        //
        //    }];
        CGFloat headerViewHeight = (413 + 18.1 + 501 + 352 + 39 + 80 + 76)/2.0 * KWidth_ScaleH;
        self.headerView = [[NewHomePageHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, headerViewHeight)];
        self.headerView.backgroundColor = BACK_COLOR;
        
        //注册cell
        [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        [self registerClass:[SamrtShoppingMallCell class] forCellWithReuseIdentifier:@"samrtShoppingMallCell"];
        [self registerClass:[ScienceResultGoodsCell class] forCellWithReuseIdentifier:@"scienceResultGoodsCell"];
        [self registerClass:[ScienceResultFunctionCell class] forCellWithReuseIdentifier:@"scienceResultFunctionCell"];
        [self registerClass:[SolveCell class] forCellWithReuseIdentifier:@"solveCell"];
        [self registerClass:[ElectronicCollectionViewCell class] forCellWithReuseIdentifier:@"eletronicCell"];
        
        [_flowLayout setHeaderReferenceSize:CGSizeMake(kScreenWidth, _headerView.frame.size.height)];
        
        //注册header
        
        [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
        
        [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView1"];
        
        [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView2"];
        
        //注册通知
        //监听点击智造商城头视图的按钮状态
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(smartMallChangeTabItem:) name:@"changeTabItemRefreshData" object:nil];
        
    }
    return self;
}

#pragma mark -- 数据
- (void)setModel:(HomePageHeaderModel *)model{
    
    if (_model != model) {
        _model = model;
        self.headerView.model = _model;
    }
}

- (void)setSmartHeadlineNewsResultArr:(NSArray *)smartHeadlineNewsResultArr{
    if (_smartHeadlineNewsResultArr != smartHeadlineNewsResultArr) {
        _smartHeadlineNewsResultArr = smartHeadlineNewsResultArr;
        self.headerView.smartHeadlineNewsResultArr = smartHeadlineNewsResultArr;
    }
}

- (void)setRecommendArr:(NSArray *)recommendArr{
    if (_recommendArr != recommendArr) {
        _recommendArr = recommendArr;
        self.headerView.recommendArr = _recommendArr;
    }
}

- (void)setSmartShoppingMallArr:(NSArray *)smartShoppingMallArr{
    if (_smartShoppingMallArr != smartShoppingMallArr) {
        _smartShoppingMallArr = smartShoppingMallArr;
        self.headerView.smartShoppingMallArr = _smartShoppingMallArr;
    }
}

//collectionHeaderView
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath;
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader &&indexPath.section == 0)
    {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        
        [headerView addSubview:self.headerView];
        self.headerView.cityArray = self.cityArray;
        reusableview = headerView;
        
        return reusableview;
    }
    
    else if (kind == UICollectionElementKindSectionHeader &&indexPath.section == 3 ) {
        
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
        
    }
    
    NSArray *collecHeaderArr = @[@"ScienceResult",@"Solve",@"Electronic"];
    CGFloat collectionHeaderViewHeight = 80/2.0 * KWidth_ScaleH;
    self.collectionHeaderView = [[NewHomePageCollectionSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, collectionHeaderViewHeight)];
    self.collectionHeaderView.sectionType = collecHeaderArr[indexPath.section-1];
    self.collectionHeaderView.userInteractionEnabled = YES;
    self.collectionHeaderView.tag = 2000+indexPath.section;
    [self.collectionHeaderView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sectionHeaderClick:)]];
    
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView1" forIndexPath:indexPath];
    
    [headerView addSubview: self.collectionHeaderView];
    
    reusableview = headerView;
    
    return reusableview;
}



#pragma mark - UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        if (self.smartShoppingMallArr.count > 0) {
            return 1;
        }
        return 0;
    }else if (section == 1){
        if (self.scienceResultArr.count > 0) {
            return 7;
        }
        return 0;
    }else if (section == 2){
        if (self.solveArr.count > 0) {
            return 1;
        }
        return 0;
    }else if (section == 3){
        return _cityArray.count;
    }
    return 0;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 4;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        //智造商城
        static NSString * CellIdentifier = @"samrtShoppingMallCell";
        SamrtShoppingMallCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        _smartMallScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 342/2.0 * KWidth_ScaleH)];
        _smartMallScrollView.pagingEnabled = NO;
        _smartMallScrollView.bounces = NO;
        _smartMallScrollView.scrollEnabled = NO;
        _smartMallScrollView.userInteractionEnabled = YES;
        //    _scrollView.showsHorizontalScrollIndicator = NO;
        _smartMallScrollView.backgroundColor = BACK_COLOR;
        _smartMallScrollView.contentSize = CGSizeMake(4 * kScreenWidth, 0);
        [cell addSubview:_smartMallScrollView];
//        NSArray *titleArr = @[@"智能制造装备",@"工业软件",@"工业机器人",@"电子元器件",@"工业软件",@"工业机器人",@"电子元器件"];
        NSInteger tempCount = self.smartShoppingMallArr.count;
        for (int i = 0; i < tempCount; i++) {
             SamrtShoppingMallView *samrtShoppingMallView = [[SamrtShoppingMallView alloc] initWithFrame:CGRectMake(i * kScreenWidth, 0, kScreenWidth, 342/2.0 * KWidth_ScaleH)];
            samrtShoppingMallView.theDatas = self.smartShoppingMallArr[i];
            [_smartMallScrollView addSubview:samrtShoppingMallView];
        }
        // 让系统调用layoutSubView方法
        [cell setNeedsLayout];
        return cell;
    }else if (indexPath.section == 1 && indexPath.row < 2){
        if (self.scienceResultArr.count > 0) {
            //科技成果
            static NSString * CellIdentifier = @"scienceResultGoodsCell";
            ScienceResultGoodsCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
            cell.datas = self.scienceResultArr[indexPath.row];
            // 让系统调用layoutSubView方法
            [cell setNeedsLayout];
            return cell;
        }
        
    }else if (indexPath.section == 1 && indexPath.row >= 2){
        //科技成果
        NSArray *titles = @[@"评估评价",@"专利申请",@"商标注册",@"项目申报",@"高新认定"];
        NSArray *imageNames = @[@"NewHomePageEnvaluationIcon",@"NewHomePageApplyIcon",@"NewHomePageTrademarkRegistrationIcon",@"NewHomePageProjectApplicationIcon",@"NewHomePageHighRecognitionIcon"];
        static NSString *knowCellIdent = @"scienceResultFunctionCell";
        ScienceResultFunctionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:knowCellIdent forIndexPath:indexPath];
        cell.title = titles[indexPath.row - 2];
        cell.titleImage = imageNames[indexPath.row - 2];
        // 让系统调用layoutSubView方法
        [cell setNeedsLayout];
        return cell;
    }else if (indexPath.section == 2){
        //解决方案
        static NSString * CellIdentifier = @"solveCell";
        SolveCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        
        _solveScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 396/2.0 * KWidth_ScaleH)];
        _solveScrollView.pagingEnabled = NO;
        _solveScrollView.bounces = NO;
        _solveScrollView.userInteractionEnabled = YES;
        //    _scrollView.showsHorizontalScrollIndicator = NO;
        _solveScrollView.backgroundColor = BACK_COLOR;
        _solveScrollView.contentSize = CGSizeMake(32/2.0 * KWidth_ScaleW * 2 + 21/2.0 * KWidth_ScaleW + 2 * (569/2.0 * KWidth_ScaleW), 0);
        [cell addSubview:_solveScrollView];
        for (int i = 0; i < self.solveArr.count; i++) {
            
            SolveView *solveView = [[SolveView alloc] initWithFrame:CGRectMake(32/2.0 * KWidth_ScaleW + i * ((569 + 21)/2.0 * KWidth_ScaleW), 0, 569/2.0 * KWidth_ScaleW, 396/2.0 * KWidth_ScaleH)];
            solveView.solveDatas = self.solveArr[i];
            [_solveScrollView addSubview:solveView];
        }
        // 让系统调用layoutSubView方法
        [cell setNeedsLayout];
        return cell;
    }else if (indexPath.section == 3){
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
    cell.backgroundColor = [UIColor whiteColor];
    // 让系统调用layoutSubView方法
    [cell setNeedsLayout];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return CGSizeMake(kScreenWidth, 342/2.0 * KWidth_ScaleH);
    }else if (indexPath.section == 1){
        
        if (indexPath.row < 2){
            
            return CGSizeMake(kScreenWidth, (200/2.0 - 1)* KWidth_ScaleH);
        }
        return CGSizeMake((kScreenWidth - 4) / 5, 203/2.0 * KWidth_ScaleH);
    }else if (indexPath.section == 2){
        
        return CGSizeMake(kScreenWidth, 396/2.0 * KWidth_ScaleH);
    }else if (indexPath.section == 3){
        
        return CGSizeMake(kScreenWidth, 141*KWidth_ScaleH);
    }
    return CGSizeZero;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 0) {
        
        //      return UIEdgeInsetsMake(margins, margins, margins, margins);
        return UIEdgeInsetsMake(0, 0, 22/2.0 * KWidth_ScaleH, 0);
    }else if (section == 1){
        
        return UIEdgeInsetsMake(0, 0, 30/2.0 * KWidth_ScaleH, 0);
    }else if (section == 2){
        
        return UIEdgeInsetsMake(0, 0, 31/2.0 * KWidth_ScaleH, 0);
    }else if (section == 3){
        
        return UIEdgeInsetsMake(0, 0, 30/2.0 * KWidth_ScaleH, 0);
    }
    return UIEdgeInsetsZero;
    //     UIEdgeInsets insets = {top, left, bottom, right};
}

#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0){
        
        if (indexPath.row == 0) {
            
        }else if (indexPath.row == 1){
            
        }else if (indexPath.row == 2){
            
        }else if (indexPath.row == 3){
            
        }
    }else if (indexPath.section == 1){
        NewHomePageScienceResultDatas *datas = self.scienceResultArr[indexPath.row];
        
        if (indexPath.row == 0) {
            NSLog(@"科技成果商品1");
            NSString *url = [NSString stringWithFormat:@"http://wap.cecb2b.com/corp/nicInfo/%@?corpId=123",datas.scienceResultId];
            
            [self pushToWKWebViewCtrlUrl:url withTitle:@"商品详情"];
        }else if (indexPath.row == 1){
            NSLog(@"科技成果商品2");
            NSString *url = [NSString stringWithFormat:@"http://wap.cecb2b.com/corp/nicInfo/%@?corpId=123",datas.scienceResultId];
            [self pushToWKWebViewCtrlUrl:url withTitle:@"商品详情"];
        }else if (indexPath.row >= 2){
            
            NSLog(@"科技成果功能按钮");
        }
    }else if (indexPath.section == 2){
        
        if (indexPath.row == 0) {
            
            
        }else{
            
           
        }
    }else if (indexPath.section == 3){
        
        [self pushToWKWebViewCtrlUrl:[NSString stringWithFormat:@"%@",_cityArray[indexPath.row][@"url"]] withTitle:@"商品详情页"];
    }
}


-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//设置页头高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        CGFloat headerViewHeight = (413 + 18.1 + 501 + 352 + 39 + 80 + 76)/2.0 * KWidth_ScaleH;
        return CGSizeMake(kScreenWidth, headerViewHeight);
    }else if (section == 3){
        
        return CGSizeMake(kScreenWidth, 80/2.0 * KWidth_ScaleH+53);
    }
    return CGSizeMake(kScreenWidth, 80/2.0 * KWidth_ScaleH);
}

//设置页尾高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    return CGSizeMake(0, 0);
}


//设置每个item水平间距
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 10;
//}

//cell的最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}


//ayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 0.0f;
//}


//cell的最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1.0f;
    
}

#pragma mark -- UIScrollViewDelegate
// 手指离开滑动视图的时候调用的协议方法
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    // decelerate:  时候有减速效果
    NSLog(@"手指离开滑动视图，当前减速效果:%d",decelerate);
    if (decelerate == NO) {
        // 视图停止滑动的时候执行一些操作
        [self scrollDidSroll];
    }
}

// 减速结束
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"停止减速，滑动视图停止了");
    
    // 视图停止滑动的时候执行一些操作
    [self scrollDidSroll];
}

// 当前滑动视图停止滑动的时候执行一些操作
- (void)scrollDidSroll
{
    NSLog(@"滑动视图停止滑动的时候执行一些操作");
    
    // 获取_smartMallScrollView视图index
//    int Index = (int)_smartMallScrollView.contentOffset.x / kScreenWidth;
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"smartMallScrollIndex" object:@(Index)];
}

#pragma mark -- 按钮事件
- (void)fifBtnClick:(UIButton *)button{
    
    self.cityNumber = (NSInteger)button.tag-3000;
    
    //    [self loadCityData];
    
    for(int i = 0 ; i < 4 ;i ++) {
        
        UIButton *btn = (UIButton *)[self viewWithTag:i + 3000];
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

- (void)sectionHeaderClick:(UITapGestureRecognizer *)tap{
    
    if (tap.view.tag == 2000) {
        NSLog(@"智造商城手势");
    }else if (tap.view.tag == 2001){
        NSLog(@"科技成果手势");
        [self pushToWKWebViewCtrlUrl:[NSString stringWithFormat:@"%@%@",BaseApi,HomePageScienceList_API] withTitle:@"科技成果"];
    }else if (tap.view.tag == 2002){
        NSLog(@"解决方案手势");
        [self pushToWKWebViewCtrlUrl:[NSString stringWithFormat:@"%@%@",BaseApi,HomePageSolutionList_API] withTitle:@"解决方案"];
    }else if (tap.view.tag == 2003){
        NSLog(@"电子市场手势");
    }
}

#pragma mark -- 通知
- (void)smartMallChangeTabItem:(NSNotification *)notify{
    
    id ChangeTabItemIndex = notify.object;
    if ([ChangeTabItemIndex isKindOfClass:[NSNumber class]]) {
        NSInteger index = [ChangeTabItemIndex integerValue];
        CGPoint point = CGPointMake(kScreenWidth * index, 0);
        [_smartMallScrollView setContentOffset:point animated:YES];
    }
}
#pragma mark -- method
- (void)pushToWKWebViewCtrlUrl:(NSString *)urlStr withTitle:(NSString *)title{
    
    WKWebViewViewController *vc = [[WKWebViewViewController alloc]initWithUrlStr:urlStr title:title];
    [self.viewControler.navigationController pushViewController:vc animated:YES];
}

#pragma mark - scrollView滑动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    float y = scrollView.contentOffset.y;
    if(y<70){
        self.navBarView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"HomePageNavBar"]];
        
        self.navigationView.alpha = 1;
    }
    else{
        self.navigationView.backgroundColor = BLUE_COLOR;
        
        [UIView animateWithDuration:0.1 animations:^{
            
            CGFloat alphas = (scrollView.contentOffset.y / 135 < 1)?scrollView.contentOffset.y/135:1;
            
            self.navigationView.backgroundColor = BLUE_COLOR;
            
            self.navigationView.alpha = alphas;
        } completion:^(BOOL finished) {
        }];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
