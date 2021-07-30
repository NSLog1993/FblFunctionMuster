//
//  BLFAlternatingMotionCircleV.m
//  FblFunctionMuster
//
//  Created by Fanbaili on 7/16/21.
//  Copyright © 2021 FblFunctionMuster. All rights reserved.
//

#import "BLFAlternatingMotionCircleV.h"

@interface BLFAlternatingMotionCircleV ()<CAAnimationDelegate>
@property (nonatomic,weak)UIView *round1;
@property (nonatomic,weak)UIView *round2;
@property (nonatomic,weak)UIView *round3;

@property (nonatomic,strong)UIColor *round1Color;
@property (nonatomic,strong)UIColor *round2Color;
@property (nonatomic,strong)UIColor *round3Color;

@property (nonatomic,assign)CGFloat animRepeatTime;
@property (nonatomic,assign)CGFloat animTime;
@end

@implementation BLFAlternatingMotionCircleV
//显示加载动画在指定的view上
+ (BLFAlternatingMotionCircleV *)showLoadingWith:(UIView *)view {
    BLFAlternatingMotionCircleV *loadingView = [[BLFAlternatingMotionCircleV alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
    [view addSubview:loadingView];
    return loadingView;
}


//显示加载动画在指定的window上
+ (BLFAlternatingMotionCircleV *)showLoadingWithWindow {
    UIWindow *window = [UIApplication sharedApplication].windows.lastObject;
    BLFAlternatingMotionCircleV *loadingView = [[BLFAlternatingMotionCircleV alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height)];
    [window addSubview:loadingView];
    return loadingView;
}

//可以手动调用隐藏动画
- (void)hideLoadingView {
    [_round1.layer removeAllAnimations];
    [_round2.layer removeAllAnimations];
    [_round3.layer removeAllAnimations];
    [self removeFromSuperview];
}


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self)
    {
        _round1Color = [UIColor colorWithRed:206/255.0 green:7/255.0 blue:85/255.0 alpha:1.0];
        _round2Color = [UIColor colorWithRed:206/255.0 green:7/255.0 blue:85/255.0 alpha:0.6];
        _round3Color = [UIColor colorWithRed:206/255.0 green:7/255.0 blue:85/255.0 alpha:0.3];
        
        _animTime = 1.5;
        _animRepeatTime = 50;
        
        //宽高都是10
        CGFloat width = 10;
        UIView *round1 = [[UIView alloc] init];
        CGRect round1Frame = round1.frame;
        [round1 setFrame:CGRectMake(round1Frame.origin.x, round1Frame.origin.y, width, width)];
        round1.backgroundColor = _round1Color;
        round1.layer.cornerRadius = round1.frame.size.height / 2;
        
        
        UIView *round2 = [[UIView alloc] init];
        CGRect round2Frame = round1.frame;
        [round2 setFrame:CGRectMake(round2Frame.origin.x, round2Frame.origin.y, width, width)];
        round2.backgroundColor = _round2Color;
        round2.layer.cornerRadius = round2.frame.size.height / 2;
        
        
        UIView *round3 = [[UIView alloc] init];
        CGRect round3Frame = round1.frame;
        [round3 setFrame:CGRectMake(round3Frame.origin.x, round3Frame.origin.y, width, width)];
        round3.backgroundColor = _round2Color;
        round3.layer.cornerRadius = round2.frame.size.height / 2;
        
        [self addSubview:round1];
        [self addSubview:round2];
        [self addSubview:round3];

        [round2 setCenter:CGPointMake(self.center.x,self.center.y)];
        [round1 setCenter:CGPointMake(self.center.x-20,self.center.y-20)];
        [round3 setCenter:CGPointMake(self.center.x+20,self.center.y)];
       
        _round1 = round1;
        _round2 = round2;
        _round3 = round3;
        
        [self startAnim];
    }
    
    return self;
}


- (void)startAnim {
    CGPoint otherRoundCenter1 = CGPointMake(_round1.center.x+10, _round2.center.y);
    CGPoint otherRoundCenter2 = CGPointMake(_round2.center.x+10, _round2.center.y);
    //圆1的路径
    UIBezierPath *path1 = [[UIBezierPath alloc] init];
    [path1 addArcWithCenter:otherRoundCenter1 radius:10 startAngle:-M_PI endAngle:0 clockwise:true];
    UIBezierPath *path1_1 = [[UIBezierPath alloc] init];
    [path1_1 addArcWithCenter:otherRoundCenter2 radius:10 startAngle:-M_PI endAngle:0 clockwise:false];
    [path1 appendPath:path1_1];
    
    [self viewMovePathAnimWith:_round1 path:path1 andTime:_animTime];
    [self viewColorAnimWith:_round1 fromColor:_round1Color toColor:_round3Color andTime:_animTime];
    
    UIBezierPath *path2 = [[UIBezierPath alloc] init];
    [path2 addArcWithCenter:otherRoundCenter1 radius:10 startAngle:0 endAngle:-M_PI clockwise:true];
    [self viewMovePathAnimWith:_round2 path:path2 andTime:_animTime];
    [self viewColorAnimWith:_round2 fromColor:_round2Color toColor:_round1Color andTime:_animTime];
    
    UIBezierPath *path3 = [[UIBezierPath alloc] init];
    [path3 addArcWithCenter:otherRoundCenter2 radius:10 startAngle:0 endAngle:-M_PI clockwise:false];
    [self viewMovePathAnimWith:_round3 path:path3 andTime:_animTime];
    [self viewColorAnimWith:_round3 fromColor:_round3Color toColor:_round1Color andTime:_animTime];
}

///设置view的移动路线，这样抽出来因为每个圆的只有路径不一样
- (void)viewMovePathAnimWith:(UIView *)view path:(UIBezierPath *)path andTime:(CGFloat)time {
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    anim.path = [path CGPath];
    anim.removedOnCompletion = false;
    anim.fillMode = kCAFillModeForwards;
    anim.calculationMode = kCAAnimationCubic;
    anim.repeatCount = _animRepeatTime;
    anim.duration = time;
    anim.autoreverses = NO;
    anim.delegate = self;
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [view.layer addAnimation:anim forKey:@"animation"];
}

///设置view的颜色动画
- (void)viewColorAnimWith:(UIView *)view fromColor:(UIColor *)fromColor toColor:(UIColor *)toColor andTime:(CGFloat)time {
    CABasicAnimation *colorAnim = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    colorAnim.toValue = (__bridge id _Nullable)([toColor CGColor]);
    colorAnim.fromValue = (__bridge id _Nullable)([fromColor CGColor]);
    colorAnim.duration = time;
    colorAnim.autoreverses = NO;
    colorAnim.fillMode = kCAFillModeForwards;
    colorAnim.removedOnCompletion = NO;
    colorAnim.repeatCount = _animRepeatTime;
    [view.layer addAnimation:colorAnim forKey:@"backgroundColor"];
}

- (void)layoutSubviews {
    [super layoutSubviews];    
    [_round2 setCenter:CGPointMake(self.center.x, self.center.y)];
    [_round1 setCenter:CGPointMake(_round2.center.x - 20, _round2.center.y - 20)];
    [_round1 setCenter:CGPointMake(_round2.center.x + 20, _round2.center.y)];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [_round1.layer removeAllAnimations];
    [_round2.layer removeAllAnimations];
    [_round3.layer removeAllAnimations];
    [self removeFromSuperview];
}

@end
