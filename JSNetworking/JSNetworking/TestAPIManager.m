//
//  TestAPIManager.m
//  CTNetworking
//
//  Created by casa on 15/12/31.
//  Copyright © 2015年 casa. All rights reserved.
//

#import "TestAPIManager.h"

//NSString * const kTestAPIManagerParamsKeyLatitude = @"kTestAPIManagerParamsKeyLatitude";
//NSString * const kTestAPIManagerParamsKeyLongitude = @"kTestAPIManagerParamsKeyLongitude";

@interface TestAPIManager () <JSAPIManagerValidator>

@end

@implementation TestAPIManager

#pragma mark - life cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.validator = self;
    }
    return self;
}

#pragma mark - CTAPIManager
- (NSString *)methodName
{
    return @"geocode/regeo";
}

- (NSString *)serviceType
{
    return kJSAPI;
}

- (JSAPIManagerRequestType)requestType
{
    return JSAPIManagerRequestTypeGet;
}

- (BOOL)shouldCache
{
    return YES;
}

//- (NSDictionary *)reformParams:(NSDictionary *)params
//{
//    NSMutableDictionary *resultParams = [[NSMutableDictionary alloc] init];
//    resultParams[@"key"] = [[JSServiceFactory sharedInstance] serviceWithIdentifier:kJSAPI].publicKey;
//    resultParams[@"location"] = [NSString stringWithFormat:@"%@,%@", params[kTestAPIManagerParamsKeyLongitude], params[kTestAPIManagerParamsKeyLatitude]];
//    resultParams[@"output"] = @"json";
//    return resultParams;
//    return nil;
//}

#pragma mark - CTAPIManagerValidator
- (BOOL)manager:(JSAPIBaseManager *)manager isCorrectWithParamsData:(NSDictionary *)data
{
    return YES;
}

- (BOOL)manager:(JSAPIBaseManager *)manager isCorrectWithCallBackData:(NSDictionary *)data
{
    if ([data[@"status"] isEqualToString:@"0"]) {
        return NO;
    }
    
    return YES;
}

@end
