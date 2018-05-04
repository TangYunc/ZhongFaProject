//
//  CustomTabBar.h
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/3/1.
//  Copyright © 2018年 中发. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomTabBar;

@protocol CustomTabBarDelegate <NSObject>

-(void)tabBar:(CustomTabBar *)tabBar from:(NSInteger)from to:(NSInteger)to;
-(void)tabBarPresentViewController:(CustomTabBar *)tabBar;
-(void)selectTabItem:(NSInteger)index;

@end

@interface CustomTabBar : UIView

@property (nonatomic, weak) id <CustomTabBarDelegate> delegate;
@property (nonatomic, strong) UIView *tabBarView;
@property (nonatomic, strong) UILabel *tabBarLabel;


-(void)addTabBarButton:(UITabBarItem *)item;
-(void)selectTabItem:(NSInteger)index;

@end
