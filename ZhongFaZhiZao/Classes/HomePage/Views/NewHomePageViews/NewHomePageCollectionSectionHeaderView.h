//
//  NewHomePageCollectionSectionHeaderView.h
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/9.
//  Copyright © 2018年 中发. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewHomePageCollectionSectionHeaderView : UIView
{
    UIView *_lineView;
    UILabel *_titleLabel;
    UILabel *_subtitleLabel;
    UIImageView *_auxiliaryView;
}

@property (nonatomic, copy)NSString *sectionType;
@end
