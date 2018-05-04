//
//  ArchiverAndUnArchiver.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/3/15.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "ArchiverAndUnArchiver.h"
#import <objc/runtime.h>

@implementation ArchiverAndUnArchiver

- (void)encodeWithCoder:(NSCoder *)aCoder{
    //归档
    //属性的个数
    unsigned int count = 0;
    //指向第一个ivar的指针（获取成员属性列表）
    Ivar *ivars =  class_copyIvarList([self class], &count);
    
    for (int i = 0; i < count; i++) {
        //遍历，获得成员变量ivar
        Ivar ivar = ivars[i];
        //获得属性名称
        const char *name = ivar_getName(ivar);
        //转化为OC字符串 属性的名称
        NSString *key = [NSString stringWithUTF8String:name];
        //通过KVC获取   属性的值
        id value = [self valueForKey:key];
        //归档
        [aCoder encodeObject:value forKey:key];
    }
    //释放,class_copyIvarList开辟了一块堆区域，需要我们自己管理内存，否则会出现内存泄漏，然后这里不是OC对象，因此ARC不进行释放管理
    free(ivars);
}


- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList([self class], &count);
        for (int i = 0; i < count; i++) {
            Ivar ivar = ivars[i];
            const char *name = ivar_getName(ivar);
            NSString *key = [NSString stringWithUTF8String:name];
            //解档
            id value = [aDecoder decodeObjectForKey:key];
            //通过KVC赋值到对象上
            [self setValue:value forKey:key];
        }
        free(ivars);
    }
    return self;
}
@end
