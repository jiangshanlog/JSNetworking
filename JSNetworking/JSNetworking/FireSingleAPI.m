//
//  FireSingleAPI.m
//  JSNetworking
//
//  Created by Nick on 2017/3/20.
//  Copyright © 2017年 Nick. All rights reserved.
//

#import "FireSingleAPI.h"
#import "TestAPIManager.h"

@interface FireSingleAPI () <JSAPIManagerParamSource, JSAPIManagerCallBackDelegate>

@property (nonatomic, strong) TestAPIManager *testAPIManager;

@end

@implementation FireSingleAPI

#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.testAPIManager loadData];
}

#pragma mark - CTAPIManagerParamSource
- (NSDictionary *)paramsForApi:(JSAPIBaseManager *)manager
{
    NSDictionary *params = @{};
    
    if (manager == self.testAPIManager) {
        params = @{
                   kTestAPIManagerParamsKeyLatitude:@(31.228000),
                   kTestAPIManagerParamsKeyLongitude:@(121.454290)
                   };
    }
    
    return params;
}

#pragma mark - CTAPIManagerCallBackDelegate
- (void)managerCallAPIDidSuccess:(JSAPIBaseManager *)manager idForObject:(id)data
{
    NSLog(@"%@",data);
    if (manager == self.testAPIManager) {

    }
}

- (void)managerCallAPIDidFailed:(JSAPIBaseManager *)manager idForObject:(id)data
{
    if (manager == self.testAPIManager) {

    }
}

#pragma mark - getters and setters
- (TestAPIManager *)testAPIManager
{
    if (_testAPIManager == nil) {
        _testAPIManager = [[TestAPIManager alloc] init];
        _testAPIManager.delegate = self;
        _testAPIManager.paramSource = self;
    }
    return _testAPIManager;
}


@end
