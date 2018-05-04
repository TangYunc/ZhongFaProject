//
//  RRRequestResult.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/17.
//  Copyright © 2018年 中发. All rights reserved.
//
//RRRequestResult,,,,,;
#import "RRRequestResult.h"

@implementation RRRequestResult

@end

@implementation RRRequestData

@end


@implementation RRRequestDatas

+ (NSDictionary *)objectClassInArray{
    return @{@"project_phase":[RRRequestProjectPhase class],@"project_type":[RRRequestProjectType class],@"industry_cate":[RRRequestIndustryCate class]};
}
@end

@implementation RRRequestProjectPhase

@end

@implementation RRRequestProjectType

@end

@implementation RRRequestIndustryCate

@end
