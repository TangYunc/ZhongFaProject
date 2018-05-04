//
//  SSMClassifyResult.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/19.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "SSMClassifyResult.h"

@implementation SSMClassifyResult

@end

@implementation SSMClassifyData

+ (NSDictionary *)objectClassInArray{
    return @{@"datas":[SSMClassifyDatas class]};
}

@end


@implementation SSMClassifyDatas

+ (NSDictionary *)objectClassInArray{
    return @{@"subclass":[SSMClassifySubclass class]};
}

@end

@implementation SSMClassifySubclass

@end

