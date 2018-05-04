//
//  SSMResult.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/18.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "SSMResult.h"

@implementation SSMResult

@end

@implementation SSMData

@end


@implementation SSMDatas

+ (NSDictionary *)objectClassInArray{
    return @{@"banner":[SSMDatasBanner class],@"business":[SSMDatasBusiness class],@"good_product":[SSMDatasGoodProduct class],@"cates":[SSMDatasCates class]};
}
@end

@implementation SSMDatasBanner

@end

@implementation SSMDatasBusiness

@end

@implementation SSMDatasGoodProduct

@end

@implementation SSMDatasCates

+ (NSDictionary *)objectClassInArray{
    return @{@"items":[SSMDatasCatesItems class]};
}
    
@end

@implementation SSMDatasCatesItems

@end
