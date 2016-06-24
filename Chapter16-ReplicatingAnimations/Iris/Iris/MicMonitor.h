//
//  MicMonitor.h
//  Iris
//
//  Created by dudawei on 16/6/24.
//  Copyright © 2016年 winchannel. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^levelsHander)(NSNumber *count);

@interface MicMonitor : NSObject

- (void)startMonitoringWithHandler:(levelsHander)handler;
- (void)stopMonitoring;
@end
