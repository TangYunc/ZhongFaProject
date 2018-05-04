//
//  CityModel.h
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/13.
//  Copyright © 2018年 中发. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TheProvince,TheCity,TheTown;

@interface TheProvince : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray *city;

@end

@interface TheCity : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray *town;

@end


@interface TheTown : NSObject

@property (nonatomic, copy) NSString *name;

@end
