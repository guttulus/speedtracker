//
//  Setting.h
//  SpeedoMeter
//
//  Created by lemosys on 21/01/14.
//  Copyright (c) 2014 lemosys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Setting : NSObject

@property(assign)int settingId;
@property(strong,nonatomic)NSString *unitName;
@property(strong,nonatomic)NSString *orientationMode;
@property(strong,nonatomic)NSString *averageSpeed;
@property(strong,nonatomic)NSString *maximumAverageSpeedArrow;
@property(strong,nonatomic)NSString *fieldName;
@property(strong,nonatomic)NSString  *valueis;
@property(assign)int latlongstatus;
@property(strong,nonatomic)NSString *speedRadarStatus;
@end
