//
//  BLfAesGcmVC.m
//  FblFunctionMuster
//
//  Created by Fanbaili on 2021/8/5.
//  Copyright © 2021 FblFunctionMuster. All rights reserved.
//

#import "BLfAesGcmVC.h"
#import <IAGAesGcm.h>
#import <CommonCrypto/CommonCrypto.h>

@interface BLfAesGcmVC ()

@end

@implementation BLfAesGcmVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BLThemeEndColor;
    
    //定义加密密钥
    u_char keyBytes[kCCKeySizeAES128] = {0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F, 0x10};
    NSData *key = [NSData dataWithBytes:keyBytes length:sizeof(keyBytes)];

    
    // 定义初始化向量
    // GCM建议IV大小为96位(12字节)，但你可以自由使用其他大小
    u_char ivBytes[12] = {0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0A, 0x0B, 0x0C};
    NSData *iv = [NSData dataWithBytes:ivBytes length:sizeof(ivBytes)];

    // 定义额外的身份验证数据
    NSData *aad = [@"AdditionalAuthenticatedData" dataUsingEncoding:NSUTF8StringEncoding];

    // 准备加密的普通数据
    NSData *expectedPlainData = [@"PlainData" dataUsingEncoding:NSUTF8StringEncoding];

    // The returned ciphered data is a simple class with 2 properties: the actual encrypted data and the authentication tag.
    // The authentication tag can have multiple sizes and it is up to you to set one, in this case the size is 128 bits
    // (16 bytes)
    //返回的加密数据是一个简单的类，有两个属性:实际加密的数据和身份验证标记。
    //认证标签可以有多个大小，由您来设置，在本例中大小为128位
    IAGCipheredData *cipheredData = [IAGAesGcm cipheredDataByAuthenticatedEncryptingPlainData:expectedPlainData
                                                              withAdditionalAuthenticatedData:aad
                                                                      authenticationTagLength:IAGAuthenticationTagLength128
                                                                         initializationVector:iv
                                                                                          key:key
                                                                                        error:nil];

    // And now, de-cypher the encrypted data to see if the returned plain data is as expected
    //现在，解密加密的数据，看看返回的普通数据是否如预期的那样
    NSData *plainData = [IAGAesGcm plainDataByAuthenticatedDecryptingCipheredData:cipheredData
                                                  withAdditionalAuthenticatedData:aad
                                                             initializationVector:iv
                                                                              key:key
                                                                            error:nil];
    NSLog(@"--解密----->%@",[[NSString alloc]initWithData:plainData encoding:NSUTF8StringEncoding]);
    }
@end
