//
//  BLfMyOrderFormV.m
//  FblFunctionMuster
//
//  Created by Fanbaili on 2021/8/2.
//  Copyright © 2021 FblFunctionMuster. All rights reserved.
//

#import "BLfMyOrderFormV.h"

@implementation BLfMyOrderFormV
- (instancetype)init {
    self = [super init];
    if (self) {
        [self creatSubviews];
    }
    return self;
}

- (void)creatSubviews {
    self.backgroundColor = UIColor.blueColor;
    self.layer.cornerRadius = 10;
    
    //我的订单
    #pragma mark - 我的订单
    UILabel *orderFormlabel = [[UILabel alloc]init];
    orderFormlabel.font = BLTextBroadFont(18);
    orderFormlabel.textColor = UIColor.blackColor;
    orderFormlabel.backgroundColor = UIColor.yellowColor;
    [self addSubview:orderFormlabel];
    [orderFormlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.offset(5);
        make.height.offset(30);
        make.width.offset(BLScreenWidth/2);
    }];
    
    UIImageView *imgV = [[UIImageView alloc]init];
    imgV.backgroundColor = UIColor.yellowColor;
    imgV.image = [UIImage imageNamed:@""];
    [self addSubview:imgV];
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(5);
        make.right.offset(-5);
        make.width.height.offset(30);
    }];
    
    UIButton *orderFormButton = [[UIButton alloc]init];
    [orderFormButton setTitle:@"" forState:UIControlStateNormal];
    [orderFormButton.titleLabel setFont:BLTextBroadFont(13)];
    [orderFormButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    orderFormButton.backgroundColor = UIColor.yellowColor;
    [self addSubview:orderFormButton];
    [orderFormButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(imgV.mas_left).offset(-10);
        make.top.offset(5);
        make.height.offset(30);
        make.width.offset(100);
    }];
    
    #pragma mark - 下面的5个按钮
    NSMutableArray<UIButton *> *buttonArray = [NSMutableArray array];
    for (NSInteger i = 0; i < 5; i++) {
        BLfVerticalButton *button = [[BLfVerticalButton alloc]init];
        button.backgroundColor = UIColor.yellowColor;
        [self addSubview:button];
        [buttonArray addObject:button];
    }
    [buttonArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:10 leadSpacing:20 tailSpacing:20];
    [buttonArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(44);
        make.height.offset(60);
        make.top.equalTo(orderFormButton.mas_bottom).offset(10);
    }];
    
}

@end
