//
//  RSSQLCipherEncryptDataBaseHelper.m
//  CamView Plus
//
//  Created by Fanbaili on 2021/8/3.
//  Copyright © 2021 lovingc2009. All rights reserved.
//

#import "BLfSQLCipherEncryptDataBaseHelper.h"
#import <sqlite3.h>

@implementation BLfSQLCipherEncryptDataBaseHelper

static NSString *encryptKey_;

 + (void)initialize {
    encryptKey_ = @"fbl123456";
}

#pragma mark - 对数据库加密（文件不变）
+ (BOOL)encryptDatabase:(NSString *)path {
    NSString *sourcePath = path;
    NSString *targetPath = [NSString stringWithFormat:@"%@.tmp.db", path];
    
    if([self encryptDatabase:sourcePath targetPath:targetPath]) {
        NSFileManager *fm = [[NSFileManager alloc] init];
        [fm removeItemAtPath:sourcePath error:nil];
        [fm moveItemAtPath:targetPath toPath:sourcePath error:nil];
        return YES;
    } else {
        return NO;
    }
}
 
#pragma mark - 对数据库解密（文件不变）
+ (BOOL)unEncryptDatabase:(NSString *)path {
    NSString *sourcePath = path;
    NSString *targetPath = [NSString stringWithFormat:@"%@.tmp.db", path];
    
    if([self unEncryptDatabase:sourcePath targetPath:targetPath]) {
        NSFileManager *fm = [[NSFileManager alloc] init];
        [fm removeItemAtPath:sourcePath error:nil];
        [fm moveItemAtPath:targetPath toPath:sourcePath error:nil];
        return YES;
    } else {
        return NO;
    }
}
 
#pragma mark - 对数据库加密
+ (BOOL)encryptDatabase:(NSString *)sourcePath targetPath:(NSString *)targetPath {
    //给未加密数据库添加加密的附属数据库
    const char* sqlQ = [[NSString stringWithFormat:@"ATTACH DATABASE '%@' AS encrypted KEY '%@';", targetPath, encryptKey_] UTF8String];
    sqlite3 *unencrypted_DB;
    if (sqlite3_open([sourcePath UTF8String], &unencrypted_DB) == SQLITE_OK) {
        // Attach empty encrypted database to unencrypted database
        sqlite3_exec(unencrypted_DB, sqlQ, NULL, NULL, NULL);
        //begin exclusive transaction，begin deferred transaction（延迟事务）
        //处理数据量比较大的数据库
        sqlite3_exec(unencrypted_DB, "begin exclusive transaction", NULL, NULL, NULL);
        // export database
        sqlite3_exec(unencrypted_DB, "SELECT sqlcipher_export('encrypted');", NULL, NULL, NULL);
        // Detach encrypted database
        sqlite3_exec(unencrypted_DB, "DETACH DATABASE encrypted;", NULL, NULL, NULL);
        //end exclusive transaction
        sqlite3_exec(unencrypted_DB, "commit transaction", NULL, NULL, NULL);
        sqlite3_close(unencrypted_DB);
        return YES;
    }
    else {
        sqlite3_close(unencrypted_DB);
        NSAssert1(NO, @"Failed to open database with message '%s'.", sqlite3_errmsg(unencrypted_DB));
        return NO;
    }
}
 
#pragma mark - 对数据库解密
+ (BOOL)unEncryptDatabase:(NSString *)sourcePath targetPath:(NSString *)targetPath {
    //给加密数据库添加未加密的附属数据库
    const char* sqlQ = [[NSString stringWithFormat:@"ATTACH DATABASE '%@' AS plaintext KEY '';", targetPath] UTF8String];
    sqlite3 *encrypted_DB;
    if (sqlite3_open([sourcePath UTF8String], &encrypted_DB) == SQLITE_OK) {
        sqlite3_exec(encrypted_DB, [[NSString stringWithFormat:@"PRAGMA key = '%@';", encryptKey_] UTF8String], NULL, NULL, NULL);
        // Attach empty unencrypted database to encrypted database
        sqlite3_exec(encrypted_DB, sqlQ, NULL, NULL, NULL);
        // export database
        sqlite3_exec(encrypted_DB, "SELECT sqlcipher_export('plaintext');", NULL, NULL, NULL);
        // Detach unencrypted database
        sqlite3_exec(encrypted_DB, "DETACH DATABASE plaintext;", NULL, NULL, NULL);
        sqlite3_close(encrypted_DB);
        return YES;
    }
    else {
        sqlite3_close(encrypted_DB);
        NSAssert1(NO, @"Failed to open database with message '%s'.", sqlite3_errmsg(encrypted_DB));
        return NO;
    }
}
 
#pragma mark -  修改数据库秘钥
+ (BOOL)changeKey:(NSString *)dbPath originKey:(NSString *)originKey newKey:(NSString *)newKey {
    sqlite3 *encrypted_DB;
    if (sqlite3_open([dbPath UTF8String], &encrypted_DB) == SQLITE_OK) {
        //利用sqlite专有PRAGMA语法，设置key，打开数据库
        sqlite3_exec(encrypted_DB, [[NSString stringWithFormat:@"PRAGMA key = '%@';", originKey] UTF8String], NULL, NULL, NULL);
        //利用sqlite专有PRAGMA语法，重新设置key
        sqlite3_exec(encrypted_DB, [[NSString stringWithFormat:@"PRAGMA rekey = '%@';", newKey] UTF8String], NULL, NULL, NULL);
        sqlite3_close(encrypted_DB);
        return YES;
    }
    else {
        sqlite3_close(encrypted_DB);
        NSAssert1(NO, @"Failed to open database with message '%s'.", sqlite3_errmsg(encrypted_DB));
        return NO;
    }
}
@end
