//
//  RRPropertyEditSubview.h
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/12.
//  Copyright © 2018年 中发. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^RRPropertyEditSubviewBlock)(void);

@interface RRPropertyEditSubview : UIView
{
    UILabel *_titleLabel;
    UILabel *_contentLabel;
    UIImageView *_auxiliaryImageView;
    UIView *_bottomView;
    UIButton *_coverBtn;
}

@property(nonatomic,copy)RRPropertyEditSubviewBlock block;
@property(nonatomic,copy)NSString *titleStr;
@property(nonatomic,assign)BOOL showAuxiliaryIcon;//是否显示右侧的辅助图标
@property(nonatomic,assign)BOOL showScroll;//显示滚动视图还是城市选择视图
@property(nonatomic,assign)BOOL isClickCoverBtn;//coverBtn是否可以点击
@end
