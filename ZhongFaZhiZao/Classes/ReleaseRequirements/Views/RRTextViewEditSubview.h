//
//  RRTextViewEditSubview.h
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/12.
//  Copyright © 2018年 中发. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^RRTextViewEditSubviewBlock)(UIView *currentView,NSString *content);
@interface RRTextViewEditSubview : UIView

@property (nonatomic, copy)RRTextViewEditSubviewBlock block;
@property (nonatomic, copy)NSString *discribStr;
@property (nonatomic, copy)NSString *placeholderStr;
@end
