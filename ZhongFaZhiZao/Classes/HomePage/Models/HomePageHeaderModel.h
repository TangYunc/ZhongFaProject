//
//  HomePageHeaderModel.h
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/3/6.
//  Copyright © 2018年 中发. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HomePageHeaderModel, HomePageHeaderDatas, HomePageHeaderAd41Infos,HomePageHeaderAd44Infos;

@interface HomePageHeaderModel : NSObject

@property (nonatomic, copy) NSString *state;
@property (nonatomic, assign) NSInteger resultCode;
//@property (nonatomic, assign) BOOL succ;
@property (nonatomic, strong) HomePageHeaderDatas *data;
@property (nonatomic, copy) NSString *tip;

@end

@interface HomePageHeaderDatas : NSObject

@property (nonatomic, strong) NSArray *ad_id_41;
@property (nonatomic, strong) NSArray *ad_id_44;

@end

@interface HomePageHeaderAd41Infos : NSObject

@property (nonatomic, copy) NSString *txt;
@property (nonatomic, copy) NSString *img_path;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *target;

@end

@interface HomePageHeaderAd44Infos : NSObject

@property (nonatomic, copy) NSString *txt;
@property (nonatomic, copy) NSString *img_path;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *target;

@end
