//
//  BLFFourthVC.m
//  FblFunctionMuster
//
//  Created by Fanbaili on 2021/7/14.
//  Copyright © 2021 FblFunctionMuster. All rights reserved.
//

#import "BLFFourthVC.h"
#import "BLFQuicklyCreateTableview.h"
#import "BLFQuicklyCreatTableviewCell.h"


@interface BLFFourthVC ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) RACCommand *selectCommand;
@end

@implementation BLFFourthVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BLThemeEndColor;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

#pragma mark - 创建tableView
- (void)creatTableView {
    _tableView = [[UITableView alloc]init];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

#pragma mark - tableview datasource delegate
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    return cell;
}

@end
