//
//  BLFViewAnimationVC.m
//  FblFunctionMuster
//
//  Created by Fanbaili on 2021/7/15.
//  Copyright © 2021 FblFunctionMuster. All rights reserved.
//

#import "BLFViewAnimationVC.h"
#import "BLFQuicklyCreateTableview.h"
#import "BLFQuicklyCreatTableviewCell.h"

@interface BLFViewAnimationVC ()
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) RACCommand *selectCommand;
@end

@implementation BLFViewAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatSubviews];
    [self clickEvent];
}

- (void)creatSubviews {
    self.view.backgroundColor = UIColor.cyanColor;
    self.title = @"视图动画";
    self.tableView = [[UITableView alloc]init];
    [self.view addSubview:_tableView];
    BLWeakSelf(self)
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        BLStrongSelf(self)
        make.edges.equalTo(self.view);
    }];
    self.dataSource = [NSMutableArray array];
    [self.dataSource addObjectsFromArray:@[@[@"充电效果",@"BLFBatteryLoadingVC"],
                                           @[@"加载动画",@"BLFProgressLoadingVC"],
                                           @[@"加载等待动画",@"BLFWaittingLoadingVC"],
                                           @[@"环形计时器动画",@"BLFRingtimingAnimationVC"],
                                           @[@"弹框封装",@"BLfTestPopViewVC"],
                                        ]];
    _selectCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [subscriber sendNext:input];
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    [BLFQuicklyCreateTableview initWithTableview:self.tableView datasouceSignal:RACObserve(self, dataSource) selectCommand:self.selectCommand templateCellNib:nil];
}

- (void)clickEvent {
    [self.selectCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        UIViewController *controller = [[NSClassFromString(self.dataSource[[x integerValue]][1]) alloc]init];
        [self.navigationController pushViewController:controller animated:YES];
    }];
}

@end
