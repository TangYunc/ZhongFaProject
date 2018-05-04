//
//  SSMFiltrateCellResult.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/16.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "SSMFiltrateCellResult.h"

@implementation SSMFiltrateCellResult

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
+ (SSMFiltrateCellResult *)shareService{
    
    static SSMFiltrateCellResult *shareService = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareService = [[self alloc] init];
    });
    
    return shareService;
}

@end
