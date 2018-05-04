//
//  RRRequestResult.h
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/17.
//  Copyright © 2018年 中发. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RRRequestResult,RRRequestData,RRRequestDatas,RRRequestProjectPhase,RRRequestProjectType,RRRequestIndustryCate;

@interface RRRequestResult : NSObject

@property (nonatomic, assign) NSInteger status;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, assign) BOOL success;
@property (nonatomic, strong) RRRequestData *data;
@end

@interface RRRequestData : NSObject

@property (nonatomic, strong) RRRequestDatas *datas;

@end

@interface RRRequestDatas : NSObject

@property (nonatomic, strong) NSArray *project_phase;
@property (nonatomic, strong) NSArray *project_type;
@property (nonatomic, strong) NSArray *industry_cate;

@end

@interface RRRequestProjectPhase : NSObject

@property (nonatomic, copy) NSString *projectPhaseId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *level;
@property (nonatomic, copy) NSString *classpath;

@end

@interface RRRequestProjectType : NSObject

@property (nonatomic, copy) NSString *projectTypeId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *level;
@property (nonatomic, copy) NSString *classpath;

@end

@interface RRRequestIndustryCate : NSObject

@property (nonatomic, copy) NSString *industryCateId;
@property (nonatomic, copy) NSString *name;

@end
