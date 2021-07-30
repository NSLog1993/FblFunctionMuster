//
//  BLFWaterLoadingView.h
//  FblFunctionMuster
//
//  Created by Fanbaili on 2021/7/15.
//  Copyright © 2021 FblFunctionMuster. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BLFWaterLoadingView : UIView
@property (strong, nonatomic) UILabel *crossLabel;
@property (strong, nonatomic) UILabel *topLabel;
@property (strong, nonatomic) UILabel *bottomLabel;
@property (assign, nonatomic) CGFloat speed;//波纹的速度
@property (assign, nonatomic) CGFloat waveHeight;//波纹的高度
@property (assign, nonatomic) CGFloat waveNum;//波纹的数量
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title font:(UIFont *)font showLoadNote:(BOOL)show;
- (void)wave;
- (void)stopWave;
@end

NS_ASSUME_NONNULL_END
