//
//  BLFQuicklyCreate.h
//  FblFunctionMuster
//
//  Created by Fanbaili on 2021/7/14.
//  Copyright © 2021 FblFunctionMuster. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BLFQuicklyCreateTableview : NSObject
@property (strong, nonatomic) id<UITableViewDelegate>   tableviewDelegate;
@property (strong, nonatomic) id<UITableViewDataSource> tableviewDatasource;
+ (instancetype)initWithTableview:(UITableView *)tableview
                        datasouceSignal:(RACSignal *)datasourceSignal
                    selectCommand:(RACCommand *)selectCommand
                  templateCellNib:(nullable UINib *)templateCellNib ;
@end

NS_ASSUME_NONNULL_END
