//
//  TripScreen.m
//  SpeedoMeter
//
//  Created by lemosys on 15/01/14.
//  Copyright (c) 2014 lemosys. All rights reserved.
//

#import "TripScreen.h"
#import "Trip.h"
#import "DriverOffline.h"
#import "AppResourceObject.h"
#import "HomeScreen.h"
#import "HudScreen.h"
#import "MFSideMenu.h"
#import "MapScreen.h"
#import "DriverOffline.h"

@interface TripScreen ()
{
    NSTimer *mainTimer;
    
    Trip *trip;
    
    DriverOffline *driverOffline;
    
    NSMutableArray *getTripDetail;
    NSMutableArray *setting_detail;
    NSMutableArray *tripLogData;
    NSMutableArray *data;
}

@end

@implementation TripScreen

@synthesize currentSpeedKmLabel;
@synthesize maxSpeedLabel;
@synthesize altitudeLabel;
@synthesize averageSpeedLabel;
@synthesize current_time;
@synthesize altitudeUnitLabel;
@synthesize maximumSpeedunitLabel;
@synthesize averageSpeedUnitLabel;
@synthesize mainView;
@synthesize footerimageView;
@synthesize blackTopHeader;
@synthesize diditalMeterUnitLbl;
@synthesize lblForLocation;
@synthesize imgViewForCurrentSpeed;
@synthesize imgViewForRouteTime;
@synthesize imgViewForMaxSpeed;
@synthesize imgViewForAlttitude;
@synthesize imgViewForAvgSpeed;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    lblForLocation.layer.borderWidth=1.0;
    lblForLocation.layer.masksToBounds = YES;
    lblForLocation.layer.borderColor=[[UIColor whiteColor] CGColor];
    lblForLocation.backgroundColor=[UIColor clearColor];
    
    imgViewForCurrentSpeed.backgroundColor=[UIColor clearColor];
    imgViewForCurrentSpeed.layer.cornerRadius=10;
    imgViewForCurrentSpeed.layer.borderWidth=1.0;
    imgViewForCurrentSpeed.layer.masksToBounds = YES;
    imgViewForCurrentSpeed.layer.borderColor=[[UIColor whiteColor] CGColor];
    
    imgViewForRouteTime.backgroundColor=[UIColor clearColor];
    imgViewForRouteTime.layer.borderWidth=1.0;
    imgViewForRouteTime.layer.masksToBounds = YES;
    imgViewForRouteTime.layer.borderColor=[[UIColor whiteColor] CGColor];
    
    imgViewForMaxSpeed.backgroundColor=[UIColor clearColor];
    imgViewForMaxSpeed.layer.borderWidth=1.0;
    imgViewForMaxSpeed.layer.masksToBounds = YES;
    imgViewForMaxSpeed.layer.borderColor=[[UIColor whiteColor] CGColor];
    
    imgViewForAlttitude.backgroundColor=[UIColor clearColor];
    imgViewForAlttitude.layer.borderWidth=1.0;
    imgViewForAlttitude.layer.masksToBounds = YES;
    imgViewForAlttitude.layer.borderColor=[[UIColor whiteColor] CGColor];
    
    imgViewForAvgSpeed.backgroundColor=[UIColor clearColor];
    imgViewForAvgSpeed.layer.borderWidth=1.0;
    imgViewForAvgSpeed.layer.masksToBounds = YES;
    imgViewForAvgSpeed.layer.borderColor=[[UIColor whiteColor] CGColor];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    current_time.font = [UIFont fontWithName:@"DS-Digital" size: 20];
    currentSpeedKmLabel.font = [UIFont fontWithName:@"DS-Digital" size: 120];;
    maxSpeedLabel.font = [UIFont fontWithName:@"DS-Digital" size: 20];;
    altitudeLabel.font = [UIFont fontWithName:@"DS-Digital" size: 20];;
    averageSpeedLabel.font = [UIFont fontWithName:@"DS-Digital" size: 20];;

    if ([[[NSUserDefaults standardUserDefaults ]objectForKey:@"unit"] isEqual:@"KM"])
    {
        averageSpeedUnitLabel.text = @"km/h";
        maximumSpeedunitLabel.text = @"km/h";
        diditalMeterUnitLbl.text = @"km/h";
    }
    else
    {
        averageSpeedUnitLabel.text = @"mph";
        maximumSpeedunitLabel.text = @"mph";
        diditalMeterUnitLbl.text = @"mph";
    }
    
    mainTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateLabeldata) userInfo:nil repeats:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [mainTimer invalidate];
    mainTimer = nil;
}

- (void)viewDidUnload
{
    trip = nil;
    getTripDetail = nil;
    driverOffline = nil;
    setting_detail = nil;
    tripLogData = nil;
    
    [self setMainView:nil];
    [self setFooterimageView:nil];
    [self setMaxSpeedLabel:nil];
    [self setAltitudeLabel:nil];
    [self setAverageSpeedLabel:nil];
    [self setCurrentSpeedKmLabel:nil];
    [self setAltitudeUnitLabel:nil];
    [self setMaximumSpeedunitLabel:nil];
    [self setAverageSpeedUnitLabel:nil];
    
    [super viewDidUnload];
}

#pragma mark display currentspeed,location,altitude Action

- (void)updateLabeldata
{
    NSDate *currentTime = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh-mm-ss"];
    NSString *resultString = [dateFormatter stringFromDate:currentTime];
    current_time.text=resultString;
    
    int currentSpped = [[[NSUserDefaults standardUserDefaults] objectForKey:@"currentSpeed"] intValue];
    
    int topSpeed = [[[NSUserDefaults standardUserDefaults] objectForKey:@"topSpeed"] intValue];
    
    int avgSpeed = [[[NSUserDefaults standardUserDefaults] objectForKey:@"averageSpeed"] intValue];
    
    if ([[[NSUserDefaults standardUserDefaults ]objectForKey:@"unit"] isEqual:@"KM"])
    {
        currentSpeedKmLabel.text = [NSString stringWithFormat:@"%.0f",currentSpped*3.6];
        maxSpeedLabel.text = [NSString stringWithFormat:@"%.0f",topSpeed*3.6];
        averageSpeedLabel.text = [NSString stringWithFormat:@"%d",avgSpeed];
    }
    else if ([[[NSUserDefaults standardUserDefaults ]objectForKey:@"unit"] isEqual:@"MPH"])
    {
        currentSpeedKmLabel.text = [NSString stringWithFormat:@"%.0f",currentSpped * 2.23693629];
        maxSpeedLabel.text = [NSString stringWithFormat:@"%.0f",topSpeed * 2.23693629];
        averageSpeedLabel.text = [NSString stringWithFormat:@"%d",avgSpeed];
    }
    
    if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"currentHight"] isKindOfClass:[NSNull class]])
    {
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"currentHight"])
        {
            altitudeLabel.text = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"currentHight"]];
        }
        else
        {
            altitudeLabel.text = @"0";
        }
    }
    
    if ([currentSpeedKmLabel.text isEqualToString:@"--"])
    {
        
    }
    else
    {
        float oldRad = [[[NSUserDefaults standardUserDefaults] objectForKey:@"oldradians"] floatValue];
        float newRad =   [[[NSUserDefaults standardUserDefaults] objectForKey:@"newradians"] floatValue];

        CABasicAnimation *theAnimation;
        theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        theAnimation.fromValue = [NSNumber numberWithFloat:oldRad];
        theAnimation.toValue=[NSNumber numberWithFloat:newRad];
        theAnimation.duration = 0.5f;
    }
    
    CLGeocoder* geoCoder = [[CLGeocoder alloc] init];
        
    [geoCoder reverseGeocodeLocation:[[CLLocation alloc] initWithLatitude:[[[NSUserDefaults standardUserDefaults] valueForKey:@"newlatitude"] doubleValue] longitude:[[[NSUserDefaults standardUserDefaults] valueForKey:@"newlongtitude"] doubleValue]] completionHandler:^(NSArray *placemarks, NSError *error)
    {
        CLPlacemark *placemark = [placemarks objectAtIndex:0];
             
        [[NSUserDefaults standardUserDefaults] setValue:[[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "] forKey:@"currentLocation"];

        lblForLocation.text = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"currentLocation"]];
    }];
}

#pragma mark this method show alertview.

- (void) alertAction:(NSString *)msg title:(NSString *)title
{
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:title message:msg delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"Cancel", nil];
    [alertView show];
    alertView = nil;
}


#pragma Mark footerButtonAction
- (IBAction)menuAction:(id)sender
{
     [self.menuContainerViewController toggleRightSideMenuCompletion:nil];
}

- (IBAction)hudAction:(id)sender
{
    HudScreen *hudScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"HudScreen"];
    [self.navigationController setViewControllers:[NSArray arrayWithObject:hudScreen] animated:YES];
}

- (IBAction)mapAction:(id)sender
{
    MapScreen *mapScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"MapScreen"];
    [self.navigationController setViewControllers:[NSArray arrayWithObject:mapScreen] animated:YES];
}

- (IBAction)SpeedoAction:(id)sender
{
    HomeScreen *homeScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeScreen"];
    [self.navigationController setViewControllers:[NSArray arrayWithObject:homeScreen] animated:YES];
}

- (IBAction)lemosysAction:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.lemosys.com/"]];
}


@end
