//
//  SSMFiltrateCellResult.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/16.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "SSMFiltrateCellResult.h"
#import "SSMFiltrateCell.h"

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
/*
//惰性初始化是这样写的
-(CGFloat)cellHeight
{
    //只在初始化的时候调用一次就Ok
    if(!_cellHeight){
        SSMFiltrateCell *cell = [[SSMFiltrateCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SSMFiltrateCell"];
        NSLog(@"我要计算高度");
        // 调用cell的方法计算出高度
        _cellHeight=[cell rowHeightWithSSMFiltrateCellResult:self];
        
    }
    return _cellHeight;
}
 */
@end
