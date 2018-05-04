//
//  RRCustomizedViewController.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/12.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "RRCustomizedViewController.h"
#import "RRCustomizedScrollView.h"

@interface RRCustomizedViewController ()<UIScrollViewDelegate>

@end

@implementation RRCustomizedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F6F6F6"];
    [self setUpSubviews];
}

- (void)setUpSubviews{
    
    CGFloat customizedScrGapFromTop = 20/2.0 * KWidth_ScaleH;
    RRCustomizedScrollView *customizedScr = [[RRCustomizedScrollView alloc] initWithFrame:CGRectMake(0, customizedScrGapFromTop, kScreenWidth, kScreenHeight - customizedScrGapFromTop)];
    customizedScr.delegate = self;
    customizedScr.pagingEnabled = NO;
    customizedScr.bounces = YES;
    customizedScr.userInteractionEnabled = YES;
    //    _scrollView.showsHorizontalScrollIndicator = NO;
    customizedScr.contentSize = CGSizeMake(0,1.2 * kScreenHeight);
    [self.view addSubview:customizedScr];
    
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
