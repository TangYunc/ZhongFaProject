//
//  SexPickView.h
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/13.
//  Copyright © 2018年 中发. All rights reserved.
//
/**
 SexPickView *sheetView = [[SexPickView alloc] initWithTitle:@"性别修改" buttons:@[@"男",@"女",@"取消"] buttonClick:^(SexPickView *sexView, NSInteger buttonIndex) {
 
 if (buttonIndex == 0){
 [btn setTitle:@"男" forState:UIControlStateNormal];
 }else if (buttonIndex == 1){
 [btn setTitle:@"女" forState:UIControlStateNormal];
 
 }
 }];
 [sheetView showView];
 
 */
#import <UIKit/UIKit.h>

@interface SexPickView : UIView
@property (nonatomic, copy) void(^buttonClick)(SexPickView *sexView,NSInteger buttonIndex);


/**
 Description
 
 @param title 弹出框标题
 @param buttons 按钮列表
 @param block 选择项
 @return self
 */
- (id)initWithTitle:(NSString *)title buttons:(NSArray <NSString *>*)buttons buttonClick:(void(^)(SexPickView *sexView,NSInteger buttonIndex))block;


/**
 显示弹出框
 */
- (void)showView;
@end
