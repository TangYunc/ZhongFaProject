//
//  RRSubRequestResult.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/17.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "RRSubRequestResult.h"

@implementation RRSubRequestResult

@end

@implementation RRSubRequestData

@end


@implementation RRSubRequestDatas

+ (NSDictionary *)objectClassInArray{
    return @{@"child":[RRSubRequestChild class],@"sun":[RRSubRequestSun class]};
}
@end

@implementation RRSubRequestChild

@end

@implementation RRSubRequestSun

@end
