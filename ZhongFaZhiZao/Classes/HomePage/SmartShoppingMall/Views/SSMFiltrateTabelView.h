//
//  SSMFiltrateTabelView.h
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/16.
//  Copyright © 2018年 中发. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSMFiltrateCellResult.h"
#import "SSMTableResult.h"

@interface SSMFiltrateTabelView : UITableView

@property (nonatomic, strong)SSMTableDatas *theDatas;

@property (nonatomic, strong)SSMFiltrateCellResult *result;
@end
