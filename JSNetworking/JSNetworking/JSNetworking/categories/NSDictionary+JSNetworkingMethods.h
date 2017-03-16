//
//  NSDictionary+JSNetworkingMethods.h
//  JSNetworking
//
//  Created by Nick on 2017/3/16.
//  Copyright © 2017年 Nick. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (JSNetworkingMethods)

- (NSString *)JS_urlParamsStringSignature: (BOOL)isForSignature;
- (NSString *)JS_jsonString;
- (NSArray *)JS_transformedUrlParamsArraySignature: (BOOL)isForSignature;

@end
