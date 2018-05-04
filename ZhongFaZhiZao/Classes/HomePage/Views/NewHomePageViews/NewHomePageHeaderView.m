//
//  NewHomePageHeaderView.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/8.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "NewHomePageHeaderView.h"
#import "HomePageImgRunLoopView.h"
#import "ZYJHeadLineView.h"
//#import "ZYJHeadLineModel.h"
#import "NewHomePageCustomRecommendView.h"
#import "NewHomePageCustomRecommendGapView.h"
#import "HeaderBJView.h"

@interface NewHomePageHeaderView (){
    HomePageImgRunLoopView *_imgRunView;
    UIButton *_fifButton;
}
@property (nonatomic,strong) UIView *adView;     //广告
//上下滚动广告栏
@property (nonatomic, strong) ZYJHeadLineView *TopLineView;

@property (nonatomic, strong) UIView *mainBtnView;
@property (nonatomic, strong) UIButton *mainBtn;
/** 图片数组*/
@property (nonatomic, strong) NSMutableArray *imgMarr;
/** 文字数组*/
@property (nonatomic, strong) NSMutableArray *textMarr;
@property(nonatomic, strong) NSMutableArray *dataArr;


@end

@implementation NewHomePageHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _dataArr=[[NSMutableArray alloc] init];
        //初始化子视图
        [self _initSubViews];
        [self getData];
    }
    return self;
}
- (void)_initSubViews{
    self.userInteractionEnabled = YES;
    self.backgroundColor = BACK_COLOR;
    // 1.轮播图
    _imgRunView = [[HomePageImgRunLoopView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 475/2.0 * KWidth_ScaleH) placeholderImg:[UIImage imageNamed:@"HomePageHeaderBanner"]];
    NSLog(@"theHeight:%f",self.frame.size.height);
    [self addSubview:_imgRunView];
    //2.功能按钮
    CGFloat leftAndRightGapWidth = 7/2.0 * KWidth_ScaleW;
    CGFloat mainBtnViewWidth = kScreenWidth - leftAndRightGapWidth * 2;
    CGFloat mainBtnViewHeight = 501/2.0 * KWidth_ScaleH;
    self.mainBtnView = [[UIView alloc] initWithFrame:CGRectMake(leftAndRightGapWidth,352/2.0 * KWidth_ScaleH , mainBtnViewWidth, mainBtnViewHeight)];
    self.mainBtnView.backgroundColor = [UIColor whiteColor];
    self.mainBtnView.layer.borderWidth = 1;
    self.mainBtnView.layer.cornerRadius = 20;
    self.mainBtnView.clipsToBounds = YES;
    self.mainBtnView.layer.borderColor = UIColorFromRGBA(206, 243, 253, 1.0).CGColor;
    self.mainBtnView.layer.shadowOffset = CGSizeMake(1, 5);
    [self addSubview:self.mainBtnView];
    NSArray *mainBtnImageArr = @[@"NewHomePageScienceResultIcon",@"NewHomePageSolutionIcon",@"NewHomePageSmartShoppinMallIcon",@"NewHomePageSmartInformationIcon",@"NewHomePagePhysicalMarketIcon",@"NewHomePageSupplyChainIcon"];
    NSArray *mainBtnArr = @[@"科技成果",@"解决方案",@"智造商城",@"智造资讯",@"实体市场",@"供应链"];
    
    int flag = 0;
    CGFloat mainBtnGapWidthFromTop = 34/2.0 * KWidth_ScaleH;
    CGFloat mainBtnGapWidthWithOtherBtn = 64/2.0 * KWidth_ScaleH;
    CGFloat mainBtnGapWidthWithOtherLabel = 9/2.0 * KWidth_ScaleH;
    CGFloat mainBtnWidth = 105/2.0 * KWidth_ScaleW;
    CGFloat mainLabelHeight = 30/2.0 * KWidth_ScaleH;
    for (int i = 0; i < 3; i++) {
        
        for (int j = 0; j < 2; j++) {
            
            self.mainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.mainBtn.frame = CGRectMake(i * mainBtnWidth + (i * 2 + 1.0) * (kScreenWidth - mainBtnWidth * 3)/6.0, mainBtnWidth * j + mainBtnGapWidthFromTop + j * mainBtnGapWidthWithOtherBtn, mainBtnWidth, mainBtnWidth);
            [self.mainBtn setImage:[UIImage imageNamed:mainBtnImageArr[flag]] forState:UIControlStateNormal];
            self.mainBtn.tag = flag+1000;
            self.mainBtn.layer.masksToBounds = YES;
            self.mainBtn.layer.cornerRadius = mainBtnWidth/2.0;
            self.mainBtn.backgroundColor = [UIColor whiteColor];
            [self.mainBtn addTarget:self action:@selector(mainButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.mainBtnView addSubview:self.mainBtn];
            
            UILabel *mainLbl = [[UILabel alloc] initWithFrame:CGRectMake(i*kScreenWidth/3.0, CGRectGetMaxY(self.mainBtn.frame) + mainBtnGapWidthWithOtherLabel, kScreenWidth/3.0, mainLabelHeight)];
            mainLbl.tag = flag+1010;
            mainLbl.text = mainBtnArr[flag];
            mainLbl.textAlignment = NSTextAlignmentCenter;
            mainLbl.font = [UIFont systemFontOfSize:11.0];
            [self.mainBtnView addSubview:mainLbl];
            
            flag++;
        }
    }
    UILabel *label4 = (UILabel *)[self.mainBtnView viewWithTag:1013];
    //3.分割线1
    UIView *gapLine1 = [[UIView alloc] initWithFrame:CGRectMake(0, label4.bottom + 23.5/2.0 * KWidth_ScaleH, self.mainBtnView.width, 1.5)];
    gapLine1.backgroundColor = UIColorFromRGBA(238, 238, 238, 1.0);
    [self.mainBtnView addSubview:gapLine1];
    //4.智造头条广告
    CGFloat adViewHeight = 128.5/2.0 * KWidth_ScaleH;
    CGFloat adViewGapFromTop = (self.mainBtnView.height - gapLine1.bottom - adViewHeight)/2.0;
    self.adView = [[UIView alloc] initWithFrame:CGRectMake(0, gapLine1.bottom + adViewGapFromTop, self.mainBtnView.width, adViewHeight)];
    self.adView.backgroundColor = [UIColor whiteColor];
    [self.mainBtnView addSubview:self.adView];
    //  智造头条logo
    CGFloat headLineImgWidth = 68/2.0 * KWidth_ScaleW;
    CGFloat headLineImgGapFromLeft = 46/2.0 * KWidth_ScaleW;
    CGFloat headLineImgGapFromTop = (self.adView.height - headLineImgWidth)/2.0;
    UIImageView *headLineImg = [[UIImageView alloc]initWithFrame:CGRectMake(headLineImgGapFromLeft, headLineImgGapFromTop, headLineImgWidth, headLineImgWidth)];
    headLineImg.image = [UIImage imageNamed:@"NewHomePageHeaderHeadLineLogo"];
    [self.adView addSubview:headLineImg];
    //智造广告背景image
    CGFloat adBJImgWidth = 102/2.0 * KWidth_ScaleW;
    CGFloat adBJImgHeight = 91/2.0 * KWidth_ScaleH;
    UIImageView *adBJImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, adBJImgWidth, adBJImgHeight)];
    adBJImg.centerY = headLineImg.centerY;
    adBJImg.right = self.adView.right;
    adBJImg.image = [UIImage imageNamed:@"NewHomePageadBJImgLogo"];
    [self.adView addSubview:adBJImg];
    
    CGFloat hangyeLineWidth = 4/2.0 * KWidth_ScaleH;
    CGFloat hangyeLineHeight = 69/2.0 * KWidth_ScaleH;
    CGFloat hangyeLineGapFromLeft = 28.5/2.0 * KWidth_ScaleW;
    CGFloat hangyeLineGapFromTop = (self.adView.height - hangyeLineHeight) / 2.0;
    UILabel *hangyeLine = [[UILabel alloc]initWithFrame:CGRectMake(headLineImg.right + hangyeLineGapFromLeft, hangyeLineGapFromTop, hangyeLineWidth, hangyeLineHeight)];
    hangyeLine.backgroundColor = TEXT_LINE_COLOR;
    [self.adView addSubview:hangyeLine];
    
    CGFloat TopLineViewGapFromLeft = 30.5/2.0 * KWidth_ScaleW;
    CGFloat TopLineViewGapFromRight = 88/2.0 * KWidth_ScaleW;
    _TopLineView = [[ZYJHeadLineView alloc]initWithFrame:CGRectMake(hangyeLine.right +  TopLineViewGapFromLeft, 0, self.adView.width - TopLineViewGapFromRight - hangyeLine.right - TopLineViewGapFromLeft, hangyeLineHeight)];
    _TopLineView.centerY = hangyeLine.centerY;
    WS(weakSelf);
    _TopLineView.clickBlock = ^(NSInteger index){
        ZYJHeadLineModel *model = weakSelf.dataArr[index];
        NSLog(@"%@,%@",model.type,model.title);
    };
    [self.adView addSubview:_TopLineView];
    
    //5.间隙视图
    CGFloat gapView1Height = 18.1/2.0 * KWidth_ScaleH;
    UIView *gapView1 = [[UIView alloc] initWithFrame:CGRectMake(0, self.mainBtnView.bottom, kScreenWidth, gapView1Height)];
    gapView1.backgroundColor = UIColorFromRGBA(246, 246, 246, 1.0);
    [self addSubview:gapView1];
    //6.推荐商品
    CGFloat recommendBJImgHeight = 413/2.0 * KWidth_ScaleH;
    UIImageView *recommendBJImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, gapView1.bottom, kScreenWidth, recommendBJImgHeight)];
    recommendBJImg.image = [UIImage imageNamed:@"NewHomePageRecommendBJImgIcon"];
    recommendBJImg.userInteractionEnabled = YES;
    [self addSubview:recommendBJImg];
    
    CGFloat fromLeftGapWidth = 32/2.0 * KWidth_ScaleW;
    CGFloat fromTopGapWidth = 91.4/2.0 * KWidth_ScaleH;
    CGFloat gapWidth = 13.5/2.0 * KWidth_ScaleW;
    CGFloat itemWidth = (kScreenWidth - gapWidth * 2 - fromLeftGapWidth * 2) / 3.0;
    NSInteger temptCount = 3;
    CGFloat itemHeight = 285.5/2.0 * KWidth_ScaleH;
    for (UIView *subView in recommendBJImg.subviews) {
        [subView removeFromSuperview];
    }
    CGFloat recommendGapViewFromTop = 23/2.0 * KWidth_ScaleH;
    NewHomePageCustomRecommendGapView *recommendGapView = [[NewHomePageCustomRecommendGapView alloc] initWithFrame:CGRectMake(0, recommendGapViewFromTop, 105.5 * KWidth_ScaleW, 42/2.0 * KWidth_ScaleH)];
    recommendGapView.centerX = recommendBJImg.centerX;
    [recommendBJImg addSubview:recommendGapView];
    for (NSInteger i = 0; i < temptCount; i++) {
        NewHomePageCustomRecommendView *itemView = [[NewHomePageCustomRecommendView alloc] initWithFrame:CGRectMake(fromLeftGapWidth + i * (itemWidth + gapWidth), fromTopGapWidth, itemWidth, itemHeight)];
        itemView.layer.cornerRadius = 5 * KWidth_ScaleW;
        itemView.clipsToBounds = YES;
        itemView.tag = 10 + i;
        [recommendBJImg addSubview:itemView];
        itemView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemViewTapAction:)];
        [itemView addGestureRecognizer:tap];
    }
    //7.智造商城sectionHeaderView
    HeaderBJView *headerBJView = [[HeaderBJView alloc]initWithFrame:CGRectMake(0, recommendBJImg.bottom + 39.0/2.0 * KWidth_ScaleH, kScreenWidth,(80 + 76)/2.0 * KWidth_ScaleH)];
    headerBJView.backgroundColor = [UIColor whiteColor];
    headerBJView.userInteractionEnabled = YES;
    [self addSubview:headerBJView];
    
}

#pragma mark-获取数据
- (void)getData
{
    NSArray *arr1 = @[@"HOT",@"HOT",@"HOT",@"HOT",@"HOT"];
    NSArray *arr2 = @[@"大降价了啊",@"iPhone7分期",@"这个苹果蛮脆的",@"来尝个香蕉吧",@"越来越香了啊你的秀发"];
    for (int i=0; i<arr2.count; i++) {
        ZYJHeadLineModel *model = [[ZYJHeadLineModel alloc]init];
        model.type = arr1[i];
        model.title = arr2[i];
        [_dataArr addObject:model];
    }
    [_TopLineView setVerticalShowDataArr:_dataArr];
}
#pragma mark -- 按钮事件
//6个圆形按钮点击事件
- (void)mainButtonClick:(UIButton *)button{
    
    NSString *apiStr;
    NSString *title;
    if (button.tag == ScienceResult ) {
        
        apiStr = [NSString stringWithFormat:@"%@%@",BaseApi,HomePageScienceList_API];
        title = @"科技成果";
        [self pushWkWebViewWithAPIString:apiStr withTitle:title];
    }
    else if (button.tag == Solve){
        
        apiStr = [NSString stringWithFormat:@"%@%@",BaseApi,HomePageSolutionList_API];
        title = @"解决方案";
        [self pushWkWebViewWithAPIString:apiStr withTitle:title];
        
    }
    else if (button.tag == SamrtShoppingMall){
        NSLog(@"点击的是智造商城");
//        KnowLedgeViewController *vc = [[KnowLedgeViewController alloc]init];
//        [self.viewControler.navigationController pushViewController:vc animated:YES];
        
    }
    else if (button.tag == SmartInformation){
        
        apiStr = [NSString stringWithFormat:@"%@%@",BaseApi,HomePageIntelligenceList_API];
        title = @"智能资讯";
        [self pushWkWebViewWithAPIString:apiStr withTitle:title];
    }
    else if (button.tag == PhysicalMarket){
        NSLog(@"点击的是实体市场");
    }
    else{
        apiStr = [NSString stringWithFormat:@"%@%@",BaseApi,HomePageSupplyChainList_API];
        title = @"供应链";
        [self pushWkWebViewWithAPIString:apiStr withTitle:title];
    }
    
}

#pragma mark -- 手势
- (void)itemViewTapAction:(UITapGestureRecognizer *)tap{
    
    NSLog(@"点击了第%ld个视图",tap.view.tag);
}


- (void)pushWkWebViewWithAPIString:(NSString *)apiString withTitle:(NSString *)title{
    
    WKWebViewViewController *wkvc = [[WKWebViewViewController alloc]initWithUrlStr:apiString title:title];
    //        wkvc.hidesBottomBarWhenPushed = YES;
    [self.viewControler.navigationController pushViewController:wkvc animated:YES];
}
@end