//
//  BLFBatteryLoadingVC.m
//  FblFunctionMuster
//
//  Created by Fanbaili on 2021/7/15.
//  Copyright © 2021 FblFunctionMuster. All rights reserved.
//

#import "BLFBatteryLoadingVC.h"
#import "BLFBatteryLoadingView.h"

@interface BLFBatteryLoadingVC ()

@end

@implementation BLFBatteryLoadingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BLThemeColor;
    BLFBatteryLoadingView *batteryView = [[BLFBatteryLoadingView alloc]init];
    [self.view addSubview:batteryView];
    [batteryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(50);
        make.width.equalTo(@100);
        make.height.equalTo(@50);
    }];
    batteryView.textStyle = 3;
    batteryView.batteryState = 0;
    
    BLFBatteryLoadingView *batteryView1 = [[BLFBatteryLoadingView alloc]init];
    [self.view addSubview:batteryView1];
    [batteryView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(150);
        make.width.equalTo(@100);
        make.height.equalTo(@100);
    }];
    batteryView1.textStyle = 1;
    batteryView1.batteryState = 1;
    
    BLFBatteryLoadingView *batteryView2 = [[BLFBatteryLoadingView alloc]init];
    [self.view addSubview:batteryView2];
    [batteryView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(250);
        make.width.equalTo(@100);
        make.height.equalTo(@100);
    }];
    batteryView2.textStyle = 1;
    
    BLFBatteryLoadingView *batteryView3 = [[BLFBatteryLoadingView alloc]init];
    [self.view addSubview:batteryView3];
    [batteryView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(350);
        make.width.equalTo(@100);
        make.height.equalTo(@100);
    }];
    batteryView3.textStyle = 2;
}
@end
