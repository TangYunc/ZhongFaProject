//
//  UIView+TYCViewController.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/3/1.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "UIView+TYCViewController.h"

@implementation UIView (TYCViewController)

// 获取视图所在的视图控制器
- (UIViewController *)viewControler
{
    // 1.获取当前视图的下一响应者
    UIResponder *responder = self.nextResponder;
    
    // 2.判断当前对象是否是视图控制器
    while (YES) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        } else {
            responder = responder.nextResponder;
            if (responder == nil) {
                return nil;
            }
        }
    }
}
@end
