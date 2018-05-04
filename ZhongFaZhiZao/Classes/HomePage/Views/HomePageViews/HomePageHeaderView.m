//
//  HomePageHeaderView.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/3/5.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "HomePageHeaderView.h"
#import "HomeViewController.h"
#import "HomePageImgRunLoopView.h"
#import "ZYJHeadLineView.h"
#import "ZYJHeadLineModel.h"
#import "KnowLedgeViewController.h"
#import "FinanceViewController.h"

#define margins 8

@interface HomePageHeaderView (){
    HomePageImgRunLoopView *_imgRunView;
    
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


@implementation HomePageHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _dataArr=[[NSMutableArray alloc]init];
        //初始化子视图
        [self _initSubViews];
    }
    return self;
}
- (void)_initSubViews{
    
    self.backgroundColor = BACK_COLOR;
    
    _imgRunView = [[HomePageImgRunLoopView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 180 * KWidth_ScaleH) placeholderImg:[UIImage imageNamed:@"HomePageHeaderBanner"]];
    NSLog(@"theHeight:%f",self.frame.size.height);
    [self addSubview:_imgRunView];
    
    self.adView = [[UIView alloc]initWithFrame:CGRectMake(0, 8+CGRectGetMaxY(_imgRunView.frame), kScreenWidth, 40)];
    self.adView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.adView];
    
    //    行业热点logo
    UIImageView *hotDianImg = [[UIImageView alloc]initWithFrame:CGRectMake(margins, (40-25)/2.0+1, 91, 25)];
    hotDianImg.image = [UIImage imageNamed:@"HomePageHeaderHotLogo"];
    [self.adView addSubview:hotDianImg];
    
    UILabel *hangyeLine = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(hotDianImg.frame)+7, (40 - 25)/2.0, 1.5, 25)];
    hangyeLine.backgroundColor = TEXT_LINE_COLOR;
    [self.adView addSubview:hangyeLine];
    
    _TopLineView = [[ZYJHeadLineView alloc]initWithFrame:CGRectMake(2+CGRectGetMaxX(hangyeLine.frame), 0, kScreenWidth-margins-(7+CGRectGetMaxX(hangyeLine.frame)), 40)];
    //    _TopLineView.center = CGPointMake(ScreenWidth/2.0, ScreenHeight/2.0-150);
    _TopLineView.backgroundColor = [UIColor whiteColor];
    [self.adView addSubview:_TopLineView];
    
    UILabel *lineLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.adView.frame)-1, kScreenWidth, 1)];
    lineLabel1.backgroundColor = TEXT_LINE_COLOR;
    [self addSubview:lineLabel1];
    
    self.mainBtnView = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_imgRunView.frame)+40+8 , kScreenWidth, 164)];
    self.mainBtnView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.mainBtnView];
    
    
    NSArray *mainBtnImageArr = @[@"HomePageSupplyChainIcon",@"HomePageSmartInnovationIcon",@"HomePageScienceResultIcon",@"HomePageSolutionIcon",@"HomePagePropertyRightsOfPatenticonIcon",@"HomePageFinancialIcon"];
    NSArray *mainBtnArr = @[@"供应链采购",@"智能创新",@"科技成果",@"解决方案",@"知识产权专利",@"金融服务"];
    
    int flag = 0;
    
    for (int i = 0; i < 3; i++) {
        
        for (int j = 0; j < 2; j++) {
            
            self.mainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.mainBtn.frame = CGRectMake(i*48+(i*2+1.0)*(kScreenWidth-48*3)/6.0, 48*j+10+j*30.0, 48, 48);
            [self.mainBtn setImage:[UIImage imageNamed:mainBtnImageArr[flag]] forState:UIControlStateNormal];
            self.mainBtn.tag = flag+1000;
            self.mainBtn.layer.masksToBounds = YES;
            self.mainBtn.layer.cornerRadius = 48/2.0;
            self.mainBtn.backgroundColor = [UIColor whiteColor];
            [self.mainBtn addTarget:self action:@selector(mainButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.mainBtnView addSubview:self.mainBtn];
            
            UILabel *mainLbl = [[UILabel alloc]initWithFrame:CGRectMake(i*kScreenWidth/3.0, CGRectGetMaxY(self.mainBtn.frame)+4, kScreenWidth/3.0, 14)];
            mainLbl.text = mainBtnArr[flag];
            mainLbl.textAlignment = NSTextAlignmentCenter;
            mainLbl.font = [UIFont systemFontOfSize:11.0];
            [self.mainBtnView addSubview:mainLbl];
            
            flag++;
        }
    }
    
    UIImageView *firstImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.mainBtnView.frame)+8, kScreenWidth, 80*KWidth_ScaleH)];
    firstImg.image = [UIImage imageNamed:@"HomePageSupplyChainProcurementIcon"];
    firstImg.userInteractionEnabled = YES;
    [firstImg addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(GongbuttonClick)]];
    [self addSubview:firstImg];
}

- (void)setModel:(HomePageHeaderModel *)model{
    
    if (_model != model) {
        _model = model;
        [self getHotData];
        _imgRunView.imgUrlArray = self.imgMarr;
        WS(weakself);
        [_imgRunView  touchImageIndexBlock:^(NSInteger index) {
            NSLog(@"%ld",(long)index);
            [weakself choiceTheImageIndex:index];
        }];
        
        _TopLineView.clickBlock = ^(NSInteger index){
            ZYJHeadLineModel *model = weakself.dataArr[index];
            NSLog(@"%@,%@",model.type,model.title);
            
            HomePageHeaderAd44Infos *ad44Info = weakself.model.data.ad_id_44[index];
            
            WKWebViewViewController *vc = [[WKWebViewViewController alloc]initWithUrlStr:[NSString stringWithFormat:@"%@",ad44Info.url] title:@"广告"];
            
            [weakself.viewControler.navigationController pushViewController:vc animated:YES];
        };
        
    }
}

#pragma mark-获取数据
- (void)getHotData
{
    NSArray *arr3 = [NSArray arrayWithArray:self.textMarr];
    for (int i=0; i<arr3.count; i++) {
        ZYJHeadLineModel *model = [[ZYJHeadLineModel alloc]init];
        model.type = @"HOT";
        model.title = arr3[i];
        [_dataArr addObject:model];
    }
    [_TopLineView setVerticalShowDataArr:_dataArr];
}
#pragma mark -- 懒加载
- (NSMutableArray *)imgMarr{
    if (!_imgMarr) {
        //        NSString *urlStr = @"http://pic.121mai.com/s28_05460157903471942.gif";
        _imgMarr = [NSMutableArray arrayWithCapacity:8];
        for (HomePageHeaderAd41Infos *ad41Info in self.model.data.ad_id_41) {
            [_imgMarr addObject:ad41Info.img_path];
        }
    }
    return _imgMarr;
}
- (NSMutableArray *)textMarr{
    if (!_textMarr) {
        _textMarr = [NSMutableArray arrayWithCapacity:8];
        for (HomePageHeaderAd44Infos *ad44Info in self.model.data.ad_id_44) {
            [_textMarr addObject:ad44Info.txt];
        }
    }
    return _textMarr;
}
#pragma mark -- method
- (void)choiceTheImageIndex:(NSInteger)index{
    HomePageHeaderAd41Infos *ad41Info = self.model.data.ad_id_41[index];
    WKWebViewViewController *vc = [[WKWebViewViewController alloc]initWithUrlStr:[NSString stringWithFormat:@"%@",ad41Info.url] title:@"广告"];
    
    [self.viewControler.navigationController pushViewController:vc animated:YES];
}

#pragma mark -- 按钮事件
//6个圆形按钮点击事件
- (void)mainButtonClick:(UIButton *)button{
    
    
    if (button.tag == Supply ) {
        
        WKWebViewViewController *wkvc = [[WKWebViewViewController alloc]initWithUrlStr:[NSString stringWithFormat:@"%@%@",BaseApi,HomePageSupplyChainList_API] title:@"供应链采购"];
        //        wkvc.hidesBottomBarWhenPushed = YES;
        [self.viewControler.navigationController pushViewController:wkvc animated:YES];
        
    }
    else if (button.tag == Science){
        
        WKWebViewViewController *wkvc = [[WKWebViewViewController alloc]initWithUrlStr:[NSString stringWithFormat:@"%@%@",BaseApi,HomePageScienceList_API] title:@"科技成果"];
        //        wkvc.hidesBottomBarWhenPushed = YES;
        [self.viewControler.navigationController pushViewController:wkvc animated:YES];
        
    }
    else if (button.tag == Knowledge){
        
        KnowLedgeViewController *vc = [[KnowLedgeViewController alloc]init];
        [self.viewControler.navigationController pushViewController:vc animated:YES];
        
    }
    else if (button.tag == Intelligence){
        
        WKWebViewViewController *wkvc = [[WKWebViewViewController alloc]initWithUrlStr:[NSString stringWithFormat:@"%@%@",BaseApi,HomePageIntelligenceList_API] title:@"智能创新"];
        //        wkvc.hidesBottomBarWhenPushed = YES;
        [self.viewControler.navigationController pushViewController:wkvc animated:YES];
        
    }
    else if (button.tag == Solve){
        
        WKWebViewViewController *wkvc = [[WKWebViewViewController alloc]initWithUrlStr:[NSString stringWithFormat:@"%@%@",BaseApi,HomePageSolutionList_API] title:@"解决方案"];
        
        //        wkvc.hidesBottomBarWhenPushed = YES;
        [self.viewControler.navigationController pushViewController:wkvc animated:YES];
        
    }
    else{
        
        //        [WKProgressHUD popMessage:@"敬请期待" inView:self.view duration:HUD_DURATION animated:YES];
        
        FinanceViewController *vc = [[FinanceViewController alloc]init];
        [self.viewControler.navigationController pushViewController:vc animated:YES];
    }
    
}

//供应链header点击事件
- (void)GongbuttonClick{
    
    WKWebViewViewController *wkvc = [[WKWebViewViewController alloc]initWithUrlStr:[NSString stringWithFormat:@"%@%@",BaseApi,HomePageSupplyChainList_API] title:@"供应链采购"];
    [self.viewControler.navigationController pushViewController:wkvc animated:YES];
    
}
@end
