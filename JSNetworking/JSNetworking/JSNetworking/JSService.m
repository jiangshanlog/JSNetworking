//
//  JSService.m
//  JSNetworking
//
//  Created by Nick on 2017/3/16.
//  Copyright © 2017年 Nick. All rights reserved.
//

#import "JSService.h"
#import "NSObject+JSNetworkingMethods.h"

@implementation JSService

- (instancetype)init {
    self = [super init];
    if (self) {
            self.child =(id<JSServiceProtocol>)self;
    }
    return self;
}

#pragma mark - getters and setters
- (NSString *)privateKey
{
    return self.child.onlinePrivateKey;
}

- (NSString *)publicKey
{
    return self.child.onlinePublicKey;
}

- (NSString *)apiBaseUrl
{
    return self.child.onlineApiBaseUrl;
}

- (NSString *)apiVersion
{
    return self.child.onlineApiVersion;
}

@end
