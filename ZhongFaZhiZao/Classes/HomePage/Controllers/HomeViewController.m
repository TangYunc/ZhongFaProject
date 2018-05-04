//
//  HomeViewController.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/3/1.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "HomeViewController.h"
//#import "HomePageCollectionView.h"
#import "NewHomePageCollectionView.h"
#import "ZYJHeadLineModel.h"
#import "HomePageHeaderModel.h"
//#import "WXPayViewController.h"
#import "QRCodeReaderViewController.h"
#import "MessageCenterViewController.h"
#import "NewHomePageClassifyResult.h"
#import "ClassifyPopView.h"
#import "NewHomePageRecommendResult.h"
#import "NewHomePageSmartHeadlineNewsResult.h"
#import "NewHomePageScienceResult.h"
#import "NewHomeSolveResult.h"
#import "NewHomePageSmartShoppingMallResult.h"

@interface HomeViewController ()<QRCodeReaderDelegate>

//@property (nonatomic,strong) HomePageCollectionView *collectionView;
@property (nonatomic,strong) NewHomePageCollectionView *collectionView;
@property (nonatomic,copy) NSArray *adid41Arr;  //广告位41
@property (nonatomic,copy) NSArray *adid44Arr;  //广告位44
@property (nonatomic,strong) NSMutableArray *cityArray;
@property (nonatomic,strong) NSMutableDictionary *cityDict;
@property (nonatomic,assign) NSInteger cityNumber;

@property (nonatomic,strong) NSMutableArray *scrollImg;
@property (nonatomic,strong) NSMutableArray *scrollTxt;
@property(nonatomic,strong)NSMutableArray *dataArr;

@property (nonatomic,strong) UIButton *pushSerchBtn;
//导航栏view
@property (nonatomic,strong) UIView *navigationView;

@property (nonatomic,strong) NSArray *classifyResultArr;
@property (nonatomic,strong) NSArray *adResultArr;
@property (nonatomic,strong) NSArray *smartHeadlineNewsResultArr;
@end

@implementation HomeViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navBarView removeFromSuperview];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.navigationController.childViewControllers.count > 1) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 控制某个tabbar 不可以侧滑
    self.navigationController.fd_fullscreenPopGestureRecognizer.enabled = NO;
    [self setNavigationBarTitle:@"首页"];
    
    // 初始化子视图
    [self setupSubViews];
    [self setUpNavgationView];
    NSString *apiToken = [KUserDefault objectForKey:APIToken];
    NSLog(@"API请求0");
    if (apiToken == nil) {
        [self loadDateAPIToken];
    }else{
        [self allLoadDataAPI];
    }
}

- (void)allLoadDataAPI{
    
    [self loadClassifyPopViewDate];
    [self loadadData];
    [self loadSmartHeadlineNewsData];
    [self loadSmartShoppingMallData];
    [self loadTheRecommendData];
    [self loadScienceResultData];
    [self loadSolveData];
    [self loadCityData];
}

- (void)setupSubViews{

    _collectionView = [[NewHomePageCollectionView alloc] initWithFrame:CGRectMake( 0, 0, kScreenWidth, kScreenHeight - 49 - SafeAreaBottomHeight)];
    _collectionView.navigationView = self.navigationView;
    _collectionView.navBarView = self.navBarView;
    [self.view addSubview:_collectionView];
}

#pragma mark - 创建UI
- (void)setUpNavgationView {
    
    self.navigationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, SafeAreaTopHeight)];
    
    
    // 3.设置图片
    UIImage *barImage = [UIImage imageNamed:@"HomePageNavBar"];
    // 使用CoreGraphics框架去改变图片原始的大小
    CGImageRef endImageRef = CGImageCreateWithImageInRect(barImage.CGImage, CGRectMake(0, 0, kScreenWidth, SafeAreaTopHeight));
    barImage = [UIImage imageWithCGImage:endImageRef];
    self.navigationView.backgroundColor = [UIColor colorWithPatternImage:barImage];
    
    // 释放图片
    CGImageRelease(endImageRef);
    
    
    [self.view addSubview:self.navigationView];
    
    self.pushSerchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.pushSerchBtn.frame = CGRectMake(35/2.0*KWidth_ScaleW,(SafeAreaTopHeight - 40)+(59/2.0-57/2.0)/2.0, 630/2.0*KWidth_ScaleW, 59/2.0);
    self.pushSerchBtn.backgroundColor = [UIColor clearColor];
    [self.pushSerchBtn setBackgroundImage:[UIImage imageNamed:@"HomePageSearchIcon"] forState:UIControlStateNormal];
    
    self.pushSerchBtn.imageView.frame = self.pushSerchBtn.bounds;
    self.pushSerchBtn.hidden = NO;
    [self.pushSerchBtn setEnabled:YES];
    [self.pushSerchBtn addTarget:self action:@selector(SearchButtonPush) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationView addSubview:self.pushSerchBtn];
    
    UIButton *QRcode = [UIButton buttonWithType:UIButtonTypeCustom];
    QRcode.frame = CGRectMake(kScreenWidth-20*KWidth_ScaleW-29/2.0*KWidth_ScaleW, (SafeAreaTopHeight - 40)+(59/2.0-24)/2.0, 59/2.0, 57/2.0);
    QRcode.backgroundColor = [UIColor clearColor];
    [QRcode setBackgroundImage:[UIImage imageNamed:@"HomePageScanQRcodeIcon"] forState:UIControlStateNormal];
    QRcode.imageView.frame = QRcode.bounds;
    QRcode.hidden = NO;
    [QRcode addTarget:self action:@selector(scanning) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationView addSubview:QRcode];
    /*
    UIButton *pushBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    pushBtn.frame = CGRectMake(kScreenWidth-20*KWidth_ScaleW-14*KWidth_ScaleW, (SafeAreaTopHeight - 40)+(59/2.0-24)/2.0, 20*KWidth_ScaleW, 27);
    pushBtn.backgroundColor = [UIColor clearColor];
    [pushBtn setBackgroundImage:[UIImage imageNamed:@"HomePageMessageCenterIcon"] forState:UIControlStateNormal];
    pushBtn.imageView.frame = pushBtn.bounds;
    pushBtn.hidden = NO;
    [pushBtn addTarget:self action:@selector(jPushButton) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationView addSubview:pushBtn];*/
}

- (void)showClassifyPopView{
    BOOL isShowClassify = [KUserDefault objectForKey:ShowClassifyPopView];
//    BOOL isGuidViewHide = [KUserDefault objectForKey:GuidViewHide];
    if (!isShowClassify) {
        
        ClassifyPopView *classifyPopView = [[ClassifyPopView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        classifyPopView.alertVC = self;
        classifyPopView.classifyResultArr = self.classifyResultArr;
//        [self.view addSubview:classifyPopView];
//        if (isGuidViewHide) {
        
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            [window addSubview:classifyPopView];
//        }
    }
}

#pragma mark - loadData
- (void)loadadData{
    //轮播图
    [TNetworking postWithUrl:[NSString stringWithFormat:@"%@%@",BaseApi,HomePageadInfo_API] params:nil success:^(id response) {
        NSLog(@"API请求3轮播图及推荐");
        HomePageHeaderModel *result = [HomePageHeaderModel mj_objectWithKeyValues:response];
        if (result.resultCode == 1000) {
            
            _collectionView.model = result;
        }else if ([response[@"resultCode"]integerValue] == 1001){
            
            [WKProgressHUD popMessage:@"广告位请求失败" inView:self.view duration:HUD_DURATION animated:YES];
        }
    } fail:^(NSError *error) {
        NSLog(@"error = %@",error);
        
        [WKProgressHUD popMessage:@"请检查网络连接" inView:self.view duration:HUD_DURATION animated:YES];
    } showHUD:NO];
}

- (void)loadTheRecommendData{
    
    NSString *apiToken = [KUserDefault objectForKey:APIToken];
    if (apiToken == nil) {
        return;
    }
    
    NSString *url = [NSString stringWithFormat:@"%@%@%@",BaseTwoApi,HomePageRecommend_API,apiToken];
    [TNetworking getWithUrl:url params:nil success:^(id response) {
        NSLog(@"API请求6推荐商品");
        [NewHomePageRecommendDatas mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"RecommendId" : @"id",@"RecommendDescription" : @"description"
                     };
        }];

        NewHomePageRecommendResult *result = [NewHomePageRecommendResult mj_objectWithKeyValues:response];
        if (result.success) {

            _collectionView.recommendArr = result.data.datas;
        }else{
            
            NSLog(@"%@",result.message);
        }
    } fail:^(NSError *error) {
        NSLog(@"error = %@",error);
        
        [WKProgressHUD popMessage:@"请检查网络连接" inView:self.view duration:HUD_DURATION animated:YES];
    } showHUD:NO];
}

- (void)loadSmartHeadlineNewsData{
    
    NSString *apiToken = [KUserDefault objectForKey:APIToken];
    if (apiToken == nil) {
        return;
    }
    
    NSString *url = [NSString stringWithFormat:@"%@%@%@",BaseTwoApi,HomePageSmartHeadlineNews_API,apiToken];
    [TNetworking getWithUrl:url params:nil success:^(id response) {
        NSLog(@"API请求4智造资讯");
        NewHomePageSmartHeadlineNewsResult *result = [NewHomePageSmartHeadlineNewsResult mj_objectWithKeyValues:response];
        if (result.success) {
            
            self.smartHeadlineNewsResultArr = [NSArray array];
            self.smartHeadlineNewsResultArr = result.data.datas;
            _collectionView.smartHeadlineNewsResultArr = self.smartHeadlineNewsResultArr;
            [_collectionView reloadData];
            
        }else{
            
            [WKProgressHUD popMessage:@"广告位请求失败" inView:self.view duration:HUD_DURATION animated:YES];
        }
    } fail:^(NSError *error) {
        NSLog(@"error = %@",error);
        
        [WKProgressHUD popMessage:@"请检查网络连接" inView:self.view duration:HUD_DURATION animated:YES];
    } showHUD:NO];
}

- (void)loadSmartShoppingMallData{
    
    NSString *apiToken = [KUserDefault objectForKey:APIToken];
    if (apiToken == nil) {
        return;
    }
    NSString *url = [NSString stringWithFormat:@"%@%@%@",BaseTwoApi,HomePageSmartShoppingMall_API,apiToken];
    [TNetworking getWithUrl:url params:nil success:^(id response) {
        NSLog(@"API请求5智造商城");
        [NewHomePageSmartShoppingMallDatas mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"smartMallId" : @"id"
                     };
        }];
        [NewHomePageSmartShoppingMallDatas mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"adListId" : @"id"
                     };
        }];
        
        NewHomePageSmartShoppingMallResult *result = [NewHomePageSmartShoppingMallResult mj_objectWithKeyValues:response];
        if (result.success) {
            
            _collectionView.smartShoppingMallArr = result.data.datas;
            [_collectionView reloadData];
        }else{
            
            NSLog(@"%@",result.message);
        }
    } fail:^(NSError *error) {
        NSLog(@"error = %@",error);
        
        [WKProgressHUD popMessage:@"请检查网络连接" inView:self.view duration:HUD_DURATION animated:YES];
    } showHUD:NO];
}

- (void)loadScienceResultData{
    
    NSString *apiToken = [KUserDefault objectForKey:APIToken];
    if (apiToken == nil) {
        return;
    }
    NSString *url = [NSString stringWithFormat:@"%@%@%@",BaseTwoApi,HomePageScienceResult_API,apiToken];
    [TNetworking getWithUrl:url params:nil success:^(id response) {
        NSLog(@"API请求6科技成果");
        [NewHomePageScienceResultDatas mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"scienceResultId" : @"id"
                     };
        }];
        
        NewHomePageScienceResult *result = [NewHomePageScienceResult mj_objectWithKeyValues:response];
        if (result.success) {
            
            _collectionView.scienceResultArr = result.data.datas;
            [_collectionView reloadData];
        }else{
            
            NSLog(@"%@",result.message);
        }
    } fail:^(NSError *error) {
        NSLog(@"error = %@",error);
        
        [WKProgressHUD popMessage:@"请检查网络连接" inView:self.view duration:HUD_DURATION animated:YES];
    } showHUD:NO];
}

- (void)loadSolveData{
    
    NSString *apiToken = [KUserDefault objectForKey:APIToken];
    if (apiToken == nil) {
        return;
    }
    NSString *url = [NSString stringWithFormat:@"%@%@%@",BaseTwoApi,HomePageSolve_API,apiToken];
    [TNetworking getWithUrl:url params:nil success:^(id response) {
        NSLog(@"API请求8解决方案");
        [NewHomePageSolveDatas mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                    @"solveDatasDescription":@"description"
                     };
        }];
        [NewHomePageSolution_data mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"solutionDataId" : @"id",@"solutionDataDescription":@"description"
                     };
        }];
        
        NewHomeSolveResult *result = [NewHomeSolveResult mj_objectWithKeyValues:response];
        if (result.success) {
            
            _collectionView.solveArr = result.data.datas;
            [_collectionView reloadData];
        }else{
            
            NSLog(@"%@",result.message);
        }
    } fail:^(NSError *error) {
        NSLog(@"error = %@",error);
        
        [WKProgressHUD popMessage:@"请检查网络连接" inView:self.view duration:HUD_DURATION animated:YES];
    } showHUD:NO];
}

- (void)loadCityData{
    
    [TNetworking postWithUrl:[NSString stringWithFormat:@"%@%@",BaseApi,electronic_API] params:nil success:^(id response) {
        NSLog(@"API请求9城市");
        if ([response[@"resultCode"]integerValue] == 1000) {
            
            _cityDict = [NSMutableDictionary dictionaryWithDictionary:response[@"data"]];
            
            if (self.cityNumber == 3) {
                _cityArray = [NSMutableArray arrayWithArray:_cityDict[@"深圳"]];
            }
            else if (self.cityNumber == 1){
                _cityArray = [NSMutableArray arrayWithArray:_cityDict[@"北京"]];
            }
            else if (self.cityNumber == 2){
                _cityArray = [NSMutableArray arrayWithArray:_cityDict[@"西安"]];
            }
            else{
                
                _cityArray = [NSMutableArray arrayWithArray:_cityDict[@"全部"]];
            }
            
            self.collectionView.cityArray = _cityArray;
            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:3];
            
            [UIView performWithoutAnimation:^{
                
                [self.collectionView reloadSections:indexSet];
                
            }];
            
        }
        else if ([response[@"resultCode"]integerValue] == 1001){
            
            [WKProgressHUD popMessage:@"电子市场请求失败" inView:self.view duration:HUD_DURATION animated:YES];
        }
    } fail:^(NSError *error) {
        
    } showHUD:NO];
}

- (void)loadClassifyPopViewDate{
    
    //获取与接口约定的Token
    NSString *apiToken = [KUserDefault objectForKey:APIToken];
    if (apiToken == nil) {
        return;
    }

    NSString *url = [NSString stringWithFormat:@"%@%@%@",BaseTwoApi,HomePageGetClassify_API,apiToken];
    [TNetworking getWithUrl:url params:nil success:^(id response) {
        [NewHomePageClassifyDatas mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"classifyId" : @"id"
                     };
        }];
        NewHomePageClassifyResult *result = [NewHomePageClassifyResult mj_objectWithKeyValues:response];
        if (result.success) {
            self.classifyResultArr = [NSArray array];
            self.classifyResultArr = result.data.datas;
            [self showClassifyPopView];
//            NSIndexSet *indexSet=[[NSIndexSet alloc] initWithIndex:0];
//            [_collectionView reloadSections:indexSet];
        }
    } fail:^(NSError *error) {
        NSLog(@"%ld---%@",(long)error.code,error.localizedDescription);
        NSString *errorStr = error.localizedDescription;
        NSRange rang = [errorStr rangeOfString:@"401"];
        if (rang.location != NSNotFound) {
            //401需要重新请求API Token
            [self loadDateAPIToken];
        }
    } showHUD:NO];
}

#pragma mark -- 加载APIToken数据
- (void)loadDateAPIToken{
    
    //获取与接口约定的Token
    NSMutableDictionary *tempPara = [NSMutableDictionary dictionary];
    [tempPara setObject:@"admin" forKey:@"username"];
    [tempPara setObject:@"admin" forKey:@"password"];
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseTwoApi,accessToken_API];
    NSLog(@"API请求1");
    [TNetworking postWithUrl:url params:tempPara success:^(id response) {
        NSLog(@"API请求2");
        if ([response[@"success"] boolValue]) {
            NSString *theAPIToken = response[@"data"][@"datas"][@"token"];
            [KUserDefault setObject:theAPIToken forKey:APIToken];
            [KUserDefault synchronize];
            [self allLoadDataAPI];
        }
    } fail:^(NSError *error) {
        
    } showHUD:NO];
}
#pragma mark -- 按钮事件
//扫一扫
- (void)scanning{
    
    //    QRcodeViewController *QRvc = [[QRcodeViewController alloc]init];
    //    [self.navigationController pushViewController:QRvc animated:YES];
    
    //    [WKProgressHUD popMessage:@"敬请期待" inView:self.view duration:HUD_DURATION animated:YES];
//    WXPayViewController *vcCtrl = [[WXPayViewController alloc] init];
//    [self.navigationController pushViewController:vcCtrl animated:YES];
    
     QRCodeReaderViewController *reader = [QRCodeReaderViewController new];\
     reader.modalPresentationStyle = UIModalPresentationFormSheet;
     reader.delegate = self;
     
     __weak typeof (self) wSelf = self;
     [reader setCompletionWithBlock:^(NSString *resultAsString) {
     [wSelf.navigationController popViewControllerAnimated:YES];
     [[[UIAlertView alloc] initWithTitle:@"" message:resultAsString delegate:self cancelButtonTitle:@"好的" otherButtonTitles: nil] show];
     }];
     
     //[self presentViewController:reader animated:YES completion:NULL];
     [self.navigationController pushViewController:reader animated:YES];
}

//跳转到搜索页
- (void)SearchButtonPush{
    
    //    SearchViewController *vc = [[SearchViewController alloc]init];
    //
    //    [self.navigationController pushViewController:vc animated:YES];
    
    
    WKWebViewViewController *vc = [[WKWebViewViewController alloc]initWithUrlStr:[NSString stringWithFormat:@"%@%@",BaseApi,HomePageSearch_API] title:@"搜索"];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

//jpush消息
- (void)jPushButton{
    
    MessageCenterViewController *vc = [[MessageCenterViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
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
