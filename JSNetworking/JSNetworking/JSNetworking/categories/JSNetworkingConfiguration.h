//
//  JSNetworkingConfiguration.h
//  JSNetworking
//
//  Created by Nick on 2017/3/16.
//  Copyright © 2017年 Nick. All rights reserved.
//

#ifndef JSNetworkingConfiguration_h
#define JSNetworkingConfiguration_h

typedef NS_ENUM (NSInteger, JSAppType) {
    JSAppTypexxx
};

typedef NS_ENUM(NSUInteger, JSURLResponseStatus)
{
    JSURLResponseStatusSuccess, //作为底层，请求是否成功只考虑是否成功收到服务器反馈。至于签名是否正确，返回的数据是否完整，由上层的CTAPIBaseManager来决定。
    JSURLResponseStatusErrorTimeout,
    JSURLResponseStatusErrorNoNetwork // 默认除了超时以外的错误都是无网络错误。
};

static NSString *JSKeychainServiceName = @"xxxxx";
static NSString *JSUDIDName = @"xxxx";
static NSString *JSPasteboardType = @"xxxx";

static BOOL kJSShouldCache = YES;
static BOOL kJSServiceIsOnline = NO;
static NSTimeInterval kJSNetworkingTimeoutSeconds = 20.0f;
static NSTimeInterval kJSCacheOutdateTimeSeconds = 300; // 5分钟的cache过期时间
static NSUInteger kJSCacheCountLimit = 1000; // 最多1000条cache

// services
extern NSString * const kJSAPI;



#endif /* JSNetworkingConfiguration_h */
