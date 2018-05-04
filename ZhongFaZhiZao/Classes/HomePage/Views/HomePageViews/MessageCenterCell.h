//
//  MessageCenterCell.h
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/3/2.
//  Copyright © 2018年 中发. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageCenterCell : UITableViewCell
{
    UIView *_lowbgdView;
    UILabel *_yueLabel;
    UIImageView *_pimageView;
}
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UIImageView *mainImgView;
@property (nonatomic,strong) UILabel *sumLabel;
@end
