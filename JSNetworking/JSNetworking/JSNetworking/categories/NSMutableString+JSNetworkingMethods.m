//
//  NSMutableString+JSNetworkingMethods.m
//  JSNetworking
//
//  Created by Nick on 2017/3/16.
//  Copyright © 2017年 Nick. All rights reserved.
//

#import "NSMutableString+JSNetworkingMethods.h"
#import "NSObject+JSNetworkingMethods.h"
@implementation NSMutableString (JSNetworkingMethods)

- (void)appendURLRequest:(NSURLRequest *)request {
    [self appendFormat:@"\n\nHTTP URL:\n\t%@", request.URL];
    [self appendFormat:@"\n\nHTTP Header:\n%@", request.allHTTPHeaderFields ? request.allHTTPHeaderFields : @"\t\t\t\t\tN/A"];
    [self appendFormat:@"\n\nHTTP Body:\n\t%@", [[[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding] JS_defaultValue:@"\t\t\t\tN/A"]];
}

@end
