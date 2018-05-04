//
//  NewHomePageClassifyResult.h
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/11.
//  Copyright © 2018年 中发. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NewHomePageClassifyResult,NewHomePageClassifyData,NewHomePageClassifyDatas;

@interface NewHomePageClassifyResult : NSObject

@property (nonatomic, assign) NSInteger status;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, assign) BOOL success;
@property (nonatomic, strong) NewHomePageClassifyData *data;

@end

@interface NewHomePageClassifyData : NSObject

@property (nonatomic, strong) NSArray *datas;

@end

@interface NewHomePageClassifyDatas : NSObject

@property (nonatomic, copy) NSString *classifyId;
@property (nonatomic, copy) NSString *name;

@end

