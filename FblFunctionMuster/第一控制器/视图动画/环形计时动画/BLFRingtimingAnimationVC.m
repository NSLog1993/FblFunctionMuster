//
//  BLFRingtimingAnimationVC.m
//  FblFunctionMuster
//
//  Created by Fanbaili on 2021/7/30.
//  Copyright © 2021 FblFunctionMuster. All rights reserved.
//

#import "BLFRingtimingAnimationVC.h"
#import "BLFRingtimingAnimationV.h"

@interface BLFRingtimingAnimationVC ()
@property (assign, nonatomic) NSInteger time;
@end

@implementation BLFRingtimingAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    BLFRingtimingAnimationV *processView = [[BLFRingtimingAnimationV alloc]initWithFrame:CGRectMake(50, 200, 300, 300)];
    processView.processTime = 10;
    [self.view addSubview:processView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
