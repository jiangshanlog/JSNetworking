//
//  JSServiceFactory.m
//  JSNetworking
//
//  Created by Nick on 2017/3/16.
//  Copyright © 2017年 Nick. All rights reserved.
//

#import "JSServiceFactory.h"
#import "JSService.h"
#import "JSCommonService.h"

NSString * const kJSAPI = @"kJSAPI";

@interface JSServiceFactory ()

@property (nonatomic, strong) NSMutableDictionary *serviceStorage;

@end

@implementation JSServiceFactory

#pragma mark - getters and setters
- (NSMutableDictionary *)serviceStorage
{
    if (_serviceStorage == nil) {
        _serviceStorage = [[NSMutableDictionary alloc] init];
    }
    return _serviceStorage;
}

#pragma mark - life cycle
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static JSServiceFactory *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[JSServiceFactory alloc] init];
    });
    return sharedInstance;
}

#pragma mark - public methods
- (JSService<JSServiceProtocol> *)serviceWithIdentifier:(NSString *)identifier
{
    if (self.serviceStorage[identifier] == nil) {
        self.serviceStorage[identifier] = [self newServiceWithIdentifier:identifier];
    }
    return self.serviceStorage[identifier];
}

#pragma mark - private methods
- (JSService<JSServiceProtocol> *)newServiceWithIdentifier:(NSString *)identifier
{
    if ([identifier isEqualToString:kJSAPI]) {
        return [[JSCommonService alloc] init];
    }
    
    return nil;
}


@end
