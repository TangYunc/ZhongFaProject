//
//  ZhongFaDataBase.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/3/2.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "ZhongFaDataBase.h"
#import "FMDB.h"
#define DB_VERSION  1

@implementation ZhongFaDataBase
+ (void)createDataBase{
    
    NSString *path = [NSString stringWithFormat:@"%@/Documents/data.db",NSHomeDirectory()];
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    NSLog(@"path路径====%@",path);
    [database open];
    //        创建db
    NSString *pushSql = PUSH_CREATE_SQL;
    [database executeUpdate:pushSql];
    [database close];
}

+ (void)addPushMessage:(NSDictionary *) pushDic{
    
    NSString *path = [NSString stringWithFormat:@"%@/Documents/data.db",NSHomeDirectory()];
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    BOOL flag =  [database open];
    NSLog(@"%@",@(flag));
    //将userinfo字段插入
    NSString *sql = [NSString stringWithFormat:@"insert into push_data1(url,title,summury,imgurl,date,time) values ('%@','%@','%@','%@','%@','%@')",pushDic[@"URL"],pushDic[@"TITLE"],pushDic[@"SUMMURY"],pushDic[@"IMGURL"],pushDic[@"DATE"],pushDic[@"TIME"]];
    BOOL insert = [database executeUpdate:sql];
    NSLog(@"%@",@(insert));
    //    BOOL insert =     [database executeUpdate:@"insert into push_data  （url,title,summury,imgurl,date） values(?,?,?,?,?)",pushDic[@"URL"],pushDic[@"TITLE"],pushDic[@"SUMMURY"],pushDic[@"IMGURL"],pushDic[@"DATE"]];
    
    //    BOOL insert = [database executeUpdate:@"insert into push_data (url) value (1)"];
    [database close];
}

+ (NSMutableArray *)getPushMessage {
    
    NSString *path = [NSString stringWithFormat:@"%@/Documents/data.db",NSHomeDirectory()];
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    FMResultSet *result = [database executeQuery:@"select * from push_data1 order by time desc"];
    NSMutableArray *array = [NSMutableArray array];
    while ([result next]) {
        NSMutableDictionary *dic = [NSMutableDictionary new];
        NSString *url = [result stringForColumn:@"url"] ? [result stringForColumn:@"url"] : @"";
        NSString *title = [result stringForColumn:@"title"] ? [result stringForColumn:@"title"] :@"";
        NSString *summury = [result stringForColumn:@"summury"] ?[result stringForColumn:@"summury"] :@"";
        NSString *imgurl = [result stringForColumn:@"imgurl"] ?[result stringForColumn:@"imgurl"] :@"";
        NSString *date = [result stringForColumn:@"date"] ? [result stringForColumn:@"date"] :@"";
      
        [dic setObject:url forKey:@"url"];
        [dic setObject:title forKey:@"title"];
        [dic setObject:summury forKey:@"summury"];
        [dic setObject:imgurl forKey:@"imgurl"];
        [dic setObject:date forKey:@"date"];
        [array addObject:dic];
    }
    [database close];
    return array;
}
@end
