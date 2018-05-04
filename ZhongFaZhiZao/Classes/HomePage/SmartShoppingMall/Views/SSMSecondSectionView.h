//
//  SSMSecondSectionView.h
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/14.
//  Copyright © 2018年 中发. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSMResult.h"

typedef void(^SSMSecondSectionViewBlock)(UIButton *button);
@interface SSMSecondSectionView : UIView
{
    UIImageView *_goodsImgImageView;
    UILabel *_goodsNameLabel;
    UILabel *_salesVolumeLabel;
    UILabel *_goodsPriceLabel;
    UIButton *_coverBtn;
}
@property (nonatomic, copy) SSMSecondSectionViewBlock block;
@property (nonatomic, strong) SSMDatasCatesItems *items;
@end
