//
//  RRPropertyEditSubview.h
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/12.
//  Copyright © 2018年 中发. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RRPropertyEditSubview : UIView
{
    UILabel *_titleLabel;
    UIImageView *_auxiliaryImageView;
    UIView *_bottomView;
}
@property(nonatomic,copy)NSString *titleStr;
@property(nonatomic,assign)BOOL showAuxiliaryIcon;
@end
