//
//  RRAgencyResult.h
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/17.
//  Copyright © 2018年 中发. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RRAgencyResult,RRAgencyData,RRAgencyDatas,RRAgencyCooperationList,RRAgencyInvestmentPriceType,RRAgencyIndustryCate;

@interface RRAgencyResult : NSObject

@property (nonatomic, assign) NSInteger status;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, assign) BOOL success;
@property (nonatomic, strong) RRAgencyData *data;

@end

@interface RRAgencyData : NSObject

@property (nonatomic, strong) RRAgencyDatas *datas;

@end

@interface RRAgencyDatas : NSObject

@property (nonatomic, strong) NSArray *industry_cate;
@property (nonatomic, strong) RRAgencyCooperationList *cooperation_list;
@property (nonatomic, strong) NSArray *investment_price_type;

@end

@interface RRAgencyCooperationList : NSObject


@property (nonatomic, copy) NSString *one;
@property (nonatomic, copy) NSString *two;
@property (nonatomic, copy) NSString *three;
@property (nonatomic, copy) NSString *four;

@end

@interface RRAgencyInvestmentPriceType : NSObject

@property (nonatomic, copy) NSString *investmentPriceTypeId;
@property (nonatomic, copy) NSString *name;

@end

@interface RRAgencyIndustryCate : NSObject

@property (nonatomic, copy) NSString *industryCateId;
@property (nonatomic, copy) NSString *name;

@end
