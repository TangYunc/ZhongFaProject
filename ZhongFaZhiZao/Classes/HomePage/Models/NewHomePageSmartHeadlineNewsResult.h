//
//  NewHomePageSmartHeadlineNewsResult.h
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/11.
//  Copyright © 2018年 中发. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NewHomePageSmartHeadlineNewsResult,NewHomePageSmartHeadlineNewsData,NewHomePageSmartHeadlineNewsDatas;

@interface NewHomePageSmartHeadlineNewsResult : NSObject

@property (nonatomic, assign) NSInteger status;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, assign) BOOL success;
@property (nonatomic, strong) NewHomePageSmartHeadlineNewsData *data;

@end

@interface NewHomePageSmartHeadlineNewsData : NSObject

@property (nonatomic, strong) NSArray *datas;

@end

@interface NewHomePageSmartHeadlineNewsDatas : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *url;

@end
