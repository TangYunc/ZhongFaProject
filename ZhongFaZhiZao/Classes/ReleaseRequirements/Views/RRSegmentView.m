//
//  RRSegmentView.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/12.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "RRSegmentView.h"

@interface RRSegmentView ()
{
    NSArray *_itemTitles;
}
@property (nonatomic, strong) NSArray *buttonName;
@property (nonatomic, strong) UILabel *underLine;
@property (nonatomic, strong) UIButton *selectButton;
@property (nonatomic, strong) NSArray *controllers;
@property (nonatomic, strong) UIView *segmentView;
@property (nonatomic, strong) UIScrollView *segmentScrollV;
@end

@implementation RRSegmentView

- (instancetype)initWithFrame:(CGRect)frame buttonName:(NSArray *)buttonName contrllers:(NSArray *)contrllers parentController:(UIViewController *)parentC defaultIndex:(NSInteger)defaultIndex{
    
    if (self = [super initWithFrame:frame]) {
        
        self.buttonName = buttonName;
        self.controllers = contrllers;
        _itemTitles = buttonName;
        // 创建segementView
        
        CGFloat segmentViewHeight = 86/2.0 * KWidth_ScaleH;
        self.segmentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, segmentViewHeight)];
        self.segmentView.tag = 50;
        [self addSubview:self.segmentView];
        
        
        //  创建segmentScrollV
        
        self.segmentScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, segmentViewHeight, kScreenWidth, frame.size.height - segmentViewHeight)];
        self.segmentScrollV.contentSize = CGSizeMake(kScreenWidth * self.controllers.count, 0);
        self.segmentScrollV.showsHorizontalScrollIndicator = NO;
        self.segmentScrollV.pagingEnabled = YES;
        self.segmentScrollV.bounces = NO;
        self.segmentScrollV.delegate = self;
        [self addSubview:self.segmentScrollV];
        
        // 创建ViewController并添加到segmentScrollV
        
        for (int i = 0; i < self.controllers.count; i++) {
            
            UIViewController *contro = self.controllers[i];
            contro.view.frame = CGRectMake(i * kScreenWidth, 0, kScreenWidth, frame.size.height);
            [self.segmentScrollV addSubview:contro.view];
            [parentC addChildViewController:contro];
            [contro didMoveToParentViewController:parentC];
            
        }
        
        
        // 创建segmentButton 和 line
        NSInteger tempCount = self.controllers.count;
        for (NSInteger i = 0; i < tempCount; i++) {
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(i * (kScreenWidth / tempCount), 0, kScreenWidth / tempCount, segmentViewHeight);
            button.tag = i;
            [button setTitle:self.buttonName[i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor colorWithHexString:@"#4A4A4A"] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor colorWithHexString:@"#31B3EF"] forState:UIControlStateSelected];
            [button setBackgroundColor:[UIColor whiteColor]];
            [button addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
            button.titleLabel.font = [UIFont systemFontOfSize:16 * KWidth_ScaleW];
            if (i == defaultIndex) {
                
                button.selected = YES;
                self.selectButton = button;
            }else {
                
                button.selected = NO;
            }
            [self.segmentView addSubview:button];
        }
        CGFloat lineViewHeight = 4/2.0 * KWidth_ScaleH;
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, segmentViewHeight - lineViewHeight, kScreenWidth, lineViewHeight)];
        lineView.backgroundColor = [UIColor whiteColor];
        [self.segmentView addSubview:lineView];
        // 添加下划线
        self.underLine = [[UILabel alloc] initWithFrame:CGRectMake(self.selectButton.tag * (kScreenWidth / tempCount), lineView.top, kScreenWidth / tempCount, lineViewHeight)];
        
        self.underLine.backgroundColor = [UIColor colorWithHexString:@"#31B3EF"];
        self.underLine.layer.cornerRadius = 1;
        self.underLine.tag = 70;
        [self.segmentView addSubview:self.underLine];
        
    }
    
    return self;
}

- (void)Click:(UIButton *)sender {
    
    self.selectButton.titleLabel.font = [UIFont systemFontOfSize:16 * KWidth_ScaleW];
    self.selectButton.selected = NO;
    self.selectButton = sender;
    self.selectButton.selected = YES;
    //    self.selectButton.titleLabel.font = [UIFont systemFontOfSize:16*KWidth_ScaleW];
    [UIView animateWithDuration:0.2 animations:^{
        
        CGPoint frame = self.underLine.center;
        frame.x = kScreenWidth / (self.controllers.count * 2) + (kScreenWidth / self.controllers.count) * (sender.tag);
        self.underLine.center = frame;
        
    }];
    
    [self.segmentScrollV setContentOffset:CGPointMake((sender.tag) * kScreenWidth, 0) animated:YES];
    
    
    
}

#pragma mark  UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [UIView animateWithDuration:0.2 animations:^{
        
        CGPoint frame = self.underLine.center;
        frame.x = kScreenWidth / (self.controllers.count * 2) + (kScreenWidth / self.controllers.count) * (self.segmentScrollV.contentOffset.x/kScreenWidth);
        self.underLine.center = frame;
        
    }];
    
    UIButton *button = (UIButton *)[self.segmentView viewWithTag:self.segmentScrollV.contentOffset.x / kScreenWidth];
    //    self.selectButton.titleLabel.font = [UIFont systemFontOfSize:14*KWidth_ScaleW];
    self.selectButton.selected = NO;
    self.selectButton = button;
    self.selectButton.selected = YES;
    self.selectButton.titleLabel.font = [UIFont systemFontOfSize:16*KWidth_ScaleW];
    
}

- (void)clickDefaultIndex:(NSInteger)index {
    if (_itemTitles.count == 0) {
        return ;
    }
    [self Click:(UIButton *)[self viewWithTag:index]];
}

@end
