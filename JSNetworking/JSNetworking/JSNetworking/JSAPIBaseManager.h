//
//  JSAPIBaseManager.h
//  JSNetworking
//
//  Created by Nick on 2017/3/16.
//  Copyright © 2017年 Nick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSURLResponse.h"

@class JSAPIBaseManager;

// 在调用成功之后的params字典里面，用这个key可以取出requestID
static NSString * const kCTAPIBaseManagerRequestID = @"kCTAPIBaseManagerRequestID";

/*************************************************************************************************/
/*                               CTAPIManagerApiCallBackDelegate                                 */
/*************************************************************************************************/

//api回调
@protocol JSAPIManagerCallBackDelegate <NSObject>
@required
- (void)managerCallAPIDidSuccess:(JSAPIBaseManager *)manager;
- (void)managerCallAPIDidFailed:(JSAPIBaseManager *)manager;
@end

/*************************************************************************************************/
/*                                     CTAPIManagerValidator                                     */
/*************************************************************************************************/
@protocol JSAPIManagerValidator <NSObject>
@required
- (BOOL)manager:(JSAPIBaseManager *)manager isCorrectWithCallBackData:(NSDictionary *)data;
- (BOOL)manager:(JSAPIBaseManager *)manager isCorrectWithParamsData:(NSDictionary *)data;
@end

/*************************************************************************************************/
/*                                CTAPIManagerParamSourceDelegate                                */
/*************************************************************************************************/
@protocol JSAPIManagerParamSource <NSObject>
@required
- (NSDictionary *)paramsForApi:(JSAPIBaseManager *)manager;
@end

/*
 当产品要求返回数据不正确或者为空的时候显示一套UI，请求超时和网络不通的时候显示另一套UI时，使用这个enum来决定使用哪种UI。（安居客PAD就有这样的需求，sigh～）
 你不应该在回调数据验证函数里面设置这些值，事实上，在任何派生的子类里面你都不应该自己设置manager的这个状态，baseManager已经帮你搞定了。
 强行修改manager的这个状态有可能会造成程序流程的改变，容易造成混乱。
 */
typedef NS_ENUM (NSUInteger, JSAPIManagerErrorType){
    JSAPIManagerErrorTypeDefault,       //没有产生过API请求，这个是manager的默认状态。
    JSAPIManagerErrorTypeSuccess,       //API请求成功且返回数据正确，此时manager的数据是可以直接拿来使用的。
    JSAPIManagerErrorTypeNoContent,     //API请求成功但返回数据不正确。如果回调数据验证函数返回值为NO，manager的状态就会是这个。
    JSAPIManagerErrorTypeParamsError,   //参数错误，此时manager不会调用API，因为参数验证是在调用API之前做的。
    JSAPIManagerErrorTypeTimeout,       //请求超时。CTAPIProxy设置的是20秒超时，具体超时时间的设置请自己去看CTAPIProxy的相关代码。
    JSAPIManagerErrorTypeNoNetWork      //网络不通。在调用API之前会判断一下当前网络是否通畅，这个也是在调用API之前验证的，和上面超时的状态是有区别的。
};

typedef NS_ENUM (NSUInteger, JSAPIManagerRequestType){
    JSAPIManagerRequestTypeGet,
    JSAPIManagerRequestTypePost,
    JSAPIManagerRequestTypePut
};

/*************************************************************************************************/
/*                                         CTAPIManager                                          */
/*************************************************************************************************/
/*
 CTAPIBaseManager的派生类必须符合这些protocal
 */
@protocol JSAPIManager <NSObject>

@required
- (NSString *)methodName;
- (NSString *)serviceType;
- (JSAPIManagerRequestType)requestType;
- (BOOL)shouldCache;

// used for pagable API Managers mainly
@optional
- (void)cleanData;
- (NSInteger)loadDataWithParams:(NSDictionary *)params;
- (BOOL)shouldLoadFromNative;

@end

/*************************************************************************************************/
/*                                    CTAPIManagerInterceptor                                    */
/*************************************************************************************************/
/*
 CTAPIBaseManager的派生类必须符合这些protocal
 */
@protocol JSAPIManagerInterceptor <NSObject>

@optional
- (BOOL)manager:(JSAPIBaseManager *)manager beforePerformSuccessWithResponse:(JSURLResponse *)response;
- (void)manager:(JSAPIBaseManager *)manager afterPerformSuccessWithResponse:(JSURLResponse *)response;

- (BOOL)manager:(JSAPIBaseManager *)manager beforePerformFailWithResponse:(JSURLResponse *)response;
- (void)manager:(JSAPIBaseManager *)manager afterPerformFailWithResponse:(JSURLResponse *)response;

- (BOOL)manager:(JSAPIBaseManager *)manager shouldCallAPIWithParams:(NSDictionary *)params;
- (void)manager:(JSAPIBaseManager *)manager afterCallingAPIWithParams:(NSDictionary *)params;

@end



@interface JSAPIBaseManager : NSObject

@property (nonatomic, weak) id<JSAPIManagerCallBackDelegate> delegate;
@property (nonatomic, weak) id<JSAPIManagerParamSource> paramSource;
@property (nonatomic, weak) id<JSAPIManagerValidator> validator;
@property (nonatomic, weak) NSObject<JSAPIManager> *child;
@property (nonatomic, weak) id<JSAPIManagerInterceptor> interceptor;

@property (nonatomic, copy, readonly) NSString *errorMessage;
@property (nonatomic, readonly) JSAPIManagerErrorType errorType;
@property (nonatomic, strong) JSURLResponse *response;
@property (nonatomic, assign, readonly) BOOL isReachable;
@property (nonatomic, assign, readonly) BOOL isLoading;

- (NSInteger)loadData;
- (void)cancelAllRequests;
- (void)cancelRequestWithRequestID:(NSInteger)requestID;
// 拦截器方法，继承之后需要调用一下super
- (BOOL)beforePerformSuccessWithResponse:(JSURLResponse *)response;
- (void)afterPerformSuccessWithResponse:(JSURLResponse *)response;

- (BOOL)beforePerformFailWithResponse:(JSURLResponse *)response;
- (void)afterPerformFailWithResponse:(JSURLResponse *)response;

- (BOOL)shouldCallAPIWithParams:(NSDictionary *)params;
- (void)afterCallingAPIWithParams:(NSDictionary *)params;

- (void)cleanData;
- (BOOL)shouldCache;

- (void)successedOnCallingAPI:(JSURLResponse *)response;
- (void)failedOnCallingAPI:(JSURLResponse *)response withErrorType:(JSAPIManagerErrorType)errorType;

@end
