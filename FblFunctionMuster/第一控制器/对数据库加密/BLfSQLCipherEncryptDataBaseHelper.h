//
//  RSSQLCipherEncryptDataBaseHelper.h
//  CamView Plus
//
//  Created by Fanbaili on 2021/8/3.
//  Copyright © 2021 lovingc2009. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BLfSQLCipherEncryptDataBaseHelper : NSObject
/** 对数据库加密 */
+ (BOOL)encryptDatabase:(NSString *)path;
 
/** 对数据库解密 */
+ (BOOL)unEncryptDatabase:(NSString *)path;
 
/** 对数据库加密 */
+ (BOOL)encryptDatabase:(NSString *)sourcePath targetPath:(NSString *)targetPath;
 
/** 对数据库解密 */
+ (BOOL)unEncryptDatabase:(NSString *)sourcePath targetPath:(NSString *)targetPath;
 
/** 修改数据库秘钥 */
+ (BOOL)changeKey:(NSString *)dbPath originKey:(NSString *)originKey newKey:(NSString *)newKey;

@end

NS_ASSUME_NONNULL_END
