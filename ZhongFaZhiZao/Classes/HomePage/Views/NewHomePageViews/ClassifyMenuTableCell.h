//
//  ClassifyMenuTableCell.h
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/10.
//  Copyright © 2018年 中发. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassifyMenuResult.h"

@interface ClassifyMenuTableCell : UITableViewCell
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIView *bottomLine;
@property (nonatomic, strong) ClassifyMenuResult *menuResult;
@property (strong, nonatomic) NSDictionary *theDic;
@end
