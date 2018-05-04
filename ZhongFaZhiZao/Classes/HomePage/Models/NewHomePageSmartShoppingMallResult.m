//
//  NewHomePageSmartShoppingMallResult.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/13.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "NewHomePageSmartShoppingMallResult.h"


@implementation NewHomePageSmartShoppingMallResult

@end

@implementation NewHomePageSmartShoppingMallData

+ (NSDictionary *)objectClassInArray{
    return @{@"datas":[NewHomePageSmartShoppingMallDatas class]};
}
@end


@implementation NewHomePageSmartShoppingMallDatas

+ (NSDictionary *)objectClassInArray{
    return @{@"ad_list":[NewHomePageSmartShoppingMallAd_list class]};
}
@end

@implementation NewHomePageSmartShoppingMallAd_list

@end
