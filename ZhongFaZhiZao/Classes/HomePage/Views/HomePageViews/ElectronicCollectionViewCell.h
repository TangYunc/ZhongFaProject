//
//  ElectronicCollectionViewCell.h
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/3/5.
//  Copyright © 2018年 中发. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ElectronicCollectionViewCell : UICollectionViewCell
{
    UIImageView *_ElectronicImg;
    UIImageView *_mengbanImg;
    UILabel *_mengbanLabel;
    UILabel *_leftLbl;
    UILabel *_rightLbl;
    UIImageView *_icon;
    UILabel *_cityLabel;
}
@property (nonatomic,copy)NSDictionary *dataDic;

@end
