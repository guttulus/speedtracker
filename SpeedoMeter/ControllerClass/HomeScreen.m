
//
//  HomeScreen.m
//  SpeedoMeter
//
//  Created by lemosys on 13/01/14.
//  Copyright (c) 2014 lemosys. All rights reserved.
//

#import "HomeScreen.h"
#import "AppResourceObject.h"
#import "DriverOffline.h"
#import "SetLatlong.h"
#import "DriverOnline.h"
#import "UILabel+FormattedText.h"
#import "HudScreen.h"
#import "MFSideMenu.h"
#import <QuartzCore/QuartzCore.h>
#import <FacebookSDK/FacebookSDK.h>
#import "MapScreen.h"

@interface HomeScreen ()
{
    AppResourceObject *appResourceObject;
    
    NSMutableArray *setting_detail;
    NSMutableArray *data;
    
    UIButton *btnForKMH;
    UIButton *btnForMPH;
    
    UIImageView *meterImageView;
    
    DriverOnline *driverOnline;
}

@end

@implementation HomeScreen

@synthesize speedTimer;
@synthesize homeView;
@synthesize needleImageView;
@synthesize speedometerReading;
@synthesize speedBtn;
@synthesize mapBtn;
@synthesize hudBtn;
@synthesize currentSpeed;
@synthesize speedometerCurrentValue;
@synthesize prevAngleFactor;
@synthesize angle;
@synthesize maxVal;
@synthesize btnImgView;
@synthesize kmLabel;
@synthesize totalSpeedLabel;
@synthesize totalDistance;
@synthesize customviewFrameSize;
@synthesize blackTopHeader;
@synthesize speedUnitLabel;
@synthesize settingUnitname;
@synthesize sliderLabel;
@synthesize locLabel;
@synthesize signalLabel;
@synthesize locationAccurecyLabel;
@synthesize distanceLabel;

//@synthesize locationManager;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    btnForKMH.selected=YES;
    btnForMPH.selected=NO;
    
//    locationManager = [[CLLocationManager alloc] init];
//    if ([locationManager respondsToSelector:
//         @selector(requestAlwaysAuthorization)])
//    {
//        [locationManager requestAlwaysAuthorization];
//    }
//    locationManager.delegate = self;
//    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//    [locationManager startUpdatingLocation];
    
    driverOnline = [[DriverOnline alloc] init];
    driverOnline.speedUpdateStatus = TRUE;
    
    speedTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(dpdateLabelData) userInfo:nil repeats:YES];
}

- (void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    appResourceObject = [AppResourceObject sharedAppResource];

    [self addMeterViewContents];
    
    [speedBtn setSelected:YES];
}



-(void)updateUserlocationWithSpeed
{
    if (appResourceObject.connectionStatus)
    {
        if (driverOnline.speedUpdateStatus)
        {
            driverOnline.speedUpdateStatus = FALSE;
            [driverOnline updateUserSpeedWithLocation];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
    [self setSpeedBtn:nil];
    [self setMapBtn:nil];
    [self setHudBtn:nil];
    [self setHomeView:nil];
    [self setKmLabel:nil];
    [self setTotalSpeedLabel:nil];
    [super viewDidUnload];
}

#pragma mark -
#pragma mark Public Methods

-(void) addMeterViewContents
{
    if (IsIphone5)
    {
        meterImageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 36, 320 ,320)];
        
        if ([[[NSUserDefaults standardUserDefaults ]objectForKey:@"unit"] isEqual:@"MPH"])
        {
            meterImageView.image = [UIImage imageNamed:@"speedomph.png"];
            kmLabel.text=@"MPH";
            totalSpeedLabel.frame=CGRectMake(116, 393, 126, 37);
        }
        else
        {
            meterImageView.image = [UIImage imageNamed:@"speedo.png"];
            kmLabel.text=@"KM";
            totalSpeedLabel.frame=CGRectMake(107, 393, 126, 37);
        }
        
        [homeView addSubview:meterImageView];
        
        needleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(41 ,70,239,240)];
        needleImageView.backgroundColor = [UIColor clearColor];
        needleImageView.image = [UIImage imageNamed:@"needle.png"];
        [homeView addSubview:needleImageView];
        
        btnForKMH = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnForKMH addTarget:self action:@selector(meterChangingAction:)
         forControlEvents:UIControlEventTouchUpInside];
        btnForKMH.frame = CGRectMake(135.0, 230, 25.0, 25.0);
        [btnForKMH setBackgroundImage:[UIImage imageNamed:@"km.png"] forState:UIControlStateNormal];
        [btnForKMH setBackgroundImage:[UIImage imageNamed:@"km_hover.png"] forState:UIControlStateHighlighted];
        [btnForKMH setBackgroundImage:[UIImage imageNamed:@"km_hover.png"] forState:UIControlStateSelected];
        btnForKMH.tag=1;
        [homeView addSubview:btnForKMH];
        
        btnForMPH = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnForMPH addTarget:self action:@selector(meterChangingAction:)
            forControlEvents:UIControlEventTouchUpInside];
        btnForMPH.frame = CGRectMake(163.0, 230, 25.0, 25.0);
        [btnForMPH setBackgroundImage:[UIImage imageNamed:@"mph.png"] forState:UIControlStateNormal];
        [btnForMPH setBackgroundImage:[UIImage imageNamed:@"mph_hover.png"] forState:UIControlStateHighlighted];
        [btnForMPH setBackgroundImage:[UIImage imageNamed:@"mph_hover.png"] forState:UIControlStateSelected];
     
        btnForMPH.tag=2;
        [homeView addSubview:btnForMPH];
     
        speedometerReading = [[UILabel alloc] initWithFrame:CGRectMake(118,260,85,44)];
        speedometerReading.textAlignment = NSTextAlignmentCenter;
        speedometerReading.backgroundColor = [UIColor clearColor];
        speedometerReading.font = [UIFont fontWithName:@"Roboto-Regular" size:27];
        speedometerReading.text= @"0";
        speedometerReading.textColor = [UIColor colorWithRed:254.0/255.0 green:214.0/255.0 blue:14.0/255.0 alpha:0.5];
        speedometerReading.shadowColor = [UIColor whiteColor];
        speedometerReading.shadowOffset = CGSizeMake(0,1);
        [homeView addSubview:speedometerReading];
        
        
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"unit"]length]>0)
        {
            if ([[[NSUserDefaults standardUserDefaults ]objectForKey:@"unit"] isEqual:@"KM"])
            {
                btnForKMH.selected=YES;
                
            }
            else if ([[[NSUserDefaults standardUserDefaults ]objectForKey:@"unit"] isEqual:@"MPH"])
            {
                btnForMPH.selected=YES;
            }
        }
        else
        {
            btnForMPH.selected = YES;
            meterImageView.image = [UIImage imageNamed:@"speedomph.png"];
            kmLabel.text=@"MPH";
            totalSpeedLabel.frame=CGRectMake(116, 393, 126, 37);
            [[NSUserDefaults standardUserDefaults ] setValue:@"MPH" forKey:@"unit"];
        }
    }
    else
    {
        meterImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, 320 ,320)];
        
        if ([[[NSUserDefaults standardUserDefaults ]objectForKey:@"unit"] isEqual:@"MPH"])
        {
            meterImageView.image = [UIImage imageNamed:@"speedomph.png"];
            kmLabel.text=@"MPH";
            totalSpeedLabel.frame=CGRectMake(116, 328, 126, 37);
        }
        else
        {
            meterImageView.image = [UIImage imageNamed:@"speedo.png"];
            kmLabel.text=@"KM";
            totalSpeedLabel.frame=CGRectMake(107, 328, 126, 37);
        }
        
        [homeView addSubview:meterImageView];
        
        needleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(41 ,34,239,240)];
        needleImageView.backgroundColor = [UIColor clearColor];
        needleImageView.image = [UIImage imageNamed:@"needle.png"];
        [homeView addSubview:needleImageView];
        
        // Speedometer Reading //
        btnForKMH = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnForKMH addTarget:self action:@selector(meterChangingAction:)
                forControlEvents:UIControlEventTouchUpInside];
        btnForKMH.frame = CGRectMake(135.0, 193.0, 25.0, 25.0);
        [btnForKMH setBackgroundImage:[UIImage imageNamed:@"km.png"] forState:UIControlStateNormal];
        [btnForKMH setBackgroundImage:[UIImage imageNamed:@"km_hover.png"] forState:UIControlStateHighlighted];
        [btnForKMH setBackgroundImage:[UIImage imageNamed:@"km_hover.png"] forState:UIControlStateSelected];
        btnForKMH.tag=1;
        [homeView addSubview:btnForKMH];
            
        
            
        btnForMPH = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnForMPH addTarget:self action:@selector(meterChangingAction:)
                forControlEvents:UIControlEventTouchUpInside];
        btnForMPH.frame = CGRectMake(162.0, 193.0, 25.0, 25.0);
        [btnForMPH setBackgroundImage:[UIImage imageNamed:@"mph.png"] forState:UIControlStateNormal];
        [btnForMPH setBackgroundImage:[UIImage imageNamed:@"mph_hover.png"] forState:UIControlStateHighlighted];
        [btnForMPH setBackgroundImage:[UIImage imageNamed:@"mph_hover.png"] forState:UIControlStateSelected];
        btnForMPH.tag=2;
        [homeView addSubview:btnForMPH];
        
        speedometerReading = [[UILabel alloc] initWithFrame:CGRectMake(118,224,85,44)];
        speedometerReading.textAlignment = NSTextAlignmentCenter;
        speedometerReading.backgroundColor = [UIColor clearColor];
        speedometerReading.font = [UIFont fontWithName:@"Roboto-Regular" size:27];
        speedometerReading.text= @"0";
        speedometerReading.textColor = [UIColor colorWithRed:254.0/255.0 green:214.0/255.0 blue:14.0/255.0 alpha:0.5];
        
        speedometerReading.shadowColor = [UIColor whiteColor];
        speedometerReading.shadowOffset = CGSizeMake(0,1);
        [homeView addSubview:speedometerReading ];
            
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"unit"]length] > 0)
        {
            if ([[[NSUserDefaults standardUserDefaults ]objectForKey:@"unit"] isEqual:@"KM"])
            {
                btnForKMH.selected=YES;
            }
            else if ([[[NSUserDefaults standardUserDefaults ]objectForKey:@"unit"] isEqual:@"MPH"])
            {
                btnForMPH.selected=YES;
            }
        }
        else
        {
            btnForMPH.selected = YES;
            meterImageView.image = [UIImage imageNamed:@"speedomph.png"];
            kmLabel.text=@"MPH";
            totalSpeedLabel.frame=CGRectMake(116, 393, 126, 37);
            [[NSUserDefaults standardUserDefaults ] setValue:@"MPH" forKey:@"unit"];
        }
    }
    
    if ([[[NSUserDefaults standardUserDefaults ]objectForKey:@"unit"] isEqual:@"KM"])
    {
        totalSpeedLabel.text = [NSString stringWithFormat:@"%.0f",[[[NSUserDefaults standardUserDefaults] valueForKey:@"totalDistance"] floatValue]/1000];
    }
    else if ([[[NSUserDefaults standardUserDefaults ]objectForKey:@"unit"] isEqual:@"MPH"])
    {
        totalSpeedLabel.text = [NSString stringWithFormat:@"%.0f",[[[NSUserDefaults standardUserDefaults] valueForKey:@"totalDistance"] floatValue]/1609];
    }
    
    
    if ([[[NSUserDefaults standardUserDefaults ]objectForKey:@"unit"] isEqual:@"KM"])
    {
        maxVal = @"240";
        speedometerCurrentValue = 0.0;
        prevAngleFactor = -118.4;
        angle = ((speedometerCurrentValue*380.8)/[maxVal floatValue])-124.0;
    }
    else
    {
        maxVal = @"240";
        speedometerCurrentValue = 0.0;
        prevAngleFactor = -118.4;
        angle = ((speedometerCurrentValue*380.8)/[maxVal floatValue])-124.0;
    }
    
    [self rotateNeedle];
}

- (void)meterChangingAction:(id)sender
{
    UIButton *btn=(UIButton *)sender;
   
    if (btn.tag==1)
    {
        if (IsIphone5)
        {
            totalSpeedLabel.frame=CGRectMake(108, 393, 126, 37);
        }
        else
        {
            totalSpeedLabel.frame=CGRectMake(108, 326, 126, 37);
        }
        
        meterImageView.image = [UIImage imageNamed:@"speedo.png"];
        btnForKMH.selected=YES;
        btnForMPH.selected=NO;
        kmLabel.text=@"KM";
        settingUnitname=@"KM";
        
        [[NSUserDefaults standardUserDefaults] setObject:self.settingUnitname forKey:@"unit"];
        [[NSUserDefaults standardUserDefaults]synchronize];

        maxVal = @"240";
        speedometerCurrentValue = 0.0;
        prevAngleFactor = -118.4;
        angle = ((speedometerCurrentValue*380.8)/[maxVal floatValue])-124.0;
        [self rotateNeedle];
    }
    else
    {
        if (IsIphone5)
        {
            totalSpeedLabel.frame=CGRectMake(116, 393, 126, 37);
        }
        else
        {
            totalSpeedLabel.frame=CGRectMake(116, 326, 126, 37);
        }
        
        meterImageView.image = [UIImage imageNamed:@"speedomph.png"];
        btnForMPH.selected=YES;
        btnForKMH.selected=NO;
        kmLabel.text=@"MPH";
        settingUnitname=@"MPH";
        
        [[NSUserDefaults standardUserDefaults] setObject:self.settingUnitname forKey:@"unit"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        maxVal = @"240";
        speedometerCurrentValue = 0.0;
        prevAngleFactor = -118.4;
        angle = ((speedometerCurrentValue*380.8)/[maxVal floatValue])-125.0;
        [self rotateNeedle];
    }
}

- (IBAction)mapAction:(id)sender
{
    MapScreen *mapScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"MapScreen"];
    [self.navigationController setViewControllers:[NSArray arrayWithObject:mapScreen] animated:YES];
}

- (IBAction)hudAction:(id)sender
{
    HudScreen *hudScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"HudScreen"];
    [self.navigationController setViewControllers:[NSArray arrayWithObject:hudScreen] animated:YES];
}

- (IBAction)menuAction:(id)sender
{
    [self.menuContainerViewController toggleRightSideMenuCompletion:nil];
}

- (IBAction)lemosysAction:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.lemosys.com/"]];
}


#pragma mark -
#pragma mark calculateDeviationAngle Method

-(void) calculateDeviationAngle
{
    if ([[[NSUserDefaults standardUserDefaults ]objectForKey:@"unit"] isEqual:@"KM"])
    {
        float difference_angle; // This Angle differece from 0 from dialer to start of niddle location -132
    
        int MaxDialerDigit; //In KM dialer having max 330 Speed.
   
        difference_angle=124; // This Angle differece from 0 from dialer to start of niddle location -132
        MaxDialerDigit =240; //In KM dialer having max 330 Speed.
    
        if(speedometerCurrentValue==0 || speedometerCurrentValue<=0)
        {
            // if speed is Zero based on Km angle of Dilar -132
            angle=-difference_angle;
        }
        else if(speedometerCurrentValue>0 && speedometerCurrentValue <= difference_angle)
        {
            if (speedometerCurrentValue>60 && speedometerCurrentValue <=80)
            {
                angle=(speedometerCurrentValue-123);
            }
            else if (speedometerCurrentValue>80 && speedometerCurrentValue <=100)
            {
                angle=(speedometerCurrentValue-122);
            }
            else if (speedometerCurrentValue>100 && speedometerCurrentValue <=110)
            {
                angle=(speedometerCurrentValue-121);
            }
            else if (speedometerCurrentValue>110 && speedometerCurrentValue <=120)
            {
                angle=(speedometerCurrentValue-120);
            }
            else
            {
                angle=(speedometerCurrentValue-123.80);
            }
        }
        else if(speedometerCurrentValue>difference_angle && speedometerCurrentValue <= MaxDialerDigit)
        {
            if(speedometerCurrentValue>=MaxDialerDigit)
            {
                angle=difference_angle;
            }
            else if(speedometerCurrentValue>=difference_angle && speedometerCurrentValue<=MaxDialerDigit)
            {
                angle= (float)(speedometerCurrentValue - difference_angle)*(float)1.11;
            }
            if (speedometerCurrentValue>120 && speedometerCurrentValue <=140)
            {
                angle=(speedometerCurrentValue-120);
            }
            else if (speedometerCurrentValue>140 && speedometerCurrentValue <=160)
            {
                angle=(speedometerCurrentValue-119);
            }
        
            else if (speedometerCurrentValue>160 && speedometerCurrentValue <=180)
            {
                angle=(speedometerCurrentValue-118);
            }
            else if (speedometerCurrentValue>180 && speedometerCurrentValue <=200)
            {
                angle=(speedometerCurrentValue-117);
            }
            else if (speedometerCurrentValue>180 && speedometerCurrentValue <=200)
            {
                angle=(speedometerCurrentValue-116);
            }
            else if (speedometerCurrentValue>200 && speedometerCurrentValue <=220)
            {
                angle=(speedometerCurrentValue-117);
            }
            else if (speedometerCurrentValue>220 && speedometerCurrentValue<=240)
            {
                angle=(speedometerCurrentValue-117);
            }
        }
        else
        {
            angle=(float)difference_angle;
        }
    }
    else
    {
        float difference_angle; // This Angle differece from 0 from dialer to start of niddle location -132
        int MaxDialerDigit; //In KM dialer having max 330 Speed.
        
        difference_angle=124; // This Angle differece from 0 from dialer to start of niddle location -132
        MaxDialerDigit =120; //In KM dialer having max 330 Speed.
        
        if(speedometerCurrentValue==0 || speedometerCurrentValue<=0)
        {
            // if speed is Zero based on Km angle of Dilar -132
            angle=-124;
        }
        else if(speedometerCurrentValue>0 && speedometerCurrentValue <= difference_angle)
        {
            if (speedometerCurrentValue>5 && speedometerCurrentValue<=10)
            {
                angle=(speedometerCurrentValue-118);
            }
            else if (speedometerCurrentValue>10 && speedometerCurrentValue<=15)
            {
                angle=(speedometerCurrentValue-113);
            }
            else if (speedometerCurrentValue>15 && speedometerCurrentValue<=20)
            {
                angle=(speedometerCurrentValue-108);
            }
            else if (speedometerCurrentValue>20 && speedometerCurrentValue<=25)
            {
                angle=(speedometerCurrentValue-103);
            }
            else if (speedometerCurrentValue>25 && speedometerCurrentValue<=30)
            {
                angle=(speedometerCurrentValue-98);
            }
            else if (speedometerCurrentValue>30 && speedometerCurrentValue<=35)
            {
                angle=(speedometerCurrentValue-93);
            }
            else if (speedometerCurrentValue>35 && speedometerCurrentValue<=40)
            {
                angle=(speedometerCurrentValue-87);
            }
            else if (speedometerCurrentValue>40 && speedometerCurrentValue<=45)
            {
                angle=(speedometerCurrentValue-82);
            }
            else if (speedometerCurrentValue>45 && speedometerCurrentValue <=50)
            {
                angle=(speedometerCurrentValue-78);
            }
            else if (speedometerCurrentValue>50 && speedometerCurrentValue<=55)
            {
                angle=(speedometerCurrentValue-73);
            }
            else if (speedometerCurrentValue>55 && speedometerCurrentValue<=60)
            {
                angle=(speedometerCurrentValue-68);
            }
            else if (speedometerCurrentValue>55 && speedometerCurrentValue<=60)
            {
                angle=(speedometerCurrentValue-63);
            }
            else if (speedometerCurrentValue>60 && speedometerCurrentValue<=65)
            {
                angle=(speedometerCurrentValue-58);
            }
            else if (speedometerCurrentValue>65 && speedometerCurrentValue<=70)
            {
                angle=(speedometerCurrentValue-53);
            }
            else if (speedometerCurrentValue >70 && speedometerCurrentValue <=75)
            {
                angle=(speedometerCurrentValue-48);
            }
            else if (speedometerCurrentValue >75 && speedometerCurrentValue<=80)
            {
                angle=(speedometerCurrentValue-43);
            }
            else if (speedometerCurrentValue>80 && speedometerCurrentValue<=85)
            {
                angle=(speedometerCurrentValue-38);
            }
            else if (speedometerCurrentValue>85 && speedometerCurrentValue<=90)
            {
                angle=(speedometerCurrentValue-33);
            }
            else if (speedometerCurrentValue>90 && speedometerCurrentValue<=95)
            {
                angle=(speedometerCurrentValue-28);
            }
            else if (speedometerCurrentValue>95 && speedometerCurrentValue<=100)
            {
                angle=(speedometerCurrentValue-23);
            }
            else if (speedometerCurrentValue>100 && speedometerCurrentValue<=105)
            {
                angle=(speedometerCurrentValue-18);
            }
            else if (speedometerCurrentValue >105 && speedometerCurrentValue<=110)
            {
                angle=(speedometerCurrentValue-13);
            }
            else if (speedometerCurrentValue>110 && speedometerCurrentValue<=115)
            {
                angle=(speedometerCurrentValue-8);
            }
            else if (speedometerCurrentValue >115 && speedometerCurrentValue<=120)
            {
                angle=(speedometerCurrentValue+4);
            }
            else
            {
                angle=(speedometerCurrentValue-124.0);
            }
         }
     }
    [self rotateNeedle];
}

#pragma mark rotateNeedle Method

-(void) rotateNeedle
{
    needleImageView.layer.anchorPoint=CGPointMake(0.5f,0.5f);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [needleImageView setTransform:CGAffineTransformMakeRotation((M_PI/180)*angle)];
    [UIView commitAnimations];
}

#pragma mark -
#pragma mark Speedometer needle Rotation View Methods

-(void) rotateIt:(float)angl
{
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.01f];
	[needleImageView setTransform: CGAffineTransformMakeRotation((M_PI/180) *angl)];
	[UIView commitAnimations];
}

#pragma mark CustomView Delegate Method.

- (void)alertAction:(NSString *)msg{
    
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
    
}


#pragma mark LOcation delegate

//-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation

- (void) dpdateLabelData
{
    //Make the Array of All Lat and Lng
    
    int currenSpeed = [[[NSUserDefaults standardUserDefaults] valueForKey:@"currentSpeed"] intValue];
    
    if (currenSpeed < 0)
    {
        currenSpeed = 0;
    }
    NSNumber *total = [[NSUserDefaults standardUserDefaults] valueForKey:@"totalDistance"];
        
    if ([[[NSUserDefaults standardUserDefaults ]objectForKey:@"unit"] isEqual:@"KM"])
    {
        speedometerReading.text = [NSString stringWithFormat:@"%.0f",currenSpeed * 3.6];
        totalSpeedLabel.text = [NSString stringWithFormat:@"%d",[total intValue]/1000];
    }
    else if ([[[NSUserDefaults standardUserDefaults ]objectForKey:@"unit"] isEqual:@"MPH"])
    {
        speedometerReading.text = [NSString stringWithFormat:@"%.0f",currenSpeed * 2.23693629];
        totalSpeedLabel.text = [NSString stringWithFormat:@"%d",[total intValue]/1609];
    }
    else
    {
        speedometerReading.text = @"0";
    }
    
    speedometerCurrentValue = [speedometerReading.text floatValue];
    
    [self calculateDeviationAngle];
}

/*
-(void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    float mHeading = newHeading.magneticHeading;
    
    if ((mHeading >= 339) || (mHeading <= 22))
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"N" forKey:@"direction"];
    }
    else if ((mHeading > 23) && (mHeading <= 68))
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"NE" forKey:@"direction"];
    }
    else if ((mHeading > 69) && (mHeading <= 113))
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"E" forKey:@"direction"];
    }
    else if ((mHeading > 114) && (mHeading <= 158))
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"SE" forKey:@"direction"];
    }
    else if ((mHeading > 159) && (mHeading <= 203))
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"S" forKey:@"direction"];
    }
    else if ((mHeading > 204) && (mHeading <= 248))
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"SW" forKey:@"direction"];
    }
    else if ((mHeading > 249) && (mHeading <= 293))
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"W" forKey:@"direction"];
    }
    else if ((mHeading > 294) && (mHeading <= 338))
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"NW" forKey:@"direction"];
    }
    
    float oldRad =  -manager.heading.trueHeading * M_PI / 180.0f;
    float newRad =  -newHeading.trueHeading * M_PI / 180.0f;
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%f",oldRad] forKey:@"oldradians"];
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%f",newRad] forKey:@"newradians"];
}
*/
@end
