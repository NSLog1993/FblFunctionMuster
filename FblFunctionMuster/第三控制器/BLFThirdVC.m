//
//  BLFThirdVC.m
//  FblFunctionMuster
//
//  Created by Fanbaili on 2021/7/14.
//  Copyright © 2021 FblFunctionMuster. All rights reserved.
//

#import "BLFThirdVC.h"
#import "BLFQuicklyCreateTableview.h"
#import "BLFQuicklyCreatTableviewCell.h"

@interface BLFThirdVC ()
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) RACCommand *selectCommand;
@end

@implementation BLFThirdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatSubviews];
    [self clickEvent];
}

- (void)creatSubviews {
    self.view.backgroundColor = UIColor.cyanColor;
    self.navigationItem.title = @"第三个";
    self.tableView = [[UITableView alloc]init];
    [self.view addSubview:_tableView];
    BLWeakSelf(self)
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        BLStrongSelf(self)
        make.edges.equalTo(self.view);
    }];
    self.dataSource = [NSMutableArray array];
    [self.dataSource addObjectsFromArray:@[@[@"3",@"3",@"3",@"3",@"3",@"3",@"3",@"3",@"3",@"3"]]];
    _selectCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [subscriber sendNext:input];
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    UINib *nib = [UINib nibWithNibName:@"BLFQuicklyCreatTableviewCell" bundle:nil];
    [BLFQuicklyCreateTableview initWithTableview:self.tableView datasouceSignal:RACObserve(self, dataSource) selectCommand:self.selectCommand templateCellNib:nib];
}

- (void)clickEvent {
    [self.selectCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"------>>%@",x);
        [BLfAlertView showTextAlert:@"未获取到数据" withView:self.view];
    }];
}
@end
