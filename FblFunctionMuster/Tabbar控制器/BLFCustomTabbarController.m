//
//  BLFCustomTabbarController.m
//  FblFunctionMuster
//
//  Created by Fanbaili on 2021/7/13.
//  Copyright © 2021 FblFunctionMuster. All rights reserved.
//

#import "BLFCustomTabbarController.h"
#import "BLFFirstVC.h"
#import "BLFSecondVC.h"
#import "BLFThirdVC.h"
#import "BLFFourthVC.h"

@interface BLFCustomTabbarController ()
@property (strong, nonatomic) NSArray *controllerNameArray;
@property (strong, nonatomic) NSMutableArray<BLFParticleAnimationButton *> *baritemArray;
@end

@implementation BLFCustomTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self settingTabbarController];
    [BLFCustomTabbarController initialize];
}

#pragma mark - 添加所有控制器
- (void)settingTabbarController {
    //当前选中的为第一个控制器
    self.selectedIndex = 0;
    
    //创建四个item按钮
    _baritemArray = [NSMutableArray array];
    for (NSInteger i = 0; i < 4; i++) {
        BLFParticleAnimationButton *btn = [[BLFParticleAnimationButton alloc]init];
        btn.tag = i;
        [_baritemArray addObject:btn];
    }
    BLWeakSelf(self)
    [RACObserve(self, selectedIndex) subscribeNext:^(id  _Nullable x) {
        BLStrongSelf(self)
        [self indexChange];
    }];
    //第1个控制器
    [self addChildVc:[[BLFFirstVC alloc] init] title:@"第1个" image:@"nil" selectedImage:@"nil"];
    
    //第2个控制器
    [self addChildVc:[[BLFSecondVC alloc] init] title:@"第2个" image:@"nil" selectedImage:@"nil"];
    
    //第3个控制器
    [self addChildVc:[[BLFThirdVC alloc] init] title:@"第3个" image:@"nil" selectedImage:@"nil"];
    
    //第4个控制器
    [self addChildVc:[[BLFFourthVC alloc] init] title:@"第4个" image:@"nil" selectedImage:@"nil"];
    
    _controllerNameArray = @[@"第1个",@"第2个",@"第3个",@"第4个"];
}



#pragma mark - 创建自控制器方法
/**
 *  添加一个子控制器
 *
 *  @param childVc       子控制器
 *  @param title         标题
 *  @param image         图片
 *  @param selectedImage 选中的图片
 */
- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    // 设置Tabbar的标题
    childVc.tabBarItem.title = title;
    // 设置子控制器的图片
    childVc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //未选中字体颜色  system为系统字体
    [childVc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor],NSFontAttributeName:[UIFont systemFontOfSize:8.0]} forState:UIControlStateNormal];
    
    //选中字体颜色
    [childVc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:14]} forState:UIControlStateSelected];
    
    [self addChildViewController:childVc];
    // 先给外面传进来的小控制器 包装 一个导航控制器
    BLCustomNavigationController *nav = [[BLCustomNavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
}


#pragma mark - 可以在此方法中自定义tabbarButton的样式
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.tabBar.subviews enumerateObjectsUsingBlock:^(__kindof UIControl * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            BOOL exsite = NO;
            for (UIView * obj1 in obj.subviews) {
                if ([obj1 isKindOfClass:[UIButton class]]) {
                    exsite = YES;
                }
            }
            if (exsite == NO) {
                CGFloat itemCount = 4.0;
                BLFParticleAnimationButton *btn = self.baritemArray[idx];
                btn.frame = CGRectMake(0, 0, self.tabBar.frame.size.width/itemCount, obj.frame.size.height);
                btn.layer.cornerRadius = 10;
                btn.layer.masksToBounds = YES;
                if (idx >= self.controllerNameArray.count) {
                    idx = 0;
                }
                [btn setTitle:self.controllerNameArray[idx] forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:14];
                [btn setTitleColor:UIColor.blackColor forState:UIControlStateSelected];
                [btn setTitleColor:BLColorA(128, 0, 0, 1.0) forState:UIControlStateNormal];
                btn.backgroundColor = UIColor.clearColor;
                [obj addSubview:btn];
                [btn addTarget:self action:@selector(tabBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            }
        }
    }];
    [self indexChange];
}


#pragma mark - 自定义Button的点击事件
- (void)tabBarButtonClick:(BLFParticleAnimationButton *)sender {
    [self tabBar:self.tabBar didSelectItem:self.tabBar.items[sender.tag]];
    [sender beganAnimation];
}

- (void)indexChange {
    for (BLFParticleAnimationButton *btn in _baritemArray) {
        if (btn.tag == self.selectedIndex) {
            btn.selected = YES;
        } else {
            btn.selected = NO;
        }
    }
}

#pragma mark - 当前点击的控制器索引
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    NSInteger index = [tabBar.items indexOfObject:item];
    if (self.selectedIndex == index) {
        [BLfAlertView showTextAlert:@"请不要重复选择控制器" withView:self.view];
    }
    self.selectedIndex = index;
}

#pragma mark - 类的初始化方法，只有第一次使用类的时候会调用一次该方法
+ (void)initialize {
    //设置tabbar的颜色属性
    [[UITabBar appearance] setBackgroundImage:[UIImage imageWithColor:BLColorA(210,105,30,1.0)]];
    [[UITabBar appearance] setShadowImage:[UIImage imageWithColor:UIColor.redColor]];
    [[UITabBar appearance] setBarTintColor:[UIColor blueColor]];
}
@end
