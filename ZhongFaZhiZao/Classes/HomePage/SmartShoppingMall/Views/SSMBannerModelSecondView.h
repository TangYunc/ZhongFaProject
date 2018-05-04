//
//  SSMBannerModelSecondView.h
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/19.
//  Copyright © 2018年 中发. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSMResult.h"

@interface SSMBannerModelSecondView : UIView
{
    UIImageView *_bjImageView;
    UILabel *_goodsNameLabel;
    UILabel *_goodsPriceLabel;
    UIImageView *_goodsImgImageView;
    UILabel *_purchaseLabel;
    UIButton *_coverBtn;
}

@property (nonatomic, strong) SSMDatasGoodProduct *items;
@property (nonatomic, copy) NSString *itemBJImageName;

@end
