//
//  NewHomePageADResult.h
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/11.
//  Copyright © 2018年 中发. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NewHomePageADResult,NewHomePageADData,NewHomePageADDatas;

@interface NewHomePageADResult : NSObject

@property (nonatomic, assign) NSInteger status;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, assign) BOOL success;
@property (nonatomic, strong) NewHomePageADData *data;

@end

@interface NewHomePageADData : NSObject

@property (nonatomic, strong) NSArray *datas;

@end

@interface NewHomePageADDatas : NSObject

@property (nonatomic, assign) NSInteger adId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *click_link;
@property (nonatomic, copy) NSString *res_path;
@property (nonatomic, copy) NSString *res_desc;
@property (nonatomic, copy) NSString *adDescription;

@end
