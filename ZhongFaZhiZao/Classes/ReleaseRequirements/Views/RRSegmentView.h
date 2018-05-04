//
//  RRSegmentView.h
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/12.
//  Copyright © 2018年 中发. All rights reserved.
//
/*
 buttonName: 按钮title
 contrllers:要添加的控制器集合
 parentC:添加的控制器的集合的父类
 defaultIndex:默认显示选中在第几个控制器
 */

#import <UIKit/UIKit.h>

@interface RRSegmentView : UIView<UIScrollViewDelegate>

- (instancetype)initWithFrame:(CGRect)frame buttonName:(NSArray *)buttonName contrllers:(NSArray *)contrllers parentController:(UIViewController *)parentC defaultIndex:(NSInteger)defaultIndex;

- (void)clickDefaultIndex:(NSInteger)index;

@end
