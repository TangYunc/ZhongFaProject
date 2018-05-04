//
//  RRCustomizedScrollView.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/12.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "RRCustomizedScrollView.h"
#import "RRPropertyEditSubview.h"
#import "RRCustomSubview.h"
#import "RRTextViewEditSubview.h"

@interface RRCustomizedScrollView ()<UITextFieldDelegate>
{
//    UITextView *_textView;
    UILabel *placeholderLabel;
    RRCustomSubview *_rrCustomSubview;
    RRTextViewEditSubview *_textViewEditSubview;
}
@property (nonatomic, assign) Float32 keyboardHeight;
@property (nonatomic, assign) Float32 inputViewMaxY;


@end

@implementation RRCustomizedScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //初始化UI
        [self initUI];
        
        // 监听键盘变化
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChanged:) name:UIKeyboardWillChangeFrameNotification object:nil];
        // 增加一个键盘监听方法（为了能够在键盘弹起完成后，让视图内容滚动）
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidChanged) name:UIKeyboardDidChangeFrameNotification object:nil];
        
    }
    return self;
}
//初始化UI
- (void)initUI{
    
    NSArray *titleArr = @[@"项目所处阶段",@"项目需求类型",@"项目需求子类型",@"请选择您的行业"];
    NSInteger tempCount = titleArr.count;
    CGFloat propertyEditViewHeight = 99/2.0 * KWidth_ScaleH;
    for (NSInteger i = 0; i < tempCount; i++) {
        
        RRPropertyEditSubview *propertyEditView = [[RRPropertyEditSubview alloc] initWithFrame:CGRectMake(0, i * propertyEditViewHeight, kScreenWidth, propertyEditViewHeight)];
        propertyEditView.tag = 10 + i;
        propertyEditView.titleStr = titleArr[i];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(propertyEditViewTap:)];
        [propertyEditView addGestureRecognizer:tap];
        [self addSubview:propertyEditView];
    }
    //2.
    RRPropertyEditSubview *lastView = (RRPropertyEditSubview *)[self viewWithTag:13];
    CGFloat textBJViewHeight = 377.5/2.0 * KWidth_ScaleH;
    _textViewEditSubview = [[RRTextViewEditSubview alloc] initWithFrame:CGRectMake(0, lastView.bottom, kScreenWidth, textBJViewHeight)];
    _textViewEditSubview.discribStr = @"请描述您的需求";
    _textViewEditSubview.placeholderStr = @"具体描述您的需求，方便我们能更快更好的为您服务";
    [self addSubview:_textViewEditSubview];
    
    CGFloat rrCustomSubviewHeight = kScreenHeight - 784/2.0 * KWidth_ScaleH;
    CGFloat rrCustomSubviewGapFromTop = 20/2.0 * KWidth_ScaleH;
    _rrCustomSubview = [[RRCustomSubview alloc] initWithFrame:CGRectMake(0, _textViewEditSubview.bottom + rrCustomSubviewGapFromTop, kScreenWidth, rrCustomSubviewHeight)];
    [self addSubview:_rrCustomSubview];
}

#pragma mark -- 手势
- (void)propertyEditViewTap:(UITapGestureRecognizer *)tap{
    if (tap.view.tag == 10) {
        NSLog(@"项目所处阶段");
    }else if (tap.view.tag == 11){
        NSLog(@"项目需求类型");
    }else if (tap.view.tag == 12){
        NSLog(@"项目需求子类型");
    }else if (tap.view.tag == 13){
        NSLog(@"请选择您的行业");
    }
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.inputViewMaxY = CGRectGetMaxY(textField.superview.frame);
    [self scrollToBottom];
    
    return YES;
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    self.inputViewMaxY = CGRectGetMaxY(textView.superview.frame);
    [self scrollToBottom];
    return YES;
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

#pragma 根据keyboardChanged滚动scrollView
-(void)keyboardChanged:(NSNotification *)notification {
    // UIKeyboardFrameEndUserInfoKey =>将要变化的大小
    CGRect keyboardRect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.keyboardHeight = keyboardRect.size.height;
}

-(void)keyboardDidChanged
{
    [self scrollToBottom];
}


-(void)scrollToBottom
{
    Float32 keyboardMaxY = kScreenHeight - self.keyboardHeight;
    Float32 scrollOffset = self.inputViewMaxY - keyboardMaxY;
    if (scrollOffset >= 0) {
        [self setContentOffset:CGPointMake(0, scrollOffset) animated:YES];
    }
    
}

@end
