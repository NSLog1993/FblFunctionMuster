//
//  BLCustomNavigationController.m
//  FblFunctionMuster
//
//  Created by Fanbaili on 2021/7/13.
//  Copyright © 2021 FblFunctionMuster. All rights reserved.
//

#import "BLCustomNavigationController.h"

@interface BLCustomNavigationController ()

@end

@implementation BLCustomNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self gradientNavigation];
}

+ (void)initialize {
    //appearance方法返回一个导航栏的外观对象
    //修改了这个外观对象，相当于修改了整个项目中的外观
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    //设置NavigationBarItem文字的颜色
    [navigationBar setTintColor:[UIColor whiteColor]];
    //设置标题栏颜色
    navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : BLColorA(128, 0, 0, 1.0), NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:18]};
    
    /*
     //设置导航栏文字的主题
     NSShadow *shadow = [[NSShadow alloc]init];
     [shadow setShadowOffset:CGSizeZero];
     [navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],NSShadowAttributeName : shadow}];
     [navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation_back_normal"] forBarMetrics:UIBarMetricsDefault];
     //修改所有UIBarButtonItem的外观
     UIBarButtonItem *barButtonItem = [UIBarButtonItem appearance];
     
     // 修改item的背景图片
     //[barItem setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
     //[barItem setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background_pushed.png"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
     //修改item上面的文字样式
     NSDictionary *dict =@{NSForegroundColorAttributeName : [UIColor whiteColor],NSShadowAttributeName : shadow};
     [barButtonItem setTitleTextAttributes:dict forState:UIControlStateNormal];
     [barButtonItem setTitleTextAttributes:dict forState:UIControlStateHighlighted];
     //修改返回按钮样式
     [barButtonItem setBackButtonBackgroundImage:[UIImage imageNamed:NAVIGATION_BAR_BACK_ICON_NAME] forState:UIControlStateNormal barMetrics:UIBarMetricsCompact];
     //设置状态栏样式
     [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
     */
}

#pragma mark -- 渐变色样式导航栏
- (void)gradientNavigation {
    CGRect frame = CGRectMake(0, 0,BLScreenWidth, BLNavHeight);
    UIImageView *imgview = [[UIImageView alloc]initWithFrame:frame];
    UIGraphicsBeginImageContext(imgview.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    CGContextScaleCTM(context, frame.size.width, frame.size.height);
    CGFloat colors[] = {
        210.0/255.0, 105.0/255.0, 30.0/255.0, 1.0,
        244.0/255.0, 164/255.0, 96/255.0, 1.0,
        255/255.0, 218/255.0, 185/255.0, 1.0,
    };
    /*
     *第一个参数：颜色空间
     *第二个参数：CGFloat数组，指定渐变的开始颜色，终止颜色，以及过度色（如果有的话）
     *第三个参数：指定每个颜色在渐变色中的位置，值介于0.0-1.0之间
     *                      0.0表示最开始的位置，1.0表示渐变结束的位置
     *第四个参数：渐变中使用的颜色数
     */
    CGGradientRef backGradient = CGGradientCreateWithColorComponents(rgb, colors, NULL, sizeof(colors)/(sizeof(colors[0])*4));
    CGColorSpaceRelease(rgb);
    //设置颜色渐变的方向，范围在(0,0)与(1.0,1.0)之间，如(0,0)(1.0,0)代表水平方向渐变,(0,0)(0,1.0)代表竖直方向渐变
    CGContextDrawLinearGradient(context, backGradient, CGPointMake(0, 0), CGPointMake(1.0, 0), kCGGradientDrawsBeforeStartLocation);
    UINavigationBar *bar =  [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[self class]]];
    [bar setBackgroundImage:UIGraphicsGetImageFromCurrentImageContext()  forBarMetrics:UIBarMetricsDefault];
}


/**可以再这个方法拦截所有push进来的控制器*/
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count > 0) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"" forState: UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigation_back_normal"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigation_back_select"] forState:UIControlStateHighlighted];
        [button setFrame:CGRectMake(0,0, 25, 25)];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        button.contentEdgeInsets = UIEdgeInsetsMake(10, 0, 10, 30);
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
    
}

- (void)back {
    [self popViewControllerAnimated:YES];
}

- (void)dealloc {
    NSLog(@"---->>dealloc:%s",__func__);
}
@end
