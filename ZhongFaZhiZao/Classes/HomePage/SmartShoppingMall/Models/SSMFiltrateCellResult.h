//
//  SSMFiltrateCellResult.h
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/16.
//  Copyright © 2018年 中发. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSMFiltrateCellResult : NSObject

@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSString *brandId;

@property (nonatomic, copy) NSString *minPrice;
@property (nonatomic, copy) NSString *maxPrice;

+ (SSMFiltrateCellResult *)shareService;
@end
