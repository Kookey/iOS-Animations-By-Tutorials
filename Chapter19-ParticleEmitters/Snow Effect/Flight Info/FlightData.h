//
//  FlightData.h
//  Flight Info
//
//  Created by dudw on 16/5/22.
//  Copyright © 2016年 dudw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlightData : NSObject

@property(nonatomic,copy) NSString *summary;
@property(nonatomic,copy) NSString *flightNr;
@property(nonatomic,copy) NSString *gateNr;
@property(nonatomic,copy) NSString *departingFrom;
@property(nonatomic,copy) NSString *arrivingTo;
@property(nonatomic,copy) NSString *weatherImageName;
@property(nonatomic,assign)BOOL showWeatherEffects;
@property(nonatomic,assign)BOOL isTakingOff;
@property(nonatomic,copy) NSString *flightStatus;

@end
