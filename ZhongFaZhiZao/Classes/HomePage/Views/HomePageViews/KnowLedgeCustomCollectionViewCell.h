//
//  KnowLedgeCustomCollectionViewCell.h
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/3/5.
//  Copyright © 2018年 中发. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KnowLedgeCustomCollectionViewCell : UICollectionViewCell
{
    UIImageView *_iconImg;
    UILabel *_textLbl;
}
@property (nonatomic,strong) NSString *text;
@property (nonatomic,strong) NSString *imageName;

@end
