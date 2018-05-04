//
//  NewHomeSolveResult.h
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/13.
//  Copyright © 2018年 中发. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NewHomeSolveResult,NewHomePageSolveData,NewHomePageSolveDatas,NewHomePageSolution_data;

@interface NewHomeSolveResult : NSObject

@property (nonatomic, assign) NSInteger status;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, assign) BOOL success;
@property (nonatomic, strong) NewHomePageSolveData *data;

@end

@interface NewHomePageSolveData : NSObject

@property (nonatomic, strong) NSArray *datas;

@end

@interface NewHomePageSolveDatas : NSObject

@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *web_store_url;
@property (nonatomic, copy) NSString *main_product;
@property (nonatomic, copy) NSString *city_id;
@property (nonatomic, copy) NSString *solveDatasDescription;
@property (nonatomic, copy) NSString *zip_code;
@property (nonatomic, copy) NSString *tel;
@property (nonatomic, copy) NSString *e_mail;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *logo_url;
@property (nonatomic, copy) NSString *_link;
@property (nonatomic, strong) NSArray *solution_data;

@end

@interface NewHomePageSolution_data : NSObject

@property (nonatomic, copy) NSString *solutionDataId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *solutionDataDescription;
@property (nonatomic, copy) NSString *imageid;
@property (nonatomic, copy) NSString *image_path;
@property (nonatomic, copy) NSString *_link;

@end
