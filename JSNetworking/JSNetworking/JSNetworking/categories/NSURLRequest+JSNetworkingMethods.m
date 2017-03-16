//
//  NSURLRequest+JSNetworkingMethods.m
//  JSNetworking
//
//  Created by Nick on 2017/3/16.
//  Copyright © 2017年 Nick. All rights reserved.
//

#import "NSURLRequest+JSNetworkingMethods.h"
#import <objc/runtime.h>

static void *JSNetworkingRequestParams;

@implementation NSURLRequest (JSNetworkingMethods)

- (void)setRequestParams:(NSDictionary *)requestParams {
    objc_setAssociatedObject(self, &JSNetworkingRequestParams, requestParams, OBJC_ASSOCIATION_COPY);
}

- (NSDictionary *)requestParams {
    return objc_getAssociatedObject(self, &JSNetworkingRequestParams);
}

@end
