//
//  UserInfo.h
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/3/1.
//  Copyright © 2018年 中发. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

+ (UserInfo *)sharedUserInfo;

@property (nonatomic,copy) NSString *desId;      //用户加密ID
@property (nonatomic,copy) NSString *mob;        //用户手机号
@property (nonatomic,copy) NSString *nickName;   //用户昵称
@property (nonatomic,copy) NSString *photo;      //用户头像
@property (nonatomic,copy) NSString *createDate; //注册时间
@property (nonatomic,copy) NSString *password;   //密码
@property (nonatomic,copy) NSString *uid;        //uid
@property (nonatomic,assign) BOOL isLogin;       //判断是否已登录
@property (nonatomic,copy) NSString *token;      //token
@property (nonatomic,copy) NSString *uname;      //姓名
@property (nonatomic,copy) NSString *contacts;   //联系人
@property (nonatomic,copy) NSString *mobile;     //手机号码
@end
