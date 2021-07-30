//
//  UIImage+BLFImageExtension.h
//  FblFunctionMuster
//
//  Created by Fanbaili on 2021/7/14.
//  Copyright © 2021 FblFunctionMuster. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (BLFImageExtension)
- (UIImage*)imageWithColor:(UIColor*)color;
    
+ (UIImage *)imageWithColor:(UIColor *)color;
    
- (UIImage *)rs_disable;

+ (UIImage *)rs_imageWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor;

+ (UIImage*)originImage:(UIImage*)image scaleToSize:(CGSize)size;
@end

NS_ASSUME_NONNULL_END
