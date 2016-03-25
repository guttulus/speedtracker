//
//  TripLog.h
//  SpeedoMeter
//
//  Created by lemosys on 15/02/14.
//  Copyright (c) 2014 lemosys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TripLog : NSObject

@property(assign)int tripLogId;
@property(strong,nonatomic)NSString *tripDateTime;
@property(strong,nonatomic)NSString *tripDistance;
@property(strong,nonatomic)NSString *tripElepsedTime;

@property(strong,nonatomic)NSString *triptravelTime;
@property(strong,nonatomic)NSString *tripstoppedTime;
@property(strong,nonatomic)NSString *tripavgSpeed;
@property(strong,nonatomic)NSString *tripmaxSpeed;
@property(strong,nonatomic)NSString *unit_Name;

@end
