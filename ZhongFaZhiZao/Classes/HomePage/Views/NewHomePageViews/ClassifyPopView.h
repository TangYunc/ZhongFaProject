//
//  ClassifyPopView.h
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/10.
//  Copyright © 2018年 中发. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassifyPopView : UIView
{
    UIView *_maskView;                 // 遮罩视图
    UIView *_bjView;
}

@property(nonatomic,strong)UIViewController *alertVC;
@end
