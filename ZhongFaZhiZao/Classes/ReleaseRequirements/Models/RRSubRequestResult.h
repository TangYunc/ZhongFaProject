//
//  RRSubRequestResult.h
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/17.
//  Copyright © 2018年 中发. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RRSubRequestResult,RRSubRequestData,RRSubRequestDatas,RRSubRequestChild,RRSubRequestSun;

@interface RRSubRequestResult : NSObject

@property (nonatomic, assign) NSInteger status;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, assign) BOOL success;
@property (nonatomic, strong) RRSubRequestData *data;

@end

@interface RRSubRequestData : NSObject

@property (nonatomic, strong) RRSubRequestDatas *datas;

@end

@interface RRSubRequestDatas : NSObject

@property (nonatomic, strong) NSArray *child;
@property (nonatomic, strong) NSArray *sun;

@end

@interface RRSubRequestChild : NSObject

@property (nonatomic, copy) NSString *childId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *level;
@property (nonatomic, copy) NSString *classpath;

@end

@interface RRSubRequestSun : NSObject

@property (nonatomic, copy) NSString *sunId;
@property (nonatomic, copy) NSString *name;

@end
