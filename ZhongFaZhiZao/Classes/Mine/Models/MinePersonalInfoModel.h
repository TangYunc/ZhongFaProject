//
//  MinePersonalInfoModel.h
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/3/7.
//  Copyright © 2018年 中发. All rights reserved.
//
/*{
    "state": "Y",
    "resultCode": 1000,
    "data": {
        "regTYear": 1,
        "orderCount": {
            "waitpayCount": 0,
            "waitSippingCount": 0,
            "waitReceiptCount": 0,
            "refundCount": 0
        },
        "corpName": "MCEC_16123992",
        "membership": []
    },
    "tip": "成功"
}*/
#import <Foundation/Foundation.h>

@class MinePersonalInfoModel, MinePersonalInfoDatas, MinePersonalInfoOrderCount,MinePersonalInfoMebership;

@interface MinePersonalInfoModel : NSObject

@property (nonatomic, copy) NSString *state;
@property (nonatomic, assign) NSInteger resultCode;
@property (nonatomic, strong) MinePersonalInfoDatas *data;
@property (nonatomic, copy) NSString *tip;

@end

@interface MinePersonalInfoDatas : NSObject

@property (nonatomic, assign) NSInteger regTYear;
@property (nonatomic, copy) NSString *corpName;
@property (nonatomic, strong) MinePersonalInfoOrderCount *orderCount;
@property (nonatomic, copy) NSArray *membership;

@end

@interface MinePersonalInfoOrderCount : NSObject

@property (nonatomic, assign) NSInteger waitpayCount;
@property (nonatomic, assign) NSInteger waitSippingCount;
@property (nonatomic, assign) NSInteger waitReceiptCount;
@property (nonatomic, assign) NSInteger refundCount;

@end

@interface MinePersonalInfoMebership : NSObject


@end
