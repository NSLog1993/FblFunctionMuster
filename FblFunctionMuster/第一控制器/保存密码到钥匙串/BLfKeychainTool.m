//
//  BLfKeychainTool.m
//  FblFunctionMuster
//
//  Created by Fanbaili on 2021/8/4.
//  Copyright © 2021 FblFunctionMuster. All rights reserved.
//

#import "BLfKeychainTool.h"

@implementation BLfKeychainTool

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (__bridge_transfer id)kSecClassGenericPassword,
            (__bridge_transfer id)kSecClass,service,
            (__bridge_transfer id)kSecAttrService,service,
            (__bridge_transfer id)kSecAttrAccount,
            (__bridge_transfer id)kSecAttrAccessibleAfterFirstUnlock,
            (__bridge_transfer id)kSecAttrAccessible,
            nil];
}

//保存
+ (void)saveKeychainValue:(NSString *)sValue key:(NSString *)sKey {
    NSMutableDictionary * keychainQuery = [self getKeychainQuery:sKey];
    SecItemDelete((__bridge_retained CFDictionaryRef)keychainQuery);
    if (@available(iOS 11.0, *)) {
        NSError *archiveError;
        [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:sValue requiringSecureCoding:YES error:&archiveError] forKey:(__bridge_transfer id)kSecValueData];
    }else {
        [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:sValue] forKey:(__bridge_transfer id)kSecValueData];
    }
    SecItemAdd((__bridge_retained CFDictionaryRef)keychainQuery, NULL);
    
}

//读取
+ (NSString *)readKeychainValue:(NSString *)sKey {
    NSString *ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:sKey];
        [keychainQuery setObject:(id)kCFBooleanTrue forKey:(__bridge_transfer id)kSecReturnData];
    [keychainQuery setObject:(__bridge_transfer id)kSecMatchLimitOne forKey:(__bridge_transfer id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((__bridge CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            if (@available(iOS 11.0, *)) {
                NSError *unarchiveError;
                ret = (NSString *)[NSKeyedUnarchiver unarchivedObjectOfClass:[NSString class] fromData:(__bridge NSData *)keyData error:&unarchiveError];
            }else {
                ret = (NSString *)[NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
            }
        } @catch (NSException *e) {
            NSLog(@"Unarchive of %@ failed: %@", sKey, e);
        } @finally {
            
        }
    }
    if (keyData)
        CFRelease(keyData);
    return ret;
}

//删除
+ (void)deleteKeychainValue:(NSString *)sKey {
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:sKey];
    SecItemDelete((__bridge CFDictionaryRef)keychainQuery);
}
@end
