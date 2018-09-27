//
//  DeviceModel.h
//  Intelligence
//
//  Created by fsy on 2017/7/17.
//  Copyright © 2017年 hanrun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceModel : NSObject

@property (nonatomic,copy) NSString *address;

@property (nonatomic,copy) NSString *areaName;

@property (nonatomic) int areaId;
@property (nonatomic) int row;

@property (nonatomic) NSInteger ifDealAlarm;

@property (nonatomic) double latitude;
@property (nonatomic) double longitude;

@property (nonatomic,copy) NSString *mac;
@property (nonatomic,copy) NSString *name;

@property (nonatomic) NSInteger netState;

@property (nonatomic,copy) NSString *placeType;

@property (nonatomic,copy) NSString *placeeAddress;
@property (nonatomic,copy) NSString *principal1;

@property (nonatomic,copy) NSString *principal1Phone;

@property (nonatomic,copy) NSString *principal2;

@property (nonatomic,copy) NSString *principal2Phone;

@property (nonatomic,copy) NSString *repeater;

@property (nonatomic,copy) NSDictionary *camera;

@property (nonatomic) NSInteger deviceType;

@property (nonatomic,copy) NSString *addSmokeTime;

@property (nonatomic,copy) NSDictionary *enviInfo;

@property (nonatomic) int electrState;

@property (nonatomic,copy) NSString *ifFault;

@property (nonatomic,copy) NSString *rssivalue;

@property (nonatomic,assign) int lowVoltage;//设备电量百分比


@end
