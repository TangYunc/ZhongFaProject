//
//  ClassifyPopView.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/10.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "ClassifyPopView.h"
#import "ClassifyMenuTableCell.h"
#import "ClassifyMenuResult.h"

@interface ClassifyPopView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIView *bjView;
@property (nonatomic,strong) UIView *maskView;
@property (nonatomic,strong) UIButton *cancelBtn;
@property (nonatomic, strong) UITableView *menuTableView;
@property (nonatomic, strong) UIButton *roleBtn;
@property (nonatomic, strong) NSMutableArray *menuArr;
@property (nonatomic, strong) NSMutableArray *choiceRoleResult;
@property (nonatomic, strong) NSMutableDictionary *choiceResultDic;

@property (nonatomic, strong) NSNumber *choiceCategoryNum;
@end

@implementation ClassifyPopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self addSubview:self.maskView];
        [self addSubview:self.bjView];
        [self addSubview:self.cancelBtn];
        self.choiceCategoryNum = @0;
        NSArray *roleArr = @[@"生产商",@"代理商",@"贸易商",@"服务商",@"个人",@"专家",@"工程师",@"科研单位/学校"];
        NSInteger tempCount = roleArr.count;
        for (NSInteger i = 0; i < tempCount; i ++) {
            ClassifyMenuResult *menuData = [[ClassifyMenuResult alloc] init];
            menuData.title = roleArr[i];
            [self.menuArr addObject:menuData];   
        }
    }
    return self;
}
-(UIView *)maskView
{
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _maskView.backgroundColor = [UIColor blackColor];
        _maskView.alpha = 0.5;
    }
    return _maskView;
}
-(UIButton *)cancelBtn
{
    if (!_cancelBtn) {
        UIImage *cancelBtnImage = [UIImage imageNamed:@"ClassifyCancelBtnIcon"];
        CGFloat cancelBtnWidth = 48/2.0 * KWidth_ScaleW;
        CGFloat cancelBtnHeight = 90/2.0 * KWidth_ScaleH;
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.frame = CGRectMake(0, 0, cancelBtnWidth, cancelBtnHeight);
        _cancelBtn.bottom = self.bjView.top;
        _cancelBtn.right = self.bjView.right;
        [_cancelBtn setImage:cancelBtnImage forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}
//2.创建一个弹窗视图
-(UIView *)bjView
{
    if (!_bjView) {
        //1.
        _bjView = [[UIView alloc] init];
        _bjView.backgroundColor = UIColorFromRGBA(255, 255, 255, 1.0);
        _bjView.clipsToBounds = YES;
        _bjView.layer.borderWidth = 0.5;
        _bjView.layer.cornerRadius = 5;
        _bjView.width = kScreenWidth - 78/2.0 * KWidth_ScaleW - 75/2.0 * KWidth_ScaleW;
        _bjView.height = kScreenHeight - 345/2.0 * KWidth_ScaleH - 366/2.0 * KWidth_ScaleH;
        _bjView.centerX = _maskView.centerX;
        _bjView.top = 345/2.0 * KWidth_ScaleH;
        _bjView.userInteractionEnabled = YES;
        UIImageView *headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _bjView.width, 128/2.0 * KWidth_ScaleH)];
        headerView.image = [UIImage imageNamed:@"ClassifyHeaderViewIcon"];
        [_bjView addSubview:headerView];
        //2.
        NSString *headerStr = @"大数据为您个性化定制";
        CGFloat headerLabelHeight = 40/2.0 * KWidth_ScaleH;
        CGFloat headerLabelGapFromLeft = 38/2.0 * KWidth_ScaleH;
        UILabel *headerLabel = [[UILabel alloc] init];
        CGSize headerLblWidthSize = [headerLabel sizeThatFits:CGSizeMake(MAXFLOAT,headerLabelHeight)];
        headerLabel.frame = CGRectMake(headerLabelGapFromLeft, 0, headerLblWidthSize.width, headerLabelHeight);
        headerLabel.textColor = [UIColor whiteColor];
        headerLabel.font = [UIFont boldSystemFontOfSize:20.f];
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:headerStr];
        [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.f] range:NSMakeRange(3, attr.length - 3)];
        headerLabel.attributedText = attr;
        [headerView addSubview:headerLabel];
        [headerLabel sizeToFit];
        headerLabel.centerY = headerView.centerY;
        //2.
        CGFloat roleBtnWidth = 535/2.0 * KWidth_ScaleW;
        CGFloat roleBtnHeight = 66/2.0 * KWidth_ScaleH;
        CGFloat roleBtnGapFromTop = 25/2.0 * KWidth_ScaleW;
        UIButton *roleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        roleBtn.frame = CGRectMake(0, headerView.bottom + roleBtnGapFromTop, roleBtnWidth, roleBtnHeight);
        roleBtn.centerX = headerView.centerX;
        roleBtn.layer.borderColor = [UIColor colorWithHexString:@"#D5D5D5"].CGColor;
        roleBtn.layer.borderWidth = 1;
        [roleBtn setTitle:@"请选择您的角色" forState:UIControlStateNormal];
        [roleBtn setImage:[UIImage imageNamed:@"ClassifyDownIcon"] forState:UIControlStateNormal];
        [roleBtn setImage:[UIImage imageNamed:@"ClassifyUpIcon"] forState:UIControlStateSelected];
        [roleBtn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        roleBtn.titleLabel.font = [UIFont systemFontOfSize:11.f];
        roleBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 170);
        roleBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 240, 0, 0);
        [roleBtn addTarget:self action:@selector(roleClick:) forControlEvents:UIControlEventTouchUpInside];
        [_bjView addSubview:roleBtn];
        self.roleBtn = roleBtn;
        //3.
        NSString *tipStr = @"告诉我们您感兴趣的（可多选，最多只能选四个）";
        CGFloat tipLabelHeight = 33/2.0 * KWidth_ScaleH;
        CGFloat tipLabelGapFromTop = 21/2.0 * KWidth_ScaleH;
        UILabel *tipLabel = [[UILabel alloc] init];
        CGSize tipLblWidthSize = [tipLabel sizeThatFits:CGSizeMake(MAXFLOAT,tipLabelHeight)];
        tipLabel.frame = CGRectMake(roleBtn.left, roleBtn.bottom + tipLabelGapFromTop, tipLblWidthSize.width, tipLabelHeight);
        tipLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        tipLabel.font = [UIFont boldSystemFontOfSize:12.f];
        NSMutableAttributedString *attr2 = [[NSMutableAttributedString alloc] initWithString:tipStr];
        [attr2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:9.f] range:NSMakeRange(9, attr2.length - 9)];
            [attr2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#FF6600"] range:NSMakeRange(9, attr2.length - 9)];
        tipLabel.attributedText = attr2;
        [_bjView addSubview:tipLabel];
        [tipLabel sizeToFit];
        //4.
        NSArray *titleArr = @[@"通信电子",@"交通工具",@"能源化工",@"仪表仪器,通信电子",@"交通工具",@"能源化工",@"仪表仪器,通信电子",@"交通工具",@"能源化工",@"仪表仪器"];
        NSInteger tempCount = titleArr.count;
        CGFloat categoryBtnGapFromLeft = 33/2.0 * KWidth_ScaleW;
        CGFloat categoryBtnGapFromTop = 25/2.0 * KWidth_ScaleW;
        CGFloat categoryBtnGapHorizonWithOther = 12/2.0 * KWidth_ScaleW;
        CGFloat categoryBtnGapVerticalWithOther = 14/2.0 * KWidth_ScaleW;
        CGFloat categoryBtnWidth = (_bjView.width - categoryBtnGapFromLeft * 2 - categoryBtnGapHorizonWithOther * 3) / 4;
        CGFloat categoryBtnHeight = 50/2.0 * KWidth_ScaleH;
        for (NSInteger i = 0; i < tempCount; i++) {
            UIButton *categoryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            categoryBtn.frame = CGRectMake(categoryBtnGapFromLeft + (i % 4) * (categoryBtnWidth + categoryBtnGapHorizonWithOther),tipLabel.bottom + categoryBtnGapFromTop +  (i / 4) * (categoryBtnHeight + categoryBtnGapVerticalWithOther), categoryBtnWidth, categoryBtnHeight);
            categoryBtn.layer.borderColor = [UIColor colorWithHexString:@"#999999"].CGColor;
            categoryBtn.layer.borderWidth = 1;
            categoryBtn.layer.cornerRadius = 3;
            categoryBtn.tag = 10 + i;
            categoryBtn.titleLabel.font = [UIFont systemFontOfSize:11.f];
            [categoryBtn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
            [categoryBtn setTitleColor:[UIColor colorWithHexString:@"#31B3EF"] forState:UIControlStateSelected];
            [categoryBtn setTitle:titleArr[i] forState:UIControlStateNormal];
            [categoryBtn addTarget:self action:@selector(categoryBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [_bjView addSubview:categoryBtn];
        }
        //5.
        CGFloat confirmBtnWidth = 296/2.0 * KWidth_ScaleW;
        CGFloat confirmBtnHeight = 68/2.0 * KWidth_ScaleH;
        CGFloat confirmBtnGapFromBottom = 38/2.0 * KWidth_ScaleH;
        UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        confirmBtn.frame = CGRectMake(0,0, confirmBtnWidth, confirmBtnHeight);
        confirmBtn.centerX = headerView.centerX;
        confirmBtn.layer.cornerRadius = confirmBtnWidth / 10;
        confirmBtn.titleLabel.font = [UIFont systemFontOfSize:13.f];
        [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
        [confirmBtn setBackgroundColor:[UIColor colorWithHexString:@"#31B3EF"]];
        [confirmBtn addTarget:self action:@selector(confirmClick:) forControlEvents:UIControlEventTouchUpInside];
        [_bjView addSubview:confirmBtn];
        confirmBtn.bottom = _bjView.height - confirmBtnGapFromBottom;
    }
    return _bjView;
}

-(UITableView *)menuTableView
{
    if (!_menuTableView) {
        CGFloat menuTableViewWidth = 140/2.0 * KWidth_ScaleW;
        CGFloat menuTalbeViewGapFromLeft = 414/2.0 * KWidth_ScaleH;
        _menuTableView = [[UITableView alloc] initWithFrame:CGRectMake(menuTalbeViewGapFromLeft, self.roleBtn.bottom, menuTableViewWidth, 60/2.0 * 4) style:UITableViewStylePlain];
        _menuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _menuTableView.backgroundColor = [UIColor whiteColor];
        _menuTableView.layer.borderWidth = 1;
        _menuTableView.layer.borderColor = [UIColor colorWithHexString:@"#D5D5D5"].CGColor;
        _menuTableView.delegate = self;
        _menuTableView.dataSource = self;
        _menuTableView.tableFooterView = [[UIView alloc] init];
        [self.bjView addSubview:_menuTableView];
    }
    return _menuTableView;
}

-(NSMutableArray *)menuArr
{
    if (!_menuArr) {
        _menuArr = [[NSMutableArray alloc] init];
    }
    return _menuArr;
}

-(NSMutableArray *)choiceRoleResult
{
    if (!_choiceRoleResult) {
        _choiceRoleResult = [[NSMutableArray alloc] init];
    }
    return _choiceRoleResult;
}

-(NSMutableDictionary *)choiceResultDic
{
    if (!_choiceResultDic) {
        _choiceResultDic = [[NSMutableDictionary alloc] init];
    }
    return _choiceResultDic;
}

#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.menuArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *indentifier = @"cellId";
    ClassifyMenuTableCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil) {
        cell = [[ClassifyMenuTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.menuResult = self.menuArr[indexPath.row];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];    
    
    for (ClassifyMenuResult *menuResult in self.menuArr) {
        menuResult.isSelected = NO;
    }
    ClassifyMenuResult *menuResult = self.menuArr[indexPath.row];
    menuResult.isSelected = YES;
    self.menuTableView.hidden = YES;
    [self.menuTableView reloadData];
    [self.roleBtn setTitle:menuResult.title forState:UIControlStateNormal];
    [self.choiceResultDic setObject:menuResult.title forKey:@"roleTpye"];
    self.roleBtn.selected = !self.roleBtn.selected;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 60/2.0 * KWidth_ScaleH;
}
#pragma mark -- 按钮事件
- (void)confirmClick:(UIButton *)button{
    
    NSLog(@"点击确认按钮");
    [self.choiceResultDic setObject:self.choiceRoleResult forKey:@"roleType"];
    [KUserDefault setObject:@YES forKey:ShowClassifyPopView];
    [self removeFromSuperview];
}

- (void)cancelClick:(UIButton *)button{
    
    [self removeFromSuperview];
}

- (void)roleClick:(UIButton *)button{
    
    button.selected = !button.selected;
    if (button.selected) {
        self.menuTableView.hidden = NO;
    }else{
        
        self.menuTableView.hidden = YES;
    }
}

- (void)categoryBtnClick:(UIButton *)button{
    
    button.selected = !button.selected;
    if ([self.choiceCategoryNum intValue] > 3) {
        button.enabled = NO;
        [MBProgressHUD showError:@"最多只能选四个哦!"];
        return;
    }
    if (button.selected) {
        button.layer.borderColor = [UIColor colorWithHexString:@"#31B3EF"].CGColor;
        self.choiceCategoryNum = [NSNumber numberWithDouble:[self.choiceCategoryNum intValue] + 1];
        [self.choiceRoleResult addObject:button.currentTitle];
    }else{
        button.layer.borderColor = [UIColor colorWithHexString:@"#999999"].CGColor;
        self.choiceCategoryNum = [NSNumber numberWithDouble:[self.choiceCategoryNum intValue] - 1];
        [self.choiceRoleResult removeObject:button.currentTitle];
    }
    
    if (button.tag == 10) {
        NSLog(@"通信电子");
    }
}
#pragma mark -- 手势

#pragma 自定义处理函数 -- 解析出有序的json 字符串
-(NSArray *)arraryWithJsonString:(NSString *)jsonString{
    if (jsonString == nil) {
        return nil;
    }
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\""  withString:@""];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"{"  withString:@""];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"}"  withString:@""];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\\"  withString:@""];
    NSArray *array = [jsonString componentsSeparatedByString:@","];
    return  (array.count == 0 ) ? nil : array;
}

//提示控件
- (void)popAlertViewWithTitle:(NSString *)title Message:(NSString *)message{
    
    //弹出alert视图提示输入账号密码
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:cancel];
    [alert addAction:confirm];
    
    [self.alertVC presentViewController:alert animated:YES completion:nil];
}
@end
