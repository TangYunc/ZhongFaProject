//
//  SSMTableResult.h
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/19.
//  Copyright © 2018年 中发. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SSMTableResult,SSMTableData,SSMTableDatas,SSMTableLocation,SSMTableBrand,SSMTableItems,SSMTablePage;

@interface SSMTableResult : NSObject

@property (nonatomic, assign) NSInteger status;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, assign) BOOL success;
@property (nonatomic, strong) SSMTableData *data;

@end

@interface SSMTableData : NSObject

@property (nonatomic, strong) SSMTableDatas *datas;

@end

@interface SSMTableDatas : NSObject

@property (nonatomic, strong) NSArray *location;
@property (nonatomic, strong) NSArray *brand;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) SSMTablePage *page;

@end

@interface SSMTableLocation : NSObject

@property (nonatomic, copy) NSString *firstLocation;
@property (nonatomic, copy) NSString *secondLocation;

@end

@interface SSMTableBrand : NSObject

@property (nonatomic, copy) NSString *tableBrandId;
@property (nonatomic, copy) NSString *name;

@end

@interface SSMTableItems : NSObject

@property (nonatomic, copy) NSString *tableItemsId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *brand_id;
@property (nonatomic, copy) NSString *city_id;
@property (nonatomic, copy) NSString *supply_corp_id;
@property (nonatomic, copy) NSString *imageid;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSString *corp_id;
@property (nonatomic, copy) NSString *classid;
@property (nonatomic, copy) NSString *corp_name;
@property (nonatomic, copy) NSString *image_path;

@end

@interface SSMTablePage : NSObject

@property (nonatomic, strong) NSNumber *totalCount;
@property (nonatomic, strong) NSNumber *pageCount;
@property (nonatomic, strong) NSNumber *currentPage;
@property (nonatomic, strong) NSNumber *perPage;

@end
