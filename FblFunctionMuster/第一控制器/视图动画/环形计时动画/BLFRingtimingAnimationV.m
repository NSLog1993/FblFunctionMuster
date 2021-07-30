//
//  BLFRingtimingAnimationV.m
//  FblFunctionMuster
//
//  Created by Fanbaili on 2021/7/30.
//  Copyright © 2021 FblFunctionMuster. All rights reserved.
//

#import "BLFRingtimingAnimationV.h"

@implementation BLFRingtimingAnimationV
{
    NSTimer* _timer;
    UILabel* _timeLabel;
}

- (void)drawRect:(CGRect)rect {
    //[self drawDanCenngTiming];
    [self drawShuangCenngTiming];
}

#pragma mark - 绘制单层环形计时器
- (void)drawDanCenngTiming {
    //显示时间的label
    if (!_timeLabel) {
        _timeLabel = [self timeLabel:self];
    }
    _timeLabel.text = [NSString stringWithFormat:@"%ldS",(long)self.processTime];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.bounds;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2) radius:self.frame.size.height/2 startAngle:-M_PI_2 endAngle:M_PI*3/2 clockwise:1];
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 10.0f;
    //每个虚线宽度为2，间隔为3   这句设置线条为虚线，去掉即为实线
    shapeLayer.lineDashPattern = [NSArray arrayWithObjects:[NSNumber numberWithInt:2], [NSNumber numberWithInt:3], nil];
    [self.layer addSublayer:shapeLayer];
    shapeLayer.strokeColor = [UIColor colorWithRed:61/255.0f green:191/255.0f blue:135/255.0f alpha:1].CGColor;
    CABasicAnimation *pathAnima = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnima.duration = self.processTime;
    pathAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    pathAnima.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnima.toValue = [NSNumber numberWithFloat:1.0f];
    pathAnima.fillMode = kCAFillModeForwards;
    pathAnima.removedOnCompletion = NO;
    [shapeLayer addAnimation:pathAnima forKey:@"strokeEndAnimation"];
    
    BLWeakSelf(self)
    [self stopTiming];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        BLStrongSelf(self)
        if (self.processTime > 0) {
            self.processTime --;
        }
        self->_timeLabel.text = [NSString stringWithFormat:@"%ldS",(long)self.processTime];
        if (self.processTime == 0) {
            [self stopTiming];
        }
    }];

}


#pragma mark - 绘制双层环形计时器
- (void)drawShuangCenngTiming {
    //显示时间的label
    if (!_timeLabel) {
        _timeLabel = [self timeLabel:self];
    }
    _timeLabel.text = [NSString stringWithFormat:@"%ldS",(long)self.processTime];
    
    /*底层轨迹层*/
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.bounds;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2) radius:self.frame.size.height/2 startAngle:-M_PI_2 endAngle:M_PI*3/2 clockwise:1];
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 15.0f;
    //每个虚线宽度为2，间隔为4   这句设置线条为虚线，去掉即为实线
    shapeLayer.lineDashPattern = [NSArray arrayWithObjects:[NSNumber numberWithInt:2], [NSNumber numberWithInt:4], nil];
    shapeLayer.strokeColor = [BLColorA(146, 146, 146, 1.0) CGColor];
    [self.layer addSublayer:shapeLayer];

    /*上层动画层*/
    CAShapeLayer *shapeLayer2 = [CAShapeLayer layer];
    shapeLayer2.frame = self.bounds;
    UIBezierPath *path2 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2) radius:self.frame.size.height/2 startAngle:-M_PI_2 endAngle:M_PI*3/2 clockwise:1];
    shapeLayer2.path = path2.CGPath;
    shapeLayer2.fillColor = [UIColor clearColor].CGColor;
    shapeLayer2.lineWidth = 15.0f;
    //每个虚线宽度为2，间隔为4   这句设置线条为虚线，去掉即为实线
    shapeLayer2.lineDashPattern = [NSArray arrayWithObjects:[NSNumber numberWithInt:2], [NSNumber numberWithInt:4], nil];
    shapeLayer2.strokeColor = [BLColorA(61, 191, 135, 1) CGColor];
    [self.layer addSublayer:shapeLayer2];

    CABasicAnimation *pathAnima = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnima.duration = self.processTime;
    pathAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    pathAnima.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnima.toValue = [NSNumber numberWithFloat:1.0f];
    pathAnima.fillMode = kCAFillModeForwards;
    pathAnima.removedOnCompletion = NO;
    [shapeLayer2 addAnimation:pathAnima forKey:@"strokeEndAnimation"];
    
    BLWeakSelf(self)
    [self stopTiming];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        BLStrongSelf(self)
        if (self.processTime > 0) {
            self.processTime --;
        }
        self->_timeLabel.text = [NSString stringWithFormat:@"%ldS",(long)self.processTime];
        if (self.processTime == 0) {
            [self stopTiming];
        }
    }];

}

#pragma mark - 创建显示时间的Label
- (UILabel *)timeLabel:(UIView *)view {
    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectMake(0, 0, view.frame.size.width/2, view.frame.size.height/2);
    label.center = CGPointMake(view.frame.size.width/2, view.frame.size.height/2);
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:18];
    label.textColor = BLThemeColor;
    [view addSubview:label];
    return label;
}

- (void)stopTiming {
    if (_timer) {
        [_timer invalidate];
        _timer = NULL;
    }
}

- (void)dealloc {
    [self stopTiming];
}

@end
