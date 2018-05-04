//
//  NewHomePageSmartShoppingMallResult.h
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/13.
//  Copyright © 2018年 中发. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NewHomePageSmartShoppingMallResult,NewHomePageSmartShoppingMallData,NewHomePageSmartShoppingMallData,NewHomePageSmartShoppingMallDatas;

@interface NewHomePageSmartShoppingMallResult : NSObject

@property (nonatomic, assign) NSInteger status;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, assign) BOOL success;
@property (nonatomic, strong) NewHomePageSmartShoppingMallData *data;

@end

@interface NewHomePageSmartShoppingMallData : NSObject

@property (nonatomic, strong) NSArray *datas;

@end

@interface NewHomePageSmartShoppingMallDatas : NSObject

@property (nonatomic, copy) NSString *smartMallId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray *ad_list;

@end

@interface NewHomePageSmartShoppingMallAd_list : NSObject

@property (nonatomic, copy) NSString *adListId;
@property (nonatomic, copy) NSString *ads_id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *click_link;
@property (nonatomic, copy) NSString *click_link_target;
@property (nonatomic, copy) NSString *res_source_type;
@property (nonatomic, copy) NSString *res_path;
@property (nonatomic, copy) NSString *res_desc;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *_link;

@end
