//
//  UserInfo.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/3/1.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

+ (UserInfo *)sharedUserInfo {
    
    static UserInfo *userInfo = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        userInfo = [[UserInfo alloc]init];
        
        userInfo.isLogin = NO;
        
    });
    
    return userInfo;
}
@end
