//
//  RRTextViewEditSubview.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/12.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "RRTextViewEditSubview.h"

@interface RRTextViewEditSubview ()<UITextViewDelegate>
{
    UITextView *_textView;
    UILabel *placeholderLabel;
    UILabel *_discribLabel;
}
@end

@implementation RRTextViewEditSubview

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self initSubviews];
    }
    return self;
}

//初始化子视图
- (void)initSubviews{
    
//    CGFloat textBJViewHeight = 377.5/2.0 * KWidth_ScaleH;
    CGFloat discribLabelHeight = 99/2.0 * KWidth_ScaleH;
    CGFloat discribLabelGapFromLeft = 32/2.0 * KWidth_ScaleW;
    _discribLabel = [[UILabel alloc] initWithFrame:CGRectMake(discribLabelGapFromLeft, 0, kScreenWidth - discribLabelGapFromLeft, discribLabelHeight)];
    _discribLabel.textAlignment = NSTextAlignmentLeft;
    _discribLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    _discribLabel.font = [UIFont systemFontOfSize:14.f];
    [self addSubview:_discribLabel];
    //3.
    CGFloat textViewGapFromTop = 15/2.0 * KWidth_ScaleW;
    CGFloat textViewWidth = self.frame.size.width - discribLabelGapFromLeft * 2;
    CGFloat textViewHeight = 256/2.0 * KWidth_ScaleH;
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(_discribLabel.left, _discribLabel.bottom + textViewGapFromTop, textViewWidth, textViewHeight)];
    _textView.font = [UIFont systemFontOfSize:16.f];
    _textView.textColor = [UIColor colorWithHexString:@"#C5C5C5"];
    _textView.scrollEnabled = YES;
    _textView.editable = YES;
    _textView.delegate = self;
    _textView.returnKeyType = UIReturnKeyDefault;
    _textView.backgroundColor = [UIColor colorWithHexString:@"#F6F6F6"];
    [self addSubview:_textView];
    CGFloat placeholderLabelHeight = 20/2.0 * KWidth_ScaleH;
    placeholderLabel = [[UILabel alloc]initWithFrame:CGRectMake(3, 6 * KWidth_ScaleH, _textView.width, placeholderLabelHeight)];
    placeholderLabel.enabled = NO;
    placeholderLabel.textAlignment = NSTextAlignmentLeft;
    placeholderLabel.font = [UIFont systemFontOfSize:14.f];
    placeholderLabel.textColor = [UIColor colorWithHexString:@"#C5C5C5"];
    [_textView addSubview:placeholderLabel];
}

- (void)setDiscribStr:(NSString *)discribStr{
    
    if (_discribStr != discribStr) {
        _discribStr = discribStr;
        _discribLabel.text = _discribStr;
    }
}

- (void)setPlaceholderStr:(NSString *)placeholderStr{
    
    if (_placeholderStr != placeholderStr) {
        _placeholderStr = placeholderStr;
        placeholderLabel.text = _placeholderStr;
    }
}
#pragma mark -- UITextView的代理方法:
//内容发生改变编辑
- (void)textViewDidChange:(UITextView *)textView{
    if ([textView.text length] == 0) {
        [placeholderLabel setHidden:NO];
    }else{
        [placeholderLabel setHidden:YES];
    }
    
    NSString *text = textView.text;
    NSString *text2 = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if([text2 isEqual:@""]){
        return;
    }
    if (self.block) {
        self.block(textView, text2);
    }
    //控件自适应输入的文本的内容的高度，只要在textViewDidChange的代理方法中加入调整控件大小的代理即可
    //计算文本的高度
    //    CGSize constraintSize;
    //    constraintSize.width = textView.frame.size.width-16;
    //    constraintSize.height = MAXFLOAT;
    //    CGSize sizeFrame = [textView.text sizeWithFont:textView.font
    //                                constrainedToSize:constraintSize
    //                                    lineBreakMode:UILineBreakModeWordWrap];
    
    //重新调整textView的高度
    //    textView.frame =CGRectMake(textView.frame.origin.x,textView.frame.origin.y,textView.frame.size.width,sizeFrame.height+5);
}


//内容将要发生改变编辑
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    //    NSString *text2 = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //
    //    if([text2 isEqual:@""]){
    //        return NO;
    //    }
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    //控制输入文字的长度和内容，可通调用以下代理方法实现
    //    if (range.location>=120)
    //    {
    //        //控制输入文本的长度
    //        return  YES;
    //    }
    //    else
    //    {
    //        return YES;
    //    }
    return YES;
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    [textView resignFirstResponder];
    
    return;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}
@end
