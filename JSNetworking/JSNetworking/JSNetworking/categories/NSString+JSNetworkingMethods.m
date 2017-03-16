//
//  NSString+JSNetworkingMethods.m
//  JSNetworking
//
//  Created by Nick on 2017/3/16.
//  Copyright © 2017年 Nick. All rights reserved.
//

#import "NSString+JSNetworkingMethods.h"
#include <CommonCrypto/CommonDigest.h>
#import "NSObject+JSNetworkingMethods.h"

@implementation NSString (JSNetworkingMethods)

- (NSString *)JS_md5 {
    NSData *inputData = [self dataUsingEncoding:NSUTF8StringEncoding];
    unsigned char outputData[CC_MD5_DIGEST_LENGTH];
    CC_MD5([inputData bytes], (unsigned int)[inputData length], outputData);
    
    NSMutableString *hashStr = [NSMutableString string];
    int i = 0;
    for (i = 0; i < CC_MD5_DIGEST_LENGTH; ++i) {
        [hashStr appendFormat:@"%02x", outputData[i]];
    }
    return hashStr;
}

@end
