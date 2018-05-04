//
//  ZhongFaDataBase.h
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/3/2.
//  Copyright © 2018年 中发. All rights reserved.
//

#import <Foundation/Foundation.h>

#define PUSH_CREATE_SQL     \
@"CREATE TABLE push_data1( url TEXT,title TEXT,summury TEXT,imgurl TEXT,date TEXT,time long )"
//    @"CREATE TABLE push_data( url TEXT,title TEXT,summury TEXT,imgurl TEXT,date TEXT)"

@interface ZhongFaDataBase : NSObject

+ (void)createDataBase;

+ (void)addPushMessage:(NSDictionary *) pushDic;

+ (NSMutableArray *)getPushMessage;

@end
