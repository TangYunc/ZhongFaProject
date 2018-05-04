//
//  CustomSearchBar.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/18.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "CustomSearchBar.h"

@implementation CustomSearchBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.设置背景图片
        self.background = [UIImage imageNamed:@"SSMSearchTextFBg"];
        //        self.background = [self generateImageFromColor:UIColorFromRGBA(218, 1, 17, 1.0)];
        // 2.设置文本垂直居中
        //    searchBar.textAlignment = NSTextAlignmentCenter;  //这个是设置文本水平方向居中的
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        // 3.设置清除按钮
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        // 4.添加放大镜
        // 4.1创建放大镜
        
        // 先创建UIImageView再设置图片，UIImageView没有frame
        //    UIImageView *iv = [[UIImageView alloc] init];
        //    iv.image = [UIImage imageWithName:@"searchbar_textfield_search_icon"];
        
        // 创建UIImageView的同时初始化image,那么UIImageView的frame就是image的size
        UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SSMSearchSubIcon"]];
        // 把图片iv添加到searchBar上
        [self addSubview:iv];
        
        // 4.2 设置放大镜为leftView
        self.leftView = iv;
        self.leftViewMode = UITextFieldViewModeAlways;
        //    iv.backgroundColor = [UIColor redColor];
        iv.width = 40;
        iv.contentMode = UIViewContentModeCenter;
        
        // 5.设置提示问题
        self.placeholder = @"搜索产品名称或型号";
        [self setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
        self.textColor = [UIColor whiteColor];
        self.font = [UIFont systemFontOfSize:14 * KWidth_ScaleW];
        
        self.returnKeyType = UIReturnKeySearch;//变为搜索按钮
    }
    return self;
}

- (void)configerTheTFPlaceholder:(NSString *)placeholderStr{
    
    self.placeholder = placeholderStr;
}
#pragma mark - 根据颜色生成图片
- (UIImage *)generateImageFromColor:(UIColor *)color{
    
    UIGraphicsBeginImageContext(CGSizeMake(1, 1));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, 1, 1));
    UIImage *colorImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return colorImage;
}

@end
