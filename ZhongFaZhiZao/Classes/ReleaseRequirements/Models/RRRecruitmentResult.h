//
//  RRRecruitmentResult.h
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/17.
//  Copyright © 2018年 中发. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RRRecruitmentResult,RRRecruitmentData,RRRecruitmentDatas,RRRecruitmentCooperationList,RRRecruitmentProvinceList,RRRecruitmentIndustryCate;

@interface RRRecruitmentResult : NSObject

@property (nonatomic, assign) NSInteger status;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, assign) BOOL success;
@property (nonatomic, strong) RRRecruitmentData *data;

@end

@interface RRRecruitmentData : NSObject

@property (nonatomic, strong) RRRecruitmentDatas *datas;

@end

@interface RRRecruitmentDatas : NSObject

@property (nonatomic, strong) NSArray *industry_cate;
@property (nonatomic, strong) RRRecruitmentCooperationList *cooperation_list;
@property (nonatomic, strong) NSArray *province_list;

@end

@interface RRRecruitmentCooperationList : NSObject


@property (nonatomic, copy) NSString *one;
@property (nonatomic, copy) NSString *two;
@property (nonatomic, copy) NSString *three;
@property (nonatomic, copy) NSString *four;

@end

@interface RRRecruitmentProvinceList : NSObject

@property (nonatomic, copy) NSString *provinceListId;
@property (nonatomic, copy) NSString *name;

@end

@interface RRRecruitmentIndustryCate : NSObject

@property (nonatomic, copy) NSString *industryCateId;
@property (nonatomic, copy) NSString *name;

@end
