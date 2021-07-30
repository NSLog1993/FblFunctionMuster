//
//  BLFParticleAnimationButton.m
//  FblFunctionMuster
//
//  Created by Fanbaili on 2021/7/13.
//  Copyright © 2021 FblFunctionMuster. All rights reserved.
//

#import "BLFParticleAnimationButton.h"

@interface BLFParticleAnimationButton ()
@property (nonatomic, strong) CALayer   *movedMask;
@property (nonatomic, strong) NSTimer   *timer;
@property (strong, nonatomic) NSMutableArray *cellArray;
@property (strong, nonatomic) CAEmitterLayer *emitter;
@end

@implementation BLFParticleAnimationButton

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

//-(void)setCanMoveMultipleEmitter{
//    // 创建粒子Layer
//    CAEmitterLayer *snowEmitter = [CAEmitterLayer layer];
//    // 粒子发射位置
//    snowEmitter.emitterPosition = CGPointMake(CGRectGetWidth(self.bounds) / 2.f,0);
//    // 发射源的尺寸大小
//    snowEmitter.emitterSize     = self.bounds.size;
//    // 发射模式
//    snowEmitter.emitterMode     = kCAEmitterLayerSurface;
//    // 发射源的形状
//    snowEmitter.emitterShape    = kCAEmitterLayerLine;
//    snowEmitter.shadowOpacity = 1.0;
//    snowEmitter.shadowRadius  = 0.0;
//    snowEmitter.shadowOffset  = CGSizeMake(0.0, 0.0);
//    // 粒子边缘的颜色
//    snowEmitter.shadowColor  = [[UIColor whiteColor] CGColor];
//    // 将粒子Layer添加进图层中
//    [self.layer addSublayer:snowEmitter];
//
//    // 创建雪花类型的粒子
//    CAEmitterCell *snowflake    = [CAEmitterCell emitterCell];
//    // 粒子的名字
//    snowflake.name = @"snow";
//    // 粒子参数的速度乘数因子
//    snowflake.birthRate = 20.0;
//    // 粒子生命周期
//    snowflake.lifetime  = 120.0;
//    // 粒子速度
//    snowflake.velocity  = 10.0;
//    // 粒子的速度范围
//    snowflake.velocityRange = 10;
//    // 粒子y方向的加速度分量
//    snowflake.yAcceleration = 2;
//    // 周围发射角度
//    snowflake.emissionRange = 0.5 * M_PI;
//    // 子旋转角度范围
//    snowflake.spinRange = 0.25 * M_PI;
//    snowflake.contents  = (id)[[UIImage imageNamed:@"button_animation"] CGImage];
//    // 设置雪花形状的粒子的颜色
//    snowflake.color      = [[UIColor whiteColor] CGColor];
//    snowflake.redRange   = 2.f;
//    snowflake.greenRange = 2.f;
//    snowflake.blueRange  = 2.f;
//    snowflake.scaleRange = 0.6f;
//    snowflake.scale      = 0.7f;
//    // 添加粒子
//    snowEmitter.emitterCells = @[snowflake];
//    // 形成遮罩
//    UIImage *image      = [UIImage imageNamed:@"alpha"];
//    _movedMask          = [CALayer layer];
//    _movedMask.frame    = (CGRect){CGPointZero, image.size};
//    _movedMask.contents = (__bridge id)(image.CGImage);
//    _movedMask.position = self.center;
//    snowEmitter.mask    = _movedMask;
//
//    // 拖拽的View
//    UIView *dragView = [[UIView alloc] initWithFrame:_movedMask.frame];
//    [self addSubview:dragView];
//    // 给dragView添加拖拽手势
//    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
//    [dragView addGestureRecognizer:recognizer];
//}
//
//- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
//    // 拖拽
//    CGPoint translation    = [recognizer translationInView:self];
//    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
//                                         recognizer.view.center.y + translation.y);
//    [recognizer setTranslation:CGPointMake(0, 0) inView:self];
//    // 关闭CoreAnimation实时动画绘制(核心)
//    [CATransaction setDisableActions:YES];
//    _movedMask.position = recognizer.view.center;
//}

//完整粒子效果
-(void)setMultipleEmitterCell{
        // 1.创建发射器
    if (!_emitter) {
        _emitter = [[CAEmitterLayer alloc]init];
    }
    
    // 2.设置发射器的位置
    self.emitter.emitterPosition = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    
    // 3.开启三维效果
    self.emitter.preservesDepth = YES;
    //创建多个粒子
    if (!_cellArray) {
        self.cellArray = [NSMutableArray array];
    }
    for (int i = 0 ; i < 9; i++) {
        CAEmitterCell *cell = [[CAEmitterCell alloc]init];
        //设置颜色
        cell.color = [UIColor colorWithRed:0.9 green:1.0 blue:1.0 alpha:1.0].CGColor;
        cell.redRange   = 2.f;
        cell.greenRange = 2.f;
        cell.blueRange  = 2.f;
        
        //粒子大小
        cell.scaleRange = 5.0f;
        cell.scale      = 1.0f;
        
        //粒子速度
        cell.velocity = 20;
        cell.velocityRange = 10;
        
        //粒子发射角度
        cell.emissionRange = M_PI * 2;
        
        // 粒子生命周期
        cell.lifetime = 1.0;
        cell.lifetimeRange = 1.5;
        
        //粒子旋转角度范围
        cell.spin = M_PI_2;
        cell.spinRange = M_PI_2 ;
        
        //粒子参数的速度乘数因子
        cell.birthRate = 20;
        
        cell.contents = (__bridge id _Nullable)([UIImage imageNamed:[NSString stringWithFormat:@"button_animation"]].CGImage);
        
        //将创建出来的cell加入到数组中
        [self.cellArray addObject:cell];
    }
    // 5.将粒子设置到发射器中
    self.emitter.emitterCells = self.cellArray;
    
    // 6.将发射器的layer添加到父layer中
    [self.layer addSublayer:self.emitter];
}

- (void)beganAnimation {
    [self stopTimer];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(stopAnimations) userInfo:nil repeats:YES];
    if (self) {
        [self setMultipleEmitterCell];
    } else {
        NSLog(@"self 为空!!!!");
    }
}

- (void)stopAnimations {
    [self stopTimer];
    [self.cellArray removeAllObjects];
    [self.layer removeAllAnimations];
    [self.emitter removeFromSuperlayer];
}

- (void)stopTimer {
    if (self.timer != nil) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)dealloc {
    [self stopTimer];
    NSLog(@"---->>dealloc%s",__func__);
}
@end
