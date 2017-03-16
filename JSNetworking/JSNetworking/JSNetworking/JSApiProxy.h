//
//  JSApiProxy.h
//  JSNetworking
//
//  Created by Nick on 2017/3/16.
//  Copyright © 2017年 Nick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSURLResponse.h"

typedef void(^JSCallback)(JSURLResponse *response);

@interface JSApiProxy : NSObject
+ (instancetype)shareInstance;

- (NSInteger)callGETWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName success:(JSCallback)success fail:(JSCallback)fail;
- (NSInteger)callPOSTWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName success:(JSCallback)success fail:(JSCallback)fail;
- (NSInteger)callPUTWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName success:(JSCallback)success fail:(JSCallback)fail;


- (NSNumber *)callApiWithRequest:(NSURLRequest *)request success:(JSCallback)success fail:(JSCallback)fail;
- (void)cancelRequestWithRequestID:(NSNumber *)requestID;
- (void)cancelRequestWithRequestIDList:(NSArray *)requestIDList;

@end
