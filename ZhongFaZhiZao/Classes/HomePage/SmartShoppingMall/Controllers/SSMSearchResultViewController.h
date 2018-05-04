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

@property (nonatomic, strong) NSArray *searchResults;

@end
