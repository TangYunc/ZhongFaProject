//
//  NewHomeSolveResult.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/13.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "NewHomeSolveResult.h"

@implementation NewHomeSolveResult

@end

@implementation NewHomePageSolveData

+ (NSDictionary *)objectClassInArray{
    return @{@"datas":[NewHomePageSolveDatas class]};
}
@end


@implementation NewHomePageSolveDatas

+ (NSDictionary *)objectClassInArray{
    return @{@"solution_data":[NewHomePageSolution_data class]};
}
@end

@implementation NewHomePageSolution_data

@end
