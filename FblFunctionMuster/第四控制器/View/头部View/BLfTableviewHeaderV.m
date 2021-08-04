//
//  BLfTableviewHeaderV.m
//  FblFunctionMuster
//
//  Created by Fanbaili on 2021/8/2.
//  Copyright © 2021 FblFunctionMuster. All rights reserved.
//

#import "BLfTableviewHeaderV.h"

@implementation BLfTableviewHeaderV
- (instancetype)init {
    self = [super init];
    if (self) {
        [self creatSubviews];
    }
    return self;
}

- (void)creatSubviews {
    self.backgroundColor = UIColor.greenColor;

    //客服按钮
    #pragma mark - 客服按钮
    UIButton *serviceButton = [[UIButton alloc]init];
    [serviceButton setTitle:@"客服" forState:UIControlStateNormal];
    [serviceButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    serviceButton.backgroundColor = UIColor.yellowColor;
    serviceButton.titleLabel.font = BLTextBroadFont(16);
    BLWeakSelf(self)
    [self addSubview:serviceButton];
    [serviceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        BLStrongSelf(self)
        make.top.equalTo(self);
        make.right.equalTo(self).offset(-20);
        make.height.offset(30);
        make.width.offset(40);
    }];
    
    //设置按钮
    #pragma mark - 设置按钮
    UIButton *settingButton = [[UIButton alloc]init];
    [settingButton setTitle:@"设置" forState:UIControlStateNormal];
    [settingButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    settingButton.backgroundColor = UIColor.yellowColor;
    settingButton.titleLabel.font = BLTextBroadFont(16);
    [self addSubview:settingButton];
    [settingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        BLStrongSelf(self)
        make.top.equalTo(self);
        make.right.equalTo(serviceButton.mas_left).offset(-20);
        make.height.offset(30);
        make.width.offset(40);
    }];
    
    //头像
    #pragma mark - 图像
    UIImageView *photoImV = [[UIImageView alloc] init];
    photoImV.layer.cornerRadius = 40;
    photoImV.image = [UIImage imageNamed:@""];
    photoImV.backgroundColor = UIColor.yellowColor;
    [self addSubview:photoImV];
    [photoImV mas_makeConstraints:^(MASConstraintMaker *make) {
        BLStrongSelf(self)
        make.left.equalTo(self).offset(20);
        make.top.equalTo(self).offset(45);
        make.width.height.offset(80);
    }];
    
    //昵称
    #pragma mark - 昵称
    UIButton *nameButton = [[UIButton alloc]init];
    [nameButton setTitle:@"" forState:UIControlStateNormal];
    [nameButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    nameButton.backgroundColor = UIColor.yellowColor;
    nameButton.titleLabel.font = BLTextBroadFont(18);
    [self addSubview:nameButton];
    [nameButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(photoImV.mas_top);
        make.left.equalTo(photoImV.mas_right).offset(10);
        make.width.offset(150);
        make.height.offset(40);
    }];
    
    //提升实名等级
    #pragma mark - 实名等级
    UIButton *gradeButton = [[UIButton alloc]init];
    [gradeButton setTitle:@"" forState:UIControlStateNormal];
    [gradeButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    gradeButton.backgroundColor = UIColor.yellowColor;
    gradeButton.titleLabel.font = BLTextBroadFont(14);
    gradeButton.layer.cornerRadius = 12.5;
    [self addSubview:gradeButton];
    [gradeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameButton.mas_bottom).offset(5);
        make.left.equalTo(photoImV.mas_right).offset(10);
        make.width.offset(95);
        make.height.offset(30);
    }];
    
    
    //成长值
    #pragma mark - 成长值
    UIButton *growButton = [[UIButton alloc]init];
    [growButton setTitle:@"" forState:UIControlStateNormal];
    [growButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    growButton.backgroundColor = UIColor.yellowColor;
    growButton.titleLabel.font = BLTextBroadFont(14);
    growButton.layer.cornerRadius = 12.5;
    [self addSubview:growButton];
    [growButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameButton.mas_bottom).offset(5);
        make.left.equalTo(gradeButton.mas_right).offset(5);
        make.width.offset(50);
        make.height.offset(30);
    }];
    
    //走路赚钱
    #pragma mark - 走路赚钱
    UIView *walkView = [[UIView alloc]init];
    walkView.backgroundColor = UIColor.yellowColor;
    walkView.layer.cornerRadius = 10;
    [self addSubview:walkView];
    [walkView mas_makeConstraints:^(MASConstraintMaker *make) {
        BLStrongSelf(self)
        make.top.equalTo(self).offset(45);
        make.left.equalTo(nameButton.mas_right).offset(20);
        make.right.equalTo(self).offset(-20);
        make.height.offset(80);
    }];
    
    
    #pragma mark - 头部下面的4个按钮
    NSMutableArray<UIButton *> *buttonArray = [NSMutableArray array];
    for (NSInteger i = 0; i < 4; i++) {
        BLfVerticalButton *button = [[BLfVerticalButton alloc]init];
        button.backgroundColor = UIColor.yellowColor;
        [self addSubview:button];
        [buttonArray addObject:button];
    }
    [buttonArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:10 leadSpacing:20 tailSpacing:20];
    [buttonArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(44);
        make.height.offset(60);
        make.top.equalTo(photoImV.mas_bottom).offset(20);
    }];
    
    //
    
    //
    
    //
    
}
@end
