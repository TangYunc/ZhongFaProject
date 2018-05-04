//
//  HomePageCollectionView.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/3/5.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "HomePageCollectionView.h"
#import "SupplyCollectionViewCell.h"
#import "ScienceCollectionViewCell.h"
#import "KnowLedgeCustomCollectionViewCell.h"
#import "IntelligenceCollectionViewCell.h"
#import "SolveCollectionViewCell.h"
#import "ElectronicCollectionViewCell.h"
#import "KnowLedgeCustomCollectionViewCell.h"
#import "SupplyScrollCollectionViewCell.h"
#import "FinanceCollectionViewCell.h"
#import "FinanceDetailOneViewController.h"
#import "FinanceDetailTwoViewController.h"
#import "CommitKnowledgeViewController.h"
#import "FinanceViewController.h"
#import "KnowLedgeViewController.h"

#define margins 8
@interface HomePageCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
    
    UICollectionViewFlowLayout *_flowLayout;
    UIButton *_fifButton;

}
@property (nonatomic,assign) NSInteger cityNumber;
@property (nonatomic,strong) UIButton *tmpbtn;

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIImageView *collectionHeaderView;
@end

@implementation HomePageCollectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    UICollectionViewFlowLayout *theFlowLayout= [[UICollectionViewFlowLayout alloc] init];
    //设置滚动方向
    theFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //设置headerView尺寸大小
    theFlowLayout.headerReferenceSize = CGSizeMake(kScreenWidth, 180*KWidth_ScaleW+8+40+164);
    
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
        
        self.headerView = [[HomePageHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 180*KWidth_ScaleH+8+40+164+80*KWidth_ScaleH+8)];
        self.headerView.backgroundColor = BACK_COLOR;
        //注册cell
        [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        [self registerClass:[SupplyScrollCollectionViewCell class] forCellWithReuseIdentifier:@"supplyScrcell"];
        [self registerClass:[SupplyCollectionViewCell class] forCellWithReuseIdentifier:@"supplycell"];
        [self registerClass:[KnowLedgeCustomCollectionViewCell class] forCellWithReuseIdentifier:@"knowcustomCell"];
        [self registerClass:[ScienceCollectionViewCell class] forCellWithReuseIdentifier:@"scienceCell"];
        [self registerClass:[IntelligenceCollectionViewCell class] forCellWithReuseIdentifier:@"intelligenceCell"];
        [self registerClass:[SolveCollectionViewCell class] forCellWithReuseIdentifier:@"solveCell"];
        [self registerClass:[ElectronicCollectionViewCell class] forCellWithReuseIdentifier:@"eletronicCell"];
        [self registerClass:[FinanceCollectionViewCell class] forCellWithReuseIdentifier:@"financeCell"];
        
        [_flowLayout setHeaderReferenceSize:CGSizeMake(kScreenWidth, _headerView.frame.size.height)];
        
        //注册header
        
        [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
        
        [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView1"];
        
        [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView2"];
        
    }
    return self;
}

- (void)setModel:(HomePageHeaderModel *)model{
    
    if (_model != model) {
        _model = model;
        self.headerView.model = _model;
    }
}
//collectionHeaderView
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath;
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader &&indexPath.section == 0)
    {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        
        
        [headerView addSubview: self.headerView];
        
        reusableview = headerView;
        
        return reusableview;
    }
    
    else if (kind == UICollectionElementKindSectionHeader &&indexPath.section == 6 ) {
        
        UIView *fifView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 80*KWidth_ScaleH+53)];
        fifView.backgroundColor = BACK_COLOR;
        fifView.userInteractionEnabled = YES;
        
        UIImageView *fifImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 80*KWidth_ScaleH)];
        fifImg.image = [UIImage imageNamed:@"HomePageElectronicMarketIcon"];
        fifImg.userInteractionEnabled = YES;
        [fifView addSubview:fifImg];
        
        CGFloat fifBtnX = (kScreenWidth-78*4)/5.0;
        
        NSArray *fifArr = @[@"全部",@"北京",@"西安",@"深圳"];
        
        for (NSInteger i = 0; i < 4; i++) {
            
            _fifButton = [UIButton buttonWithType:UIButtonTypeCustom];
            
            _fifButton.frame = CGRectMake(78*i+(i+1)*fifBtnX, (53-25)/2.0+CGRectGetMaxY(fifImg.frame), 78, 25);
            [_fifButton setTitle:fifArr[i] forState:UIControlStateNormal];
            [_fifButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            //           [fifButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            
            [_fifButton setTitleColor:TEXT_GREY_COLOR forState:UIControlStateNormal];
            
            //           fifButton setBackgroundImage:[UIImage imwithco] forState:<#(UIControlState)#>
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
    
    NSArray *collecHeaderArr = @[@"HomePageFinancialServicesBar",@"HomePageScienceAndTechnologyBar",@"HomePagePropertyRightsOfPatenticonBar",@"HomePageSmartInnovationBar",@"HomePageSolutionBar",@"HomePageElectronicMarketBar"];
    self.collectionHeaderView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 80*KWidth_ScaleH)];
    self.collectionHeaderView.image = [UIImage imageNamed:collecHeaderArr[indexPath.section-1]];
    self.collectionHeaderView.userInteractionEnabled = YES;
    //    self.collectionHeaderView.tag = 50000+indexPath.section;
    //    [self.collectionHeaderView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(buttonClick:)]];
    //    collectionView header 点击
    UIButton *collectHeaderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    collectHeaderBtn.frame = self.frame;
    collectHeaderBtn.tag = 2000+indexPath.section;
    [collectHeaderBtn addTarget:self action:@selector(mainButtonClick2:) forControlEvents:UIControlEventTouchUpInside];
    
    collectHeaderBtn.enabled = YES;
    collectHeaderBtn.hidden = NO;
    [self.collectionHeaderView addSubview:collectHeaderBtn];
    
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView1" forIndexPath:indexPath];
    
    [headerView addSubview: self.collectionHeaderView];
    
    reusableview = headerView;
    
    return reusableview;
}



#pragma mark - UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 3;
    }else if (section == 2){
        return 4;
    }else if (section == 3){
        return 8;
    }else if (section == 4){
        return 4;
    }else if (section == 5){
        return 3;
    }else if (section == 6){
        return _cityArray.count;
    }
    return 0;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 7;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 3 && indexPath.row < 6) {
        
        NSArray *knowCustomIcon = @[@"HomePageApplyIcon",@"HomePageAnalyzeIcon",@"HomePageExcavateIcon",@"HomePageDatabaseIcon",@"HomePageWarningIcon",@"HomePageDealIcon"];
        NSArray *konwCustomLabel = @[@"专利申请",@"专利分析",@"专利挖掘",@"数据库定制",@"专利预警",@"专利交易"];
        
        static NSString *knowCellIdent = @"knowcustomCell";
        
        KnowLedgeCustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:knowCellIdent forIndexPath:indexPath];
        
        cell.text = konwCustomLabel[indexPath.row];
        cell.imageName = knowCustomIcon[indexPath.row];
        // 让系统调用layoutSubView方法
        [cell setNeedsLayout];
        return cell;
    }else if (indexPath.section == 2){
        
        NSArray *section1Arr = @[@"HomePageGroup42Icon",@"HomePageGroup43Icon",@"HomePageGroup47Icon",@"HomePageGroup46Icon"];
        
        static NSString * CellIdentifier = @"scienceCell";
        ScienceCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        cell.imageName = section1Arr[indexPath.row];
        // 让系统调用layoutSubView方法
        [cell setNeedsLayout];
        return cell;
    }else  if (indexPath.section == 4) {
        
        static NSString * CellIdentifier = @"intelligenceCell";
        IntelligenceCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        
        NSArray *section3Arr = @[@"HomePageIntelligence1Icon",@"HomePageIntelligence2Icon",@"HomePageIntelligence3Icon",@"HomePageIntelligence4Icon"];
        cell.imageName = section3Arr[indexPath.row];
        // 让系统调用layoutSubView方法
        [cell setNeedsLayout];
        return cell;
    }else if (indexPath.section == 3 && indexPath.row >= 6){
        
        static NSString * CellIdentifier = @"supplycell";
        SupplyCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        
        NSArray *section36Arr = @[@"HomePageGroup41Icon",@"HomePageGroup40Icon"];
        cell.imageName = section36Arr[indexPath.row-6];
        // 让系统调用layoutSubView方法
        [cell setNeedsLayout];
        return cell;
    }else if (indexPath.section == 0){
        
        NSArray *section1 = @[@"HomePageGroup55Icon",@"HomePageGroup54Icon",@"HomePageGroup2Icon",@"HomePageGroup4Icon",@"HomePageGroup5Icon"];
        
        static NSString * CellIdentifier = @"supplyScrcell";
        SupplyScrollCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 197*KWidth_ScaleH)];
        _scrollView.pagingEnabled = NO;
        _scrollView.bounces = NO;
        _scrollView.userInteractionEnabled = YES;
        //    _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.backgroundColor = BACK_COLOR;
        _scrollView.contentSize = CGSizeMake(8*6+5*(kScreenWidth-24)/2.0, 0);
        [cell addSubview:_scrollView];
        
        for (int i = 0; i < 5; i++) {
            
            UIImageView *imageViewS = [[UIImageView alloc]init];
            imageViewS.frame = CGRectMake(8*(i+1)+i*(kScreenWidth-24)/2.0, 0, (kScreenWidth-24)/2.0, 197*KWidth_ScaleH);
            imageViewS.image = [UIImage imageNamed:section1[i]];
            imageViewS.userInteractionEnabled = YES;
            [_scrollView addSubview:imageViewS];
            
            UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
            btn1.frame = CGRectMake(0, 6, CGRectGetWidth(imageViewS.frame), 30);
            btn1.tag = 10+i;
            //        btn1.backgroundColor = [UIColor redColor];
            [btn1 addTarget:section1 action:@selector(cellBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [imageViewS addSubview:btn1];
            
            UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
            btn2.frame = CGRectMake(0, 78, CGRectGetWidth(imageViewS.frame)/2.0,197*KWidth_ScaleH-78);
            btn2.tag = 20+i;
            //        btn2.backgroundColor = [UIColor redColor];
            [btn2 addTarget:section1 action:@selector(cellBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [imageViewS addSubview:btn2];
            
            UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
            btn3.frame = CGRectMake(CGRectGetWidth(imageViewS.frame)/2.0, 78, CGRectGetWidth(imageViewS.frame)/2.0, 197*KWidth_ScaleH-78);
            btn3.tag = 30+i;
            //        btn3.backgroundColor = [UIColor blueColor];
            [btn3 addTarget:section1 action:@selector(cellBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [imageViewS addSubview:btn3];
            
        }
        // 让系统调用layoutSubView方法
        [cell setNeedsLayout];
        return cell;
    }else if (indexPath.section == 5){
        
        static NSString * CellIdentifier = @"solveCell";
        SolveCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        
        NSArray *section4Arr = @[@"HomePageGroup51Icon",@"HomePageGroup52Icon",@"HomePageGroup50Icon"];
        cell.imageName = section4Arr[indexPath.row];
        // 让系统调用layoutSubView方法
        [cell setNeedsLayout];
        return cell;
    }else if (indexPath.section == 6){
        
        static NSString * CellIdentifier = @"eletronicCell";
        ElectronicCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        cell.dataDic = _cityArray[indexPath.row];
        // 让系统调用layoutSubView方法
        [cell setNeedsLayout];
        return cell;
    }else if (indexPath.section == 1){
        
        static NSString *CellIdentifier = @"financeCell";
        FinanceCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        
        NSArray *section4Arr = @[@"HomePagejrsumm1Icon",@"HomePagejrsumm2Icon",@"HomePagejrsumm3Icon"];
        cell.imageName = section4Arr[indexPath.row];
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
    if (indexPath.section == 0) {
        
        return CGSizeMake(kScreenWidth, 197*KWidth_ScaleH);
    }else if (indexPath.section == 1){
        
        return CGSizeMake(kScreenHeight, 89*KWidth_ScaleH);
    }else if (indexPath.section == 2){
        
        return CGSizeMake((kScreenWidth-1)/2.0, 175*KWidth_ScaleH);
    }else if (indexPath.section == 3){
        
        if (indexPath.row <= 5){
            
            return CGSizeMake((kScreenWidth-1)/2.0, 45*KWidth_ScaleH);
        }
        return CGSizeMake((kScreenWidth-1)/2.0, 72*KWidth_ScaleH);
    }else if (indexPath.section == 4){
        
        return CGSizeMake((kScreenWidth-1)/2.0, 187*KWidth_ScaleH);
    }else if (indexPath.section == 5){
        
        return CGSizeMake(kScreenWidth, 113*KWidth_ScaleH);
    }else if (indexPath.section == 6){
        
        return CGSizeMake(kScreenWidth, 141*KWidth_ScaleH);
    }
    return CGSizeZero;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 0) {
        
        //      return UIEdgeInsetsMake(margins, margins, margins, margins);
        return UIEdgeInsetsMake(margins, 0, margins, 0);
    }else if (section == 1){
        
        return UIEdgeInsetsMake(0, 0, margins, 0);
    }else if (section == 2){
        
        return UIEdgeInsetsMake(0, 0, margins, 0);
    }else if (section == 3){
        
        return UIEdgeInsetsMake(0, 0, margins, 0);
    }else if (section == 4){
        
        return UIEdgeInsetsMake(0, 0, margins, 0);
    }else if (section == 5){
        
        return UIEdgeInsetsMake(0, 0, margins, 0);
    }else if (section == 6){
        
        return UIEdgeInsetsMake(0, 0, margins, 0);
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
            
        }else if (indexPath.row == 4){
            
        }
    }else if (indexPath.section == 1){
        
        if (indexPath.row == 0) {
            
            FinanceDetailTwoViewController *vc = [[FinanceDetailTwoViewController alloc]init];
//            vc.fid = @"5644084";
            [self.viewControler.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 1){
            
            FinanceDetailOneViewController *vc = [[FinanceDetailOneViewController alloc]init];
//            vc.fid = @"5643684";
            [self.viewControler.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 2){
            
            FinanceDetailOneViewController *vc = [[FinanceDetailOneViewController alloc]init];
//            vc.fid = @"5537071";
            [self.viewControler.navigationController pushViewController:vc animated:YES];
        }
    }else if (indexPath.section == 2){
        
        if (indexPath.row == 0) {
            
            [self pushToWKWebViewCtrlUrl:@"http://wap.cecb2b.com/corp/nicInfo/5644790?corpId=" withTitle:@"商品详情页"];
        }else if (indexPath.row == 1){
            
             [self pushToWKWebViewCtrlUrl:@"http://wap.cecb2b.com/corp/nicInfo/5644784?corpId=123" withTitle:@"商品详情页"];
        }else if (indexPath.row == 2){
            
            [self pushToWKWebViewCtrlUrl:@"http://wap.cecb2b.com/corp/nicInfo/5644765?corpId=123" withTitle:@"商品详情页"];
        }else if (indexPath.row == 3){
            
            [self pushToWKWebViewCtrlUrl:@"http://wap.cecb2b.com/corp/nicInfo/5644788?corpId=123" withTitle:@"商品详情页"];
        }
    }else if (indexPath.section == 3 && indexPath.row <= 5) {
        
//        NSArray *typeID = @[@"80004010",@"80004070",@"80004020",@"80004090",@"80004060",@"80004080"];
        CommitKnowledgeViewController *vc = [[CommitKnowledgeViewController alloc]init];
//        vc.typeId = typeID[indexPath.row];
        [self.viewControler.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.section == 3 && indexPath.row >5){
        
        if (indexPath.row == 6) {
            
            [self pushToWKWebViewCtrlUrl:@"http://wap.cecb2b.com/corp/nicInfo/5644823?corpId=123" withTitle:@"商品详情页"];
        }else if (indexPath.row == 7){
            
            [self pushToWKWebViewCtrlUrl:@"http://wap.cecb2b.com/corp/nicInfo/5644825?corpId=123" withTitle:@"商品详情页"];
        }
    }else if (indexPath.section == 4){
        
        if (indexPath.row == 0) {
            
            [self pushToWKWebViewCtrlUrl:@"http://wap.cecb2b.com/corp/nicInfo/5644276?corpId=444820" withTitle:@"商品详情页"];
        }else if (indexPath.row == 1){
            
            [self pushToWKWebViewCtrlUrl:@"http://wap.cecb2b.com/corp/nicInfo/5644271?corpId=444820" withTitle:@"商品详情页"];
        }else if (indexPath.row == 2){
            
            [self pushToWKWebViewCtrlUrl:@"http://wap.cecb2b.com/corp/nicInfo/5644284?corpId=444820" withTitle:@"商品详情页"];
        }else if (indexPath.row == 3){
            
             [self pushToWKWebViewCtrlUrl:@"http://wap.cecb2b.com/corp/nicInfo/5644277?corpId=444820" withTitle:@"商品详情页"];
        }
    }else if (indexPath.section == 5){
        
        if (indexPath.row == 0) {
         
            [self pushToWKWebViewCtrlUrl:@"http://wap.cecb2b.com/corp/nicInfo/5534283?corpId=444064" withTitle:@"商品详情页"];
        }else if (indexPath.row == 1){
          
            [self pushToWKWebViewCtrlUrl:@"http://wap.cecb2b.com/corp/nicInfo/5534303?corpId=444078" withTitle:@"商品详情页"];
        }else if (indexPath.row == 2){
            
            [self pushToWKWebViewCtrlUrl:@"http://wap.cecb2b.com/corp/nicInfo/5534387?corpId=444166" withTitle:@"商品详情页"];
        }
    }else if (indexPath.section == 6){
        
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
        
        return CGSizeMake(kScreenWidth, 180*KWidth_ScaleH+8+40+164+80*KWidth_ScaleH+8);
    }else if (section == 6){
        
        return CGSizeMake(kScreenWidth, 80*KWidth_ScaleH+53);
    }
    return CGSizeMake(kScreenWidth, 80*KWidth_ScaleH);
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

//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}


//ayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 0.0f;
//}


//设置collectionView间距最小值
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1.0f;
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

- (void)mainButtonClick2:(UIButton *)button{
    
    if (button.tag == 2001) {
        
        FinanceViewController *vc = [[FinanceViewController alloc]init];
        [self.viewControler.navigationController pushViewController:vc animated:YES];
    }else if (button.tag == 2002){
        
         [self pushToWKWebViewCtrlUrl:[NSString stringWithFormat:@"%@%@",BaseApi,HomePageScienceList_API] withTitle:@"供应链采购"];
    }else if (button.tag == 2003){
        
        KnowLedgeViewController *vc = [[KnowLedgeViewController alloc]init];
        [self.viewControler.navigationController pushViewController:vc animated:YES];
        
    }else if (button.tag == 2004){
        
        [self pushToWKWebViewCtrlUrl:[NSString stringWithFormat:@"%@%@",BaseApi,HomePageIntelligenceList_API] withTitle:@"供应链采购"];
    }else if (button.tag == 2005){
        
        [self pushToWKWebViewCtrlUrl:[NSString stringWithFormat:@"%@%@",BaseApi,HomePageSolutionList_API] withTitle:@"供应链采购"];
    }else{
        
    }
}


- (void)cellBtnClick:(UIButton *)button{
    
    if (button.tag == 10) {
        
        [self pushToWKWebViewCtrlUrl:@"http://wap.cecb2b.com/corp/200890/index" withTitle:@"商品详情页"];
    }else if (button.tag == 20) {
        
        [self pushToWKWebViewCtrlUrl:@"http://wap.cecb2b.com/corp/icInfo/10498233?corpId=200890" withTitle:@"商品详情页"];
    }else if (button.tag == 30){
        
        [self pushToWKWebViewCtrlUrl:@"http://wap.cecb2b.com/corp/icInfo/10498212?corpId=200890" withTitle:@"商品详情页"];
    }else if (button.tag == 11){
        
        [self pushToWKWebViewCtrlUrl:@"http://wap.cecb2b.com/corp/204505/index" withTitle:@"商品详情页"];
    }else if (button.tag == 21){
        
        [self pushToWKWebViewCtrlUrl:@"http://wap.cecb2b.com/corp/nicInfo/4717332?corpId=204505" withTitle:@"商品详情页"];
    }else if (button.tag == 31){
        
        [self pushToWKWebViewCtrlUrl:@"http://wap.cecb2b.com/corp/nicInfo/4717330?corpId=204505" withTitle:@"商品详情页"];
    }else if (button.tag == 12){
        
        [self pushToWKWebViewCtrlUrl:@"http://wap.cecb2b.com/corp/344123/index" withTitle:@"商品详情页"];
    }else if (button.tag == 22){
        
        [self pushToWKWebViewCtrlUrl:@"http://wap.cecb2b.com/corp/nicInfo/4860411?corpId=344123" withTitle:@"商品详情页"];
    }else if (button.tag == 32){
        
        [self pushToWKWebViewCtrlUrl:@"http://wap.cecb2b.com/corp/icInfo/174637559?corpId=344123" withTitle:@"商品详情页"];
    }else if (button.tag == 13){
        
        [self pushToWKWebViewCtrlUrl:@"http://wap.cecb2b.com/corp/312281/index" withTitle:@"商品详情页"];
    }else if (button.tag == 23){
        
        [self pushToWKWebViewCtrlUrl:@"http://wap.cecb2b.com/corp/nicInfo/4803560?corpId=312281" withTitle:@"商品详情页"];
    }else if (button.tag == 33){
        
        [self pushToWKWebViewCtrlUrl:@"http://wap.cecb2b.com/corp/nicInfo/4837211?corpId=312281" withTitle:@"商品详情页"];
    }else if (button.tag == 14){
        
        [self pushToWKWebViewCtrlUrl:@"http://wap.cecb2b.com/corp/205170/index" withTitle:@"商品详情页"];
    }else if (button.tag == 24){
        
        [self pushToWKWebViewCtrlUrl:@"http://wap.cecb2b.com/corp/nicInfo/4993916?corpId=205170" withTitle:@"商品详情页"];
    }else if (button.tag == 34){
        
        [self pushToWKWebViewCtrlUrl:@"http://wap.cecb2b.com/corp/nicInfo/4993348?corpId=205170" withTitle:@"商品详情页"];
    }
}

- (void)pushToWKWebViewCtrlUrl:(NSString *)urlStr withTitle:(NSString *)title{
    
    WKWebViewViewController *vc = [[WKWebViewViewController alloc]initWithUrlStr:urlStr title:title];
    [self.viewControler.navigationController pushViewController:vc animated:YES];
}
@end
