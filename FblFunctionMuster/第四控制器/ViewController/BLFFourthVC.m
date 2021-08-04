//
//  BLFFourthVC.m
//  FblFunctionMuster
//
//  Created by Fanbaili on 2021/7/14.
//  Copyright © 2021 FblFunctionMuster. All rights reserved.
//

#import "BLFFourthVC.h"
#import "BLfTableviewHeaderV.h"
#import "BLfMyOrderFormV.h"

@interface BLFFourthVC ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) RACCommand *selectCommand;
@end

@implementation BLFFourthVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BLThemeEndColor;
    [self creatTableView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

#pragma mark - 创建子控件
- (void)creatTableView {
    _tableView = [[UITableView alloc]init];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = BLThemeEndColor;
    self.tableView.tableFooterView = [UIView new];
    
    UIView *headerView = [[UIView alloc]init];
    headerView.frame = CGRectMake(0, 0, BLScreenWidth, 500);
    self.tableView.tableHeaderView = headerView;

    //头部view
    BLfTableviewHeaderV *headerV = [[BLfTableviewHeaderV alloc]init];
    [headerView addSubview:headerV];
    [headerV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(headerView);
        make.height.offset(250);
    }];
    
    //我的订单view
    BLfMyOrderFormV *orderFromV = [[BLfMyOrderFormV alloc]init];
    [headerView addSubview:orderFromV];
    [orderFromV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerV.mas_bottom).offset(-20);
        make.left.offset(10);
        make.right.offset(-10);
        make.height.offset(120);
    }];
    
}

#pragma mark - tableview datasource delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = @"four cell";
    return cell;
}

#pragma mark - 监听tableview的偏移量
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y > 39) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }else {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
}

@end
