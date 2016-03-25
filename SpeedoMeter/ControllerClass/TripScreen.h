//
//  TripScreen.h
//  SpeedoMeter
//
//  Created by lemosys on 15/01/14.
//  Copyright (c) 2014 lemosys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TripLogCell.h"

@interface TripScreen : UIViewController

@property (strong, nonatomic) IBOutlet UIView *mainView;

@property (strong, nonatomic) IBOutlet UILabel *maxSpeedLabel;
@property (strong, nonatomic) IBOutlet UILabel *altitudeLabel;
@property (strong, nonatomic) IBOutlet UILabel *averageSpeedLabel;
@property (strong, nonatomic) IBOutlet UILabel *currentSpeedKmLabel;
@property (strong, nonatomic) IBOutlet UILabel *altitudeUnitLabel;
@property (strong, nonatomic) IBOutlet UILabel *maximumSpeedunitLabel;
@property (strong, nonatomic) IBOutlet UILabel *averageSpeedUnitLabel;
@property (strong, nonatomic) IBOutlet UILabel *diditalMeterUnitLbl;
@property (strong, nonatomic) IBOutlet UILabel *lblForLocation;
@property (strong, nonatomic) IBOutlet UILabel *current_time;

@property (strong, nonatomic) IBOutlet UIImageView *footerimageView;
@property (strong, nonatomic) IBOutlet UIImageView *blackTopHeader;
@property (strong, nonatomic) IBOutlet UIImageView *imgViewForCurrentSpeed;
@property (strong, nonatomic) IBOutlet UIImageView *imgViewForRouteTime;
@property (strong, nonatomic) IBOutlet UIImageView *imgViewForMaxSpeed;
@property (strong, nonatomic) IBOutlet UIImageView *imgViewForAlttitude;
@property (strong, nonatomic) IBOutlet UIImageView *imgViewForAvgSpeed;

- (void)updateLabeldata;

- (IBAction)menuAction:(id)sender;
- (IBAction)hudAction:(id)sender;
- (IBAction)mapAction:(id)sender;
- (IBAction)SpeedoAction:(id)sender;
- (IBAction)lemosysAction:(id)sender;

@end
