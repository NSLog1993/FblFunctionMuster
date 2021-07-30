//
//  BLFQuicklyCreatTableviewCell.m
//  FblFunctionMuster
//
//  Created by Fanbaili on 2021/7/14.
//  Copyright © 2021 FblFunctionMuster. All rights reserved.
//

#import "BLFQuicklyCreatTableviewCell.h"

@implementation BLFQuicklyCreatTableviewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.detailTextLabel.text = @"123";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
