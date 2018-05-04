//
//  CustomReleaseRequirementsButton.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/8.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "CustomReleaseRequirementsButton.h"

@implementation CustomReleaseRequirementsButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImage *image = [UIImage imageNamed:@"tabbarAddBtn"];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.image = image;
        imageView.tag = 200;
        [self addSubview:imageView];
        UILabel *releaseRequirementsLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        releaseRequirementsLabel.font = [UIFont boldSystemFontOfSize:10.f];
        releaseRequirementsLabel.textColor = UIColorFromRGBA(146, 146, 146, 1.0);
        releaseRequirementsLabel.textAlignment = NSTextAlignmentLeft;
        releaseRequirementsLabel.tag = 201;
        releaseRequirementsLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [self addSubview:releaseRequirementsLabel];
    }
    return self;
}
- (void)setTitleName:(NSString *)titleName{
    
    if (_titleName != titleName) {
        _titleName = titleName;
        UILabel *releaseRequirementsLabel = (UILabel *)[self viewWithTag:200];
        //        CGSize locationLabelWidthSize = [locationLabel sizeThatFits:CGSizeMake(MAXFLOAT,20)];
        releaseRequirementsLabel.frame = CGRectMake(0, 0, 45, 20);
        
        releaseRequirementsLabel.text = titleName;
        //        [locationLabel sizeToFit];
        
        UIImageView *imageView = (UIImageView *)[self viewWithTag:201];
        imageView.frame = CGRectMake(releaseRequirementsLabel.right + 1.9, 0, 10, 15);
        imageView.centerY = releaseRequirementsLabel.center.y;
    }
}

@end
