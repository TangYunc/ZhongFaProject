//
//  ChooseLocationView.h
//  ChooseLocation
//
//  Created by Sekorm on 16/8/22.
//  Copyright © 2016年 HY. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef void(^ChooseLocationViewCompletedBlock)(NSArray *citys);

@interface ChooseLocationView : UIView

@property (nonatomic, copy) NSString * address;
@property (nonatomic, copy) NSString * provinceId;
@property (nonatomic, copy) NSString * cityId;
@property (nonatomic, strong) NSArray *theProvinceDatas;
@property (nonatomic, copy) void(^chooseFinish)(void);

//- (NSArray *)loadCityDataOnCurrentProvince:(NSString *)provinceId completedBlock:(ChooseLocationViewCompletedBlock)completedBlock;
@end
