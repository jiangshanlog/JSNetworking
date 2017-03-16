//
//  JSServiceFactory.h
//  JSNetworking
//
//  Created by Nick on 2017/3/16.
//  Copyright © 2017年 Nick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSService.h"

@interface JSServiceFactory : NSObject

+ (instancetype)sharedInstance;
- (JSService<JSServiceProtocol> *)serviceWithIdentifier:(NSString *)identifier;

@end
