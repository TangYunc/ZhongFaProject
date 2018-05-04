//
//  SSMTableViewCell.h
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/16.
//  Copyright © 2018年 中发. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSMTableResult.h"

@interface SSMTableViewCell : UITableViewCell
{
    UIImageView *_goodsImageView;
    UILabel *_goodsNameLabel;
    UILabel *_priceLabel;
    UIView *_gapLineView;
    UILabel *_companyNameLabel;
    UIImageView *_locationImageView;
    UILabel *_locationLabel;
    UIView *_bottomGapLineView;
}
@property (nonatomic, strong) SSMTableItems *theItems;
@property (nonatomic, assign) NSInteger theRecordCurrentIndex;                   // 记录当前单元格在数据数组中的位置
@end
