//
//  HomeScreen.h
//  SpeedoMeter
//
//  Created by lemosys on 13/01/14.
//  Copyright (c) 2014 lemosys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

#define M_PI 3.14159265358979323846264338327950288   /* pi */
#define DEGREES_TO_RADIANS(angle) (angle / 180.0 * M_PI)

@interface HomeScreen : UIViewController
{
    float fltDistanceTravelled;
}

@property (strong, nonatomic) NSTimer *speedTimer;

@property (nonatomic, assign) float distanceMoved;
@property (strong, nonatomic) NSString *settingUnitname;
@property (nonatomic, retain) UILabel *speedometerReading;
@property (strong, nonatomic) NSString *currentSpeed;
@property (strong, nonatomic) NSString *totalDistance;
@property (nonatomic, assign) float speedometerCurrentValue;
@property (nonatomic, assign) float prevAngleFactor;
@property (nonatomic, assign) float angle;
@property (nonatomic, retain) NSString *maxVal;
@property (strong, nonatomic) UIImageView *btnImgView;
//@property (nonatomic, retain) CLLocationManager *locationManager;
@property (assign, nonatomic) float customviewFrameSize;


@property (strong, nonatomic) UILabel *signalLabel;
@property (strong, nonatomic) UILabel *locationAccurecyLabel;
@property (strong, nonatomic) UILabel *distanceLabel;
@property (strong, nonatomic) UILabel *locLabel;
@property (strong, nonatomic) UILabel *speedUnitLabel;
@property (strong, nonatomic) UIImageView *needleImageView;

@property (strong, nonatomic) IBOutlet UILabel *sliderLabel;
@property (strong, nonatomic) IBOutlet UIView *homeView;
@property (strong, nonatomic) IBOutlet UIButton *speedBtn;
@property (strong, nonatomic) IBOutlet UIButton *mapBtn;
@property (strong, nonatomic) IBOutlet UIButton *hudBtn;
@property (strong, nonatomic) IBOutlet UILabel *kmLabel;
@property (strong, nonatomic) IBOutlet UILabel *totalSpeedLabel;
@property (strong, nonatomic) IBOutlet UIImageView *blackTopHeader;
@property (strong, nonatomic) IBOutlet UIButton *menuAction;

- (void)addMeterViewContents;
- (void)rotateIt:(float)angl;
- (void)rotateNeedle;
- (void)calculateDeviationAngle;

- (IBAction)menuAction:(id)sender;
- (IBAction)lemosysAction:(id)sender;
- (IBAction)mapAction:(id)sender;
- (IBAction)hudAction:(id)sender;

@end

