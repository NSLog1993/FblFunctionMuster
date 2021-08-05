//
//  RSEncryptDataBase.h
//  CamView Plus
//
//  Created by Fanbaili on 2021/8/3.
//  Copyright © 2021 lovingc2009. All rights reserved.
//

#import <FMDB/FMDB.h>

NS_ASSUME_NONNULL_BEGIN

@interface BLfSQLCipherEncryptDataBase : FMDatabase
/** 如果需要自定义encryptkey，可以调用这个方法修改（在使用之前）*/
+ (void)setEncryptKey:(NSString *)encryptKey;
@end

NS_ASSUME_NONNULL_END
