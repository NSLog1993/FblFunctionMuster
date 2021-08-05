//
//  RSEncryptDataBase.m
//  CamView Plus
//
//  Created by Fanbaili on 2021/8/3.
//  Copyright © 2021 lovingc2009. All rights reserved.
//

#import "BLfSQLCipherEncryptDataBase.h"

@implementation BLfSQLCipherEncryptDataBase
static NSString *_encryptKey;

+ (void)initialize
{
    [super initialize];
    //初始化数据库加密key，在使用之前可以通过 setEncryptKey 修改
    _encryptKey = @"fbl123456";
}

#pragma mark - 重载原来方法
- (BOOL)open {
    BOOL result = [super open];
    [self setKey:_encryptKey];
    return result;
}

- (BOOL)openWithFlags:(int)flags {
    BOOL result = [super openWithFlags:flags];
    [self setKey:_encryptKey];
    return result;
}

- (BOOL)openWithFlags:(int)flags vfs:(NSString *)vfsName {
    BOOL result = [super openWithFlags:flags vfs:vfsName];
    [self setKey:_encryptKey];
    return result;
}

#pragma mark - 配置解密Key方法
+ (void)setEncryptKey:(NSString *)encryptKey
{
    _encryptKey = encryptKey;
}

@end
