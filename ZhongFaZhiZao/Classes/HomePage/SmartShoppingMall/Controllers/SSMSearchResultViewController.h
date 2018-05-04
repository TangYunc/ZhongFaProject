//
//  SSMSearchResultViewController.h
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/18.
//  Copyright © 2018年 中发. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSMSearchResultViewController : UITableViewController

/** 选中cell时调用此Block  */
@property (nonatomic, copy) void(^didSelectText)(NSString *selectedText);

@property (nonatomic, copy) NSString *sort;//排序参数：price asc（价格升序）\price desc（价格降序）
@property (nonatomic, copy) NSString *classid;//分类id
@property (nonatomic, copy) NSString *min_price;//最小价格
@property (nonatomic, copy) NSString *max_price;//最大价格
@property (nonatomic, copy) NSString *location;//所在地
@property (nonatomic, copy) NSString *brand_id;//品牌
@property (nonatomic, copy) NSString *level;//1查询一级分类，2查询二级分类
@property (nonatomic, copy) NSString *name;//搜索名称


//@property (nonatomic, strong) NSArray *searchResults;

@end
