//
//  SSMClassifyResult.h
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/19.
//  Copyright © 2018年 中发. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SSMClassifyResult,SSMClassifyData,SSMClassifyDatas,SSMClassifySubclass;

@interface SSMClassifyResult : NSObject

@property (nonatomic, assign) NSInteger status;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, assign) BOOL success;
@property (nonatomic, strong) SSMClassifyData *data;

@end

@interface SSMClassifyData : NSObject

@property (nonatomic, strong) NSArray *datas;

@end

@interface SSMClassifyDatas : NSObject

@property (nonatomic, copy) NSString *classifyId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray *subclass;

@end

@interface SSMClassifySubclass : NSObject

@property (nonatomic, copy) NSString *classifySubclassId;
@property (nonatomic, copy) NSString *name;

@end

