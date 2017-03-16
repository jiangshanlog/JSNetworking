//
//  NSArray+JSNetworkingMethods.m
//  JSNetworking
//
//  Created by Nick on 2017/3/16.
//  Copyright © 2017年 Nick. All rights reserved.
//

#import "NSArray+JSNetworkingMethods.h"

@implementation NSArray (JSNetworkingMethods)

/** 字母排序之后形成的参数字符串 */
- (NSString *)JS_paramsString {
    NSMutableString *paramsString = [[NSMutableString alloc]init];
    NSArray *sortedParams = [self sortedArrayUsingSelector:@selector(compare:)];
    [sortedParams enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([paramsString length] == 0) {
            [paramsString appendFormat:@"%@", obj];
        } else {
            [paramsString appendFormat:@"&%@", obj];
        }
    }];
    
    return paramsString;

}

/** 数组变json */
- (NSString *)JS_jsonString {
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:NULL];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
