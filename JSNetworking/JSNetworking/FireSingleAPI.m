//
//  FireSingleAPI.m
//  CTNetworking
//
//  Created by casa on 15/12/31.
//  Copyright © 2015年 casa. All rights reserved.
//

#import "FireSingleAPI.h"
#import "TestAPIManager.h"

@interface FireSingleAPI () <JSAPIManagerParamSource, JSAPIManagerCallBackDelegate>

@property (nonatomic, strong) TestAPIManager *testAPIManager;
@property (nonatomic, strong) UILabel *resultLable;

@end

@implementation FireSingleAPI

#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.resultLable];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self layoutResultLable];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.testAPIManager loadData];
}

- (void)layoutResultLable
{
    [self.resultLable sizeToFit];
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
        self.resultLable.text = @"success";
        [self layoutResultLable];
    }
}

- (void)managerCallAPIDidFailed:(JSAPIBaseManager *)manager idForObject:(id)data
{
    if (manager == self.testAPIManager) {
        self.resultLable.text = @"fail";
        [self layoutResultLable];
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

- (UILabel *)resultLable
{
    if (_resultLable == nil) {
        _resultLable = [[UILabel alloc] init];
        _resultLable.text = @"loading API...";
    }
    return _resultLable;
}

@end
