//
//  JSCommonService.m
//  JSNetworking
//
//  Created by Nick on 2017/3/16.
//  Copyright © 2017年 Nick. All rights reserved.
//

#import "JSCommonService.h"

@implementation JSCommonService

#pragma mark - CTServiceProtocal


- (NSString *)onlineApiBaseUrl
{
    return @"http://restapi.amap.com";
}

- (NSString *)onlineApiVersion
{
    return @"v3";
}

- (NSString *)onlinePublicKey
{
    return @"384ecc4559ffc3b9ed1f81076c5f8424";
}

- (NSString *)onlinePrivateKey
{
    return @"";
}


@end
