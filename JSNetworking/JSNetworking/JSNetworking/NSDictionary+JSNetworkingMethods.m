//
//  NSDictionary+JSNetworkingMethods.m
//  JSNetworking
//
//  Created by Nick on 2017/3/16.
//  Copyright © 2017年 Nick. All rights reserved.
//

#import "NSDictionary+JSNetworkingMethods.h"
#import "NSArray+JSNetworkingMethods.h"

@implementation NSDictionary (JSNetworkingMethods)

/** 字符串前面没有问号，如果用于post，就不用加问号，如果用于get，就要加个问号 */
- (NSString *)JS_urlParamsStringSignature: (BOOL)isForSignature {
    NSArray *sortedArray;
    return [sortedArray JS_paramsString];
}

/** 字典变json */
- (NSString *)JS_jsonString {
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:NULL];
    return [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
}

/** 转义参数 */
- (NSArray *)JS_transformedUrlParamsArraySignature: (BOOL)isForSignature {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if (![obj isKindOfClass:[NSString class]]) {
            obj = [NSString stringWithFormat:@"%@", obj];
        }
        if (!isForSignature) {
            obj = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,  (CFStringRef)obj,  NULL,  (CFStringRef)@"!*'();:@&;=+$,/?%#[]",  kCFStringEncodingUTF8));
        }
        if ([obj length] > 0) {
            [result addObject:[NSString stringWithFormat:@"%@=%@", key, obj]];
        }
    }];
    NSArray *sortedResult = [result sortedArrayUsingSelector:@selector(compare:)];
    return sortedResult;
}

@end
