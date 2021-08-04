//
//  BLfVerticalButton.m
//  FblFunctionMuster
//
//  Created by Fanbaili on 2021/8/2.
//  Copyright © 2021 FblFunctionMuster. All rights reserved.
//

#import "BLfVerticalButton.h"

@implementation BLfVerticalButton

- (void)setup {
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    // UIImage *image = [UIImage imageNamed:@"2-1.png"];
    self.imageView.image = [self imageForState:UIControlStateNormal];
    //self.imageView.image = image;
    self.imageView.backgroundColor = [UIColor redColor];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}


-(void)layoutSubviews {
    //调整图片
    self.imageView.frame = CGRectMake(0,
                                      0,
                                      self.frame.size.width,
                                      self.imageView.frame.size.width);
    
    //调整文字
    self.titleLabel.frame = CGRectMake(0,
                                       self.imageView.frame.size.height,
                                       self.frame.size.width,
                                       self.frame.size.height - self.imageView.frame.size.height);
}
@end
