//
//  BLfPopView.h
//  FblFunctionMuster
//
//  Created by Fanbaili on 2021/7/30.
//  Copyright © 2021 FblFunctionMuster. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
//取消按钮点击事件
typedef void(^cancelBlock)(void);
//确定按钮点击事件
typedef void(^sureBlock)(void);

@interface BLfPopView : UIView
@property(nonatomic,copy)cancelBlock cancel_block;
@property(nonatomic,copy)sureBlock sure_block;

@end

NS_ASSUME_NONNULL_END
