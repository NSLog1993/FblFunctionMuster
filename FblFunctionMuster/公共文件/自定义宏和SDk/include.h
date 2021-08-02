//
//  include.h
//  FblFunctionMuster
//
//  Created by Fanbaili on 2021/7/13.
//  Copyright © 2021 FblFunctionMuster. All rights reserved.
//

#ifndef include_h
#define include_h

#pragma mark - 头文件
#import "BLFParticleAnimationButton.h"
#import "BLCustomNavigationController.h"
#import "UIImage+BLFImageExtension.h"
#import <Masonry.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "BLfAlertView.h"

#pragma mark - 设备尺寸
#define BLScreenBounds [UIScreen mainScreen].bounds
#define BLScreenWidth [UIScreen mainScreen].bounds.size.width
#define BLScreenHeight [UIScreen mainScreen].bounds.size.height

#pragma mark - 导航栏和tabbar高度
#define BLNavHeight  64
#define BLTabbarHeight   (isIPhoneXSeries() ? (49.f + 34.f) : 49.f)

#pragma mark - 底部安全间距
#define ISiPhoneX  (isIPhoneXSeries() ? 34.f : 0.f)

#pragma mark - 释放内存
#define BLStrongSelf(self) @strongify(self);
#define BLWeakSelf(self) @unsafeify(self);

#pragma mark - 颜色
#define BLThemeStartColor BLColorA(210,105,30,1.0)
#define BLThemeEndColor BLColorA(255,218,185,1.0);
#define BLColorA(r,g,b,Alpha) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:Alpha]
#define BLColorFromRGB(rgbValue,Alpha) ([UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(Alpha)])

#pragma mark - 判断是否是iPhone X系列
#import <UIKit/UIKit.h>
static inline BOOL isIPhoneXSeries() {
    BOOL iPhoneXSeries = NO;
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return iPhoneXSeries;
    }
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        if (mainWindow.safeAreaInsets.bottom > 0.0) {
            iPhoneXSeries = YES;
        }
    }
    return iPhoneXSeries;
}
#endif /* include_h */
