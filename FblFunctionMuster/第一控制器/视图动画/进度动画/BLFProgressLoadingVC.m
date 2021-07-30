//
//  BLFProgressLoadingVC.m
//  FblFunctionMuster
//
//  Created by Fanbaili on 2021/7/15.
//  Copyright © 2021 FblFunctionMuster. All rights reserved.
//

#import "BLFProgressLoadingVC.h"
#import "BLFWaterWaveView.h"
#import "BLFCircleView.h"
#import "BLFInstallView.h"
#import "BLFLineView.h"
#import "BLFWaterLoadingView.h"

@interface BLFProgressLoadingVC ()
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) BLFWaterWaveView *waterView;
@end

@implementation BLFProgressLoadingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BLThemeColor;
    
    //水波纹
    _waterView = [[BLFWaterWaveView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    [self.view addSubview:_waterView];
    BLWeakSelf(self)
    [_waterView mas_makeConstraints:^(MASConstraintMaker *make) {
        BLStrongSelf(self)
        make.centerX.equalTo(self.view);
        make.top.equalTo(@20);
        make.width.height.equalTo(@100);
    }];
    
    //圆环
    BLFCircleView *circle = [[BLFCircleView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    [self.view addSubview:circle];
    [circle mas_makeConstraints:^(MASConstraintMaker *make) {
        BLStrongSelf(self)
        make.centerX.equalTo(self.view);
        make.top.equalTo(@150);
        make.width.height.equalTo(@100);
    }];
    
    //圆
    BLFInstallView *install = [[BLFInstallView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    [self.view addSubview:install];
    [install mas_makeConstraints:^(MASConstraintMaker *make) {
        BLStrongSelf(self)
        make.centerX.equalTo(self.view);
        make.top.equalTo(@280);
        make.width.height.equalTo(@100);
    }];
    
    //线条
    BLFLineView *linev = [[BLFLineView alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
    [self.view addSubview:linev];
    [linev mas_makeConstraints:^(MASConstraintMaker *make) {
        BLStrongSelf(self)
        make.centerX.equalTo(self.view);
        make.top.equalTo(@410);
        make.width.equalTo(@100);
        make.height.equalTo(@20);
    }];
    
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        BLStrongSelf(self)
        if (self.waterView.progress < 1) {
            self.waterView.progress += 0.01;
            circle.progress += 0.01;
            install.progress += 0.01;
            linev.progress += 0.01;
        }else {
            [self.timer invalidate];
            self.timer = nil;
        }
    }];
    
    //波浪
    BLFWaterLoadingView *loadingView = [[BLFWaterLoadingView alloc] initWithFrame:CGRectMake(0, 500, self.view.frame.size.width, 200) title:@"404" font:[UIFont boldSystemFontOfSize:40] showLoadNote:YES];
    loadingView.speed = 5;
    loadingView.waveNum = 3;
    loadingView.waveHeight = 7;
    [self.view addSubview:loadingView];
}

- (void)dealloc {
    [self.timer invalidate];
    self.timer = nil;
}
@end
