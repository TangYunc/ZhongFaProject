//
//  RRAgencyScrollView.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/12.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "RRAgencyScrollView.h"
#import "RRPropertyEditSubview.h"
#import "RRCustomSubview.h"
#import "RRTextViewEditSubview.h"

@interface RRAgencyScrollView ()<UITextFieldDelegate,UITextViewDelegate>
{
    UITextView *_textView;
    UILabel *placeholderLabel;
    RRCustomSubview *_rrCustomSubview;
}
@property (nonatomic, assign) Float32 keyboardHeight;
@property (nonatomic, assign) Float32 inputViewMaxY;


@end

@implementation RRAgencyScrollView

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
    
    NSArray *titleArr = @[@"公司名称",@"请选择您的行业",@"所在地区",@"招代理品牌",@"代理模式",@"已代理品牌",@"计划投资金额"];
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
    RRPropertyEditSubview *companyNameView = (RRPropertyEditSubview *)[self viewWithTag:10];
    companyNameView.showAuxiliaryIcon = NO;

    CGFloat textFieldWidth = 522/2.0 * KWidth_ScaleW;
    CGFloat textFieldHeight = 66/2.0 * KWidth_ScaleH;
    CGFloat TextFieldGapFromTop = (companyNameView.height - textFieldHeight) / 2.0;
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, TextFieldGapFromTop, textFieldWidth, textFieldHeight)];
    textField.right = companyNameView.right - 27/2.0 * KWidth_ScaleW;
    // 输入框样式
    textField.borderStyle = UITextBorderStyleRoundedRect;
    // 清除文本视图按钮
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    // 设置字体的大小
    textField.font = [UIFont boldSystemFontOfSize:14.f];
    // 设置字体颜色
    textField.textColor = [UIColor colorWithHexString:@"#666666"];
    // 我们可能需要监听文本框的一些操作的时候，系统给我们提供了一个协议，可以让我们监听一些设置
    textField.delegate = self;
    [companyNameView addSubview:textField];
    RRPropertyEditSubview *brandView = (RRPropertyEditSubview *)[self viewWithTag:13];
    brandView.showAuxiliaryIcon = NO;
    
    UITextField *brandTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, TextFieldGapFromTop, textFieldWidth, textFieldHeight)];
    brandTextField.right = brandView.right - 27/2.0 * KWidth_ScaleW;
    brandTextField.borderStyle = UITextBorderStyleRoundedRect;
    brandTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    brandTextField.font = [UIFont boldSystemFontOfSize:14.f];
    brandTextField.textColor = [UIColor colorWithHexString:@"#666666"];
    brandTextField.delegate = self;
    [brandView addSubview:brandTextField];
    
    RRPropertyEditSubview *plannedInvestmentAmountNameView = (RRPropertyEditSubview *)[self viewWithTag:16];
    CGFloat rrCustomSubviewHeight = kScreenHeight - 784/2.0 * KWidth_ScaleH;
    CGFloat rrCustomSubviewGapFromTop = 20/2.0 * KWidth_ScaleH;
    _rrCustomSubview = [[RRCustomSubview alloc] initWithFrame:CGRectMake(0, plannedInvestmentAmountNameView.bottom + rrCustomSubviewGapFromTop, kScreenWidth, rrCustomSubviewHeight)];
    [self addSubview:_rrCustomSubview];
}

#pragma mark -- 手势
- (void)propertyEditViewTap:(UITapGestureRecognizer *)tap{
    if (tap.view.tag == 10) {
        NSLog(@"公司名称");
    }else if (tap.view.tag == 11){
        NSLog(@"请选择您的行业");
    }else if (tap.view.tag == 12){
        NSLog(@"所在地区");
    }else if (tap.view.tag == 13){
        NSLog(@"招代理品牌");
    }else if (tap.view.tag == 14){
        NSLog(@"代理模式");
    }else if (tap.view.tag == 15){
        NSLog(@"已代理品牌");
    }else if (tap.view.tag == 16){
        NSLog(@"计划投资金额");
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
