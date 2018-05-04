//
//  CityModel.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/13.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "CityModel.h"

@implementation TheProvince

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"name" : @"v",
             @"city" : @"n"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"city" : [TheCity class]};
}

@end

@implementation TheCity

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"name" : @"v",
             @"town" : @"n"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"town" : [TheTown class]};
}

@end

@implementation TheTown

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"name" : @"v"};
}

@end
