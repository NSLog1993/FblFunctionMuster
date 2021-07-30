//
//  BLFWaittingLoadingVC.m
//  FblFunctionMuster
//
//  Created by Fanbaili on 7/16/21.
//  Copyright © 2021 FblFunctionMuster. All rights reserved.
//

#import "BLFWaittingLoadingVC.h"
#import "BLFAlternatingMotionCircleV.h"

@implementation BLFWaittingLoadingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BLThemeColor;
    [BLFAlternatingMotionCircleV showLoadingWith:self.view];
}

@end
