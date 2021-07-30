//
//  BLfAlertLabel.m
//  FblFunctionMuster
//
//  Created by Fanbaili on 2021/7/30.
//  Copyright © 2021 FblFunctionMuster. All rights reserved.
//
#import "BLfAlertView.h"

@implementation BLfAlertView

+ (void)showTextAlert:(NSString *)string withView:(UIView *)view {
    UILabel *textLabel = [[UILabel alloc]init];
    textLabel.backgroundColor = UIColor.blackColor;
    textLabel.textColor = UIColor.whiteColor;
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.font = [UIFont systemFontOfSize:16];
    textLabel.layer.cornerRadius = 5;
    textLabel.clipsToBounds = YES;
    textLabel.numberOfLines = 1;
    textLabel.text = string;
    CGFloat w = view.frame.size.width;
    CGFloat h = view.frame.size.height;
    textLabel.frame = CGRectMake(w/6, h - 100, w/3 * 2 , 50);
    [view addSubview:textLabel];
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        textLabel.alpha = 0.8;
        } completion:^(BOOL finished) {
        }];
    [UIView animateWithDuration:3.0 animations:^{
        textLabel.alpha = 0;
        } completion:^(BOOL finished) {
            [textLabel removeFromSuperview];
        }];
}
@end
