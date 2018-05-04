//
//  SSMFiltrateCell.h
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/16.
//  Copyright © 2018年 中发. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSMFiltrateCellResult.h"

typedef void(^SSMFiltrateCellBlock)(CGFloat cellHeight);
@interface SSMFiltrateCell : UITableViewCell
{
    UIView *_bjView;
    
}
@property (nonatomic, copy)SSMFiltrateCellBlock block;
@property (nonatomic, strong)UIView *bjView;
@property (nonatomic, strong)NSArray *datas;
@property (nonatomic, strong)SSMFiltrateCellResult *result;
@end
