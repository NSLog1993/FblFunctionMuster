//
//  BLFQuicklyCreate.m
//  FblFunctionMuster
//
//  Created by Fanbaili on 2021/7/14.
//  Copyright © 2021 FblFunctionMuster. All rights reserved.
//

#import "BLFQuicklyCreateTableview.h"

@interface BLFQuicklyCreateTableview ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView       *tableView;
@property (strong, nonatomic) NSMutableArray    *dataArray;
@property (strong, nonatomic) RACCommand        *selectCommand;
@property (strong, nonatomic) UITableViewCell   *templateCell;
@property (strong, nonatomic) NSString          *reuseIdentifier;
@end

@implementation BLFQuicklyCreateTableview

- (instancetype)initWithTableview:(UITableView *)tableview
                        datasouceSignal:(RACSignal *)datasourceSignal
                    selectCommand:(RACCommand *)selectCommand
                  templateCellNib:(nullable UINib *)templateCellNib {
    self = [super init];
    if (self) {
        self.tableView = tableview;
        self.selectCommand = selectCommand;
        [datasourceSignal subscribeNext:^(id  _Nullable x) {
            self.dataArray = x;
            [self.tableView reloadData];
        }];
        _reuseIdentifier = @"reuseIdentifier";
        if (templateCellNib != nil) {
            self.templateCell = [[templateCellNib instantiateWithOwner:nil options:nil] firstObject];
            _reuseIdentifier = self.templateCell.reuseIdentifier;
            [self.tableView registerNib:templateCellNib forCellReuseIdentifier:self.reuseIdentifier];
        }
        self.tableView.delegate = self;
        self.tableView.dataSource =self;
        self.tableView.tableFooterView = [UIView new];
        self.tableView.backgroundColor = BLColorA(255,218,185,1.0);
    }
    return self;
}

+ (instancetype)initWithTableview:(UITableView *)tableview
                        datasouceSignal:(RACSignal *)datasourceSignal
                    selectCommand:(RACCommand *)selectCommand
                  templateCellNib:(nullable UINib *)templateCellNib {
    return [[BLFQuicklyCreateTableview alloc]initWithTableview:tableview datasouceSignal:datasourceSignal selectCommand:selectCommand templateCellNib:templateCellNib];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.reuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:self.reuseIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor = BLColorA(255,218,185,1.0);
    cell.textLabel.text = self.dataArray[indexPath.row][0];
    cell.detailTextLabel.text = self.dataArray[indexPath.row][1];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self.selectCommand execute:@(indexPath.row)];
    if ([self.tableviewDelegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
      [self.tableviewDelegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.tableviewDelegate respondsToSelector:@selector(tableView:didDeselectRowAtIndexPath:)]) {
      [self.tableviewDelegate tableView:tableView didDeselectRowAtIndexPath:indexPath];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return 60;
}
@end
