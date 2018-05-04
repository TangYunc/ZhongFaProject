//
//  RRCustomizedViewController.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/12.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "RRCustomizedViewController.h"
#import "RRCustomizedScrollView.h"
#import "RRRequestResult.h"

@interface RRCustomizedViewController ()<UIScrollViewDelegate>
{
    RRCustomizedScrollView *_customizedScr;
}
@end

@implementation RRCustomizedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F6F6F6"];
    [self setUpSubviews];
    [self loadRecruitsData];
}

- (void)setUpSubviews{
    
    CGFloat customizedScrGapFromTop = 20/2.0 * KWidth_ScaleH;
    _customizedScr = [[RRCustomizedScrollView alloc] initWithFrame:CGRectMake(0, customizedScrGapFromTop, kScreenWidth, kScreenHeight - customizedScrGapFromTop - SafeAreaBottomHeight)];
    _customizedScr.delegate = self;
    _customizedScr.pagingEnabled = NO;
    _customizedScr.bounces = YES;
    _customizedScr.userInteractionEnabled = YES;
    //    _scrollView.showsHorizontalScrollIndicator = NO;
    _customizedScr.contentSize = CGSizeMake(0,1.2 * kScreenHeight);
    [self.view addSubview:_customizedScr];
    
}

#pragma mark -- loadData
- (void)loadRecruitsData{
    
    NSString *apiToken = [KUserDefault objectForKey:APIToken];
    if (apiToken == nil) {
        return;
    }
    
    NSString *url = [NSString stringWithFormat:@"%@%@%@",BaseTwoApi,RRCustomized_API,apiToken];
    [TNetworking getWithUrl:url params:nil success:^(id response) {
        [RRRequestProjectPhase mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"projectPhaseId" : @"id"
                     };
        }];
        [RRRequestProjectType mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"projectTypeId" : @"id"
                     };
        }];
        [RRRequestIndustryCate mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"industryCateId" : @"id"
                     };
        }];
        
        RRRequestResult *result = [RRRequestResult mj_objectWithKeyValues:response];
        if ([result.message isEqualToString:@"OK"]) {
            _customizedScr.datas = result.data.datas;
        }else{
            
            NSLog(@"%@",result.message);
        }
    } fail:^(NSError *error) {
        NSLog(@"error = %@",error);
        
        [WKProgressHUD popMessage:@"请检查网络连接" inView:self.view duration:HUD_DURATION animated:YES];
    } showHUD:NO];
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
