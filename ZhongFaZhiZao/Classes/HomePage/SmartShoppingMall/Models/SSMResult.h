//
//  SSMResult.h
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/18.
//  Copyright © 2018年 中发. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SSMResult,SSMData,SSMDatas,SSMDatasBanner,SSMDatasBusiness,SSMDatasGoodProduct,SSMDatasCates,SSMDatasCatesItems;

@interface SSMResult : NSObject

@property (nonatomic, assign) NSInteger status;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, assign) BOOL success;
@property (nonatomic, strong) SSMData *data;

@end

@interface SSMData : NSObject

@property (nonatomic, strong) SSMDatas *datas;

@end

@interface SSMDatas : NSObject

@property (nonatomic, strong) NSArray *banner;
@property (nonatomic, strong) NSArray *business;
@property (nonatomic, strong) NSArray *good_product;
@property (nonatomic, strong) NSArray *cates;

@end

@interface SSMDatasBanner : NSObject

@property (nonatomic, copy) NSString *bannerId;
@property (nonatomic, copy) NSString *ads_id;
@property (nonatomic, copy) NSString *click_link;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *res_path;
@property (nonatomic, copy) NSString *res_desc;
@property (nonatomic, copy) NSString *bannerDescription;

@end

@interface SSMDatasBusiness : NSObject

@property (nonatomic, copy) NSString *businessId;
@property (nonatomic, copy) NSString *ads_id;
@property (nonatomic, copy) NSString *click_link;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *res_path;
@property (nonatomic, copy) NSString *res_desc;
@property (nonatomic, copy) NSString *businessDescription;

@end

@interface SSMDatasGoodProduct : NSObject

@property (nonatomic, copy) NSString *goodProductId;
@property (nonatomic, copy) NSString *ads_id;
@property (nonatomic, copy) NSString *click_link;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *res_path;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *sales_volume;

@end

@interface SSMDatasCates : NSObject

@property (nonatomic, copy) NSString *cate_name;
@property (nonatomic, copy) NSString *cate_id;
@property (nonatomic, strong) NSArray *items;

@end

@interface SSMDatasCatesItems : NSObject

@property (nonatomic, copy) NSString *catesItemId;
@property (nonatomic, copy) NSString *ads_id;
@property (nonatomic, copy) NSString *click_link;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *res_path;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *sales_volume;

@end


