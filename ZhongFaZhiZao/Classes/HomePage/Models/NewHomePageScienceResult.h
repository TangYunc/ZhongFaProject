//
//  NewHomePageScienceResult.h
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/13.
//  Copyright © 2018年 中发. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NewHomePageScienceResult,NewHomePageScienceResultData,NewHomePageScienceResultDatas;

@interface NewHomePageScienceResult : NSObject

@property (nonatomic, assign) NSInteger status;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, assign) BOOL success;
@property (nonatomic, strong) NewHomePageScienceResultData *data;

@end

@interface NewHomePageScienceResultData : NSObject

@property (nonatomic, strong) NSArray *datas;

@end

@interface NewHomePageScienceResultDatas : NSObject

@property (nonatomic, copy) NSString *scienceResultId;
@property (nonatomic, copy) NSString *product_name;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *corp_city_name;
@property (nonatomic, copy) NSString *recommend_source;
@property (nonatomic, copy) NSString *label;
@property (nonatomic, copy) NSString *_link;

@end
