//
//  Trip.h
//  SpeedoMeter
//
//  Created by lemosys on 21/01/14.
//  Copyright (c) 2014 lemosys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Trip : NSObject

@property(assign)int tripId;
@property(strong,nonatomic)NSString *oldLongtitude;
@property(strong,nonatomic)NSString *oldLatitude;
@property(strong,nonatomic)NSString *nLongtitude;
@property(strong,nonatomic)NSString *nLtitude;
@property(strong,nonatomic)NSString *distance;
@property(strong,nonatomic)NSString *travelTime;
@property(strong,nonatomic)NSString *maxSpeed;
@property(strong,nonatomic)NSString *averageSpeed;
@property(strong,nonatomic)NSString *currentLocation;
@property(strong,nonatomic)NSString *currentSpeed;
@property(strong,nonatomic)NSString *elepsedTime;
@property(strong,nonatomic)NSString *stoppedTime;

@property(strong,nonatomic)NSString *createdDate;
@property(strong,nonatomic)NSString *status;
@property(strong,nonatomic)NSString *currentHeight;

@property(strong,nonatomic)NSString *startLatLong;
@property(strong,nonatomic)NSString *endLatLong;

@property(assign)float maximumSpeed;
@property(assign)float avgSpeed;
@property(strong,nonatomic)NSString *currentAddress;
@property(strong,nonatomic)NSString *unitName;
 
@end
