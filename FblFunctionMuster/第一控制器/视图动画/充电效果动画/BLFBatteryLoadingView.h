//
//  BLFBatteryLoadingView.h
//  FblFunctionMuster
//
//  Created by Fanbaili on 2021/7/15.
//  Copyright © 2021 FblFunctionMuster. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,BatteryState) {
    BatteryStateNormal = 0,     //  正常状态
    BatteryStateCharging = 1,   //  充电状态
};

typedef NS_ENUM(NSInteger,TextStyle) {
    TextStyleHide = 0,     // 不显示电量百分比
    TextStyleTop = 1,     //  在电池上面显示电量百分比
    TextStyleBottom = 2,   //  在电池下面显示电量百分比
    TextStyleCenter = 3,    //  在电池中间显示电量百分比
};
@interface BLFBatteryLoadingView : UIView
@property (nonatomic ,assign) BatteryState batteryState;
@property (nonatomic ,assign) TextStyle textStyle;
@end

NS_ASSUME_NONNULL_END
