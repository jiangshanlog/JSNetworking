//
//  JSApiProxy.m
//  JSNetworking
//
//  Created by Nick on 2017/3/16.
//  Copyright © 2017年 Nick. All rights reserved.
//
#import <AFNetworking/AFNetworking.h>
#import "JSApiProxy.h"
#import "JSServiceFactory.h"
#import "JSRequestGenerator.h"
#import "NSURLRequest+JSNetworkingMethods.h"

static NSString * const kJSApiProxyDispatchItemKeyCallbackSuccess = @"kJSApiProxyDispatchItemCallbackSuccess";
static NSString * const kJSApiProxyDispatchItemKeyCallbackFail = @"kJSApiProxyDispatchItemCallbackFail";

@interface JSApiProxy ()

@property (nonatomic, strong) NSMutableDictionary *dispatchTable;
@property (nonatomic, strong) NSNumber *recordedRequestId;

//AFNetworking stuff
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

@implementation JSApiProxy

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    static JSApiProxy *shareInstance = nil;
    dispatch_once(&onceToken, ^{
        shareInstance = [[JSApiProxy alloc] init];
    });
    return shareInstance;
}

#pragma mark - public methods
- (NSInteger)callGETWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName success:(JSCallback)success fail:(JSCallback)fail
{
    NSURLRequest *request = [[JSRequestGenerator sharedInstance] generateGETRequestWithServiceIdentifier:servieIdentifier requestParams:params methodName:methodName];
    NSNumber *requestId = [self callApiWithRequest:request success:success fail:fail];
    return [requestId integerValue];
}

- (NSInteger)callPOSTWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName success:(JSCallback)success fail:(JSCallback)fail
{
    NSURLRequest *request = [[JSRequestGenerator sharedInstance] generatePOSTRequestWithServiceIdentifier:servieIdentifier requestParams:params methodName:methodName];
    NSNumber *requestId = [self callApiWithRequest:request success:success fail:fail];
    return [requestId integerValue];
}

- (NSInteger)callPUTWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName success:(JSCallback)success fail:(JSCallback)fail
{
    NSURLRequest *request = [[JSRequestGenerator sharedInstance] generatePutRequestWithServiceIdentifier:servieIdentifier requestParams:params methodName:methodName];
    NSNumber *requestId = [self callApiWithRequest:request success:success fail:fail];
    return [requestId integerValue];
}


- (void)cancelRequestWithRequestID:(NSNumber *)requestID
{
    NSURLSessionDataTask *requestOperation = self.dispatchTable[requestID];
    [requestOperation cancel];
    [self.dispatchTable removeObjectForKey:requestID];
}

- (void)cancelRequestWithRequestIDList:(NSArray *)requestIDList
{
    for (NSNumber *requestId in requestIDList) {
        [self cancelRequestWithRequestID:requestId];
    }
}

/** 这个函数存在的意义在于，如果将来要把AFNetworking换掉，只要修改这个函数的实现即可。 */
- (NSNumber *)callApiWithRequest:(NSURLRequest *)request success:(JSCallback)success fail:(JSCallback)fail
{
    
    NSLog(@"\n==================================\n\nRequest Start: \n\n %@\n\n==================================", request.URL);
    
    // 跑到这里的block的时候，就已经是主线程了。
    __block NSURLSessionDataTask *dataTask = nil;
    dataTask = [self.sessionManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSNumber *requestID = @([dataTask taskIdentifier]);
        [self.dispatchTable removeObjectForKey:requestID];
        NSData *responseData = responseObject;
        NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        
        if (error) {
            JSURLResponse *JSResponse = [[JSURLResponse alloc] initWithResponseString:responseString requestId:requestID request:request responseData:responseData error:error];
            fail?fail(JSResponse):nil;
        } else {
            JSURLResponse *JSResponse = [[JSURLResponse alloc] initWithResponseString:responseString requestId:requestID request:request responseData:responseData status:JSURLResponseStatusSuccess];
            success?success(JSResponse):nil;
        }
    }];
    
    NSNumber *requestId = @([dataTask taskIdentifier]);
    
    self.dispatchTable[requestId] = dataTask;
    [dataTask resume];
    
    return requestId;
}

#pragma mark - getters and setters
- (NSMutableDictionary *)dispatchTable
{
    if (_dispatchTable == nil) {
        _dispatchTable = [[NSMutableDictionary alloc] init];
    }
    return _dispatchTable;
}

- (AFHTTPSessionManager *)sessionManager
{
    if (_sessionManager == nil) {
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _sessionManager.securityPolicy.allowInvalidCertificates = YES;
        _sessionManager.securityPolicy.validatesDomainName = NO;
    }
    return _sessionManager;
}

@end
