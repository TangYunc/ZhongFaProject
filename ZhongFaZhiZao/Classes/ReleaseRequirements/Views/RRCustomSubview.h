//
//  RRCustomSubview.h
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/12.
//  Copyright © 2018年 中发. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^RRCustomSubviewClock)(UIButton *btn,NSString *phoneNum,NSString *userName,NSString *vfCodeStr);

@interface RRCustomSubview : UIView

@property (nonatomic,copy) RRCustomSubviewClock block;
@end
