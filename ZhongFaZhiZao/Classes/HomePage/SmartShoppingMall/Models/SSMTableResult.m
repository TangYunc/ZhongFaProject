//
//  SSMTableResult.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/19.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "SSMTableResult.h"

@implementation SSMTableResult

@end

@implementation SSMTableData


@end


@implementation SSMTableDatas

+ (NSDictionary *)objectClassInArray{
    return @{@"location":[SSMTableLocation class],@"brand":[SSMTableBrand class],@"items":[SSMTableItems class]};
}

@end

@implementation SSMTableLocation

@end

@implementation SSMTableBrand

@end

@implementation SSMTableItems

@end

@implementation SSMTablePage

@end
