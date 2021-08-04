//
//  BLfTestControllVC.m
//  FblFunctionMuster
//
//  Created by Fanbaili on 2021/8/4.
//  Copyright © 2021 FblFunctionMuster. All rights reserved.
//

#import "BLfKeychainVC.h"
#import "BLfKeychainTool.h"

@interface BLfKeychainVC ()

@end

@implementation BLfKeychainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BLThemeEndColor;
    UIButton *saveButton = [[UIButton alloc]init];
    [saveButton setTitle:@"save" forState:UIControlStateNormal];
    [self.view addSubview:saveButton];
    saveButton.frame = CGRectMake(100, 60, 60, 40);
    [[saveButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSString *str = [self generateTradeNO];
        [BLfKeychainTool saveKeychainValue:str key:@"password"];
        [BLfAlertView showTextAlert:[NSString stringWithFormat:@"保存数据-->%@",str] withView:self.view];
    }];
    
    UIButton *readButton = [[UIButton alloc]init];
    [readButton setTitle:@"read" forState:UIControlStateNormal];
    [self.view addSubview:readButton];
    readButton.frame = CGRectMake(100, 150, 60, 40);
    [[readButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSString *result = [BLfKeychainTool readKeychainValue:@"password"];
        if (result) {
            [BLfAlertView showTextAlert:result withView:self.view];
        }else{
            [BLfAlertView showTextAlert:@"读取失败" withView:self.view];
        }
    }];
    
    UIButton *deleteButton = [[UIButton alloc]init];
    [deleteButton setTitle:@"delete" forState:UIControlStateNormal];
    [self.view addSubview:deleteButton];
    deleteButton.frame = CGRectMake(100, 240, 60, 40);
    [[deleteButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        [BLfKeychainTool deleteKeychainValue:@"password"];
        [BLfAlertView showTextAlert:@"删除数据" withView:self.view];
    }];
}

//产生随机字符串
- (NSString *)generateTradeNO {
    static NSInteger kNumber = 12;
    NSString *sourceStr = @"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr =   [[NSMutableString alloc] init];
    for (NSInteger i = 0; i < kNumber;i++) {
        NSInteger index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}

@end
