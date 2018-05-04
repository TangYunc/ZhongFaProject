//
//  ArchiverAndUnArchiver.h
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/3/15.
//  Copyright © 2018年 中发. All rights reserved.
//
/**
 提示：但凡在C函数中，看到参数需要传递 基本数据类型指针！！！一般需要在函数内部修改形参的值
 堆：放的是数据本身
 在C里面，看见new，create，copy。一般都会在对区域开辟空间
 */

/**
 1.归档自定义对象
 NSString *rootPath = NSTemporaryDirectory();
 NSString *filePath = [rootPath stringByAppendingPathComponent:@"file.date"];
 id personInfo = nil;
 [NSKeyedArchiver archiveRootObject:personInfo toFile:rootPath];
 2.解档自定义对象
 PersonInfo *personInfo = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
 */


#import <Foundation/Foundation.h>

@interface ArchiverAndUnArchiver : NSObject<NSCoding>

@end
