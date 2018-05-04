//
//  SSMTableViewController.h
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/16.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "BaseViewController.h"

@interface SSMTableViewController : BaseViewController

@property (nonatomic, copy) NSString *titleStr;

@property (nonatomic, copy) NSString *sort;//排序参数：price asc（价格升序）\price desc（价格降序）
@property (nonatomic, copy) NSString *classid;//分类id
@property (nonatomic, copy) NSString *min_price;//最小价格
@property (nonatomic, copy) NSString *max_price;//最大价格
@property (nonatomic, copy) NSString *location;//所在地
@property (nonatomic, copy) NSString *brand_id;//品牌
@property (nonatomic, copy) NSString *level;//1查询一级分类，2查询二级分类

@end
