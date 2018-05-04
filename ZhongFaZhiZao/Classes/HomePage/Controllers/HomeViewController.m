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
#import "WXPayViewController.h"
#import "MessageCenterViewController.h"

@interface HomeViewController ()

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
    [self loadadData];
//    [self loadCityData];
    // 初始化子视图
    [self setupSubViews];
    [self setUpNavgationView];
}

- (void)setupSubViews{
//    _collectionView = [[HomePageCollectionView alloc] initWithFrame:CGRectMake( 0, 0, kScreenWidth, kScreenHeight-49)];
    _collectionView = [[NewHomePageCollectionView alloc] initWithFrame:CGRectMake( 0, 0, kScreenWidth, kScreenHeight-49)];
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

#pragma mark-获取数据
#pragma mark - loadData
- (void)loadadData{
    
    [TNetworking postWithUrl:[NSString stringWithFormat:@"%@%@",BaseApi,HomePageadInfo_API] params:nil success:^(id response) {
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

- (void)loadCityData{
    
    [TNetworking postWithUrl:[NSString stringWithFormat:@"%@%@",BaseApi,electronic_API] params:nil success:^(id response) {
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
            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:6];
            
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

#pragma mark -- 按钮事件
//扫一扫
- (void)scanning{
    
    //    QRcodeViewController *QRvc = [[QRcodeViewController alloc]init];
    //    [self.navigationController pushViewController:QRvc animated:YES];
    
    //    [WKProgressHUD popMessage:@"敬请期待" inView:self.view duration:HUD_DURATION animated:YES];
    WXPayViewController *vcCtrl = [[WXPayViewController alloc] init];
    [self.navigationController pushViewController:vcCtrl animated:YES];
    /*
     QRCodeReaderViewController *reader = [QRCodeReaderViewController new];\
     reader.modalPresentationStyle = UIModalPresentationFormSheet;
     reader.delegate = self;
     
     __weak typeof (self) wSelf = self;
     [reader setCompletionWithBlock:^(NSString *resultAsString) {
     [wSelf.navigationController popViewControllerAnimated:YES];
     [[[UIAlertView alloc] initWithTitle:@"" message:resultAsString delegate:self cancelButtonTitle:@"好的" otherButtonTitles: nil] show];
     }];
     
     //[self presentViewController:reader animated:YES completion:NULL];
     [self.navigationController pushViewController:reader animated:YES];*/
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
