//
//  ScienceResultFuctionView.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/9.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "ScienceResultFuctionView.h"
#import "ScienceResultCustomFounctionBtn.h"

@implementation ScienceResultFuctionView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor cyanColor];
        [self setUpSubViews];
    }
    return self;
}

- (void)setUpSubViews{
    NSArray *titles = @[@"评估评价",@"专利申请",@"商标注册",@"项目申报",@"高新认定"];
    NSArray *imageNames = @[@"NewHomePageEnvaluationIcon",@"NewHomePageApplyIcon",@"NewHomePageTrademarkRegistrationIcon",@"NewHomePageProjectApplicationIcon",@"NewHomePageHighRecognitionIcon"];
    NSInteger temptCount = titles.count;
    CGFloat itemWidth = KWidth_ScaleW / temptCount;
    CGFloat itemHeight = 153/2.0 * KWidth_ScaleH;
    for (NSInteger i = 0; i < temptCount; i++) {
        ScienceResultCustomFounctionBtn *customBtn = [[ScienceResultCustomFounctionBtn alloc] initWithFrame:CGRectMake(i * itemWidth, 0, itemWidth, itemHeight)];
        // 设置标题
        [customBtn setTitle:titles[i]];
        // 设置图片
        [customBtn setTitleImage:[UIImage imageNamed:imageNames[i]]];
        // 设置事件
        customBtn.tag =  10 + i;
        [customBtn addTarget:self action:@selector(customBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:customBtn];
    }
    _gapLineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 0.5, kScreenWidth, 0.5)];
    _gapLineView.backgroundColor = UIColorFromRGBA(245, 245, 245, 1.0);
    [self addSubview:_gapLineView];
}

#pragma mark -- 按钮事件
- (void)customBtnAction:(UIButton *)button{
    
    if (button.tag == 10) {
        NSLog(@"点击的是评估评价");
    }else if (button.tag == 11){
        NSLog(@"点击的是专利申请");
    }else if (button.tag == 12){
        NSLog(@"点击的是商标注册");
    }else if (button.tag == 13){
        NSLog(@"点击的是项目申请");
    }else{
        NSLog(@"点击的是高新认定");
    }
}

@end
