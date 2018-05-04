//
//  ScrollPickView.h
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/13.
//  Copyright © 2018年 中发. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ScrollPickViewBlock)(NSInteger selectedValue);

@interface ScrollPickView : UIView

@property (strong, nonatomic) ScrollPickViewBlock confirmBlock;


/**
 布局
 
 @param questionArray 问题数组
 @return self
 */
- (instancetype)initWithQuestionArray:(NSArray *)questionArray withDefaultDesc:(NSString *)defaultDesc;


- (void)showView;

@end
