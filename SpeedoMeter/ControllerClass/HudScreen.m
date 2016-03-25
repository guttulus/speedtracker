//
//  HudScreen.m
//  SpeedoMeter
//
//  Created by lemosys on 15/01/14.
//  Copyright (c) 2014 lemosys. All rights reserved.
//

#import "HudScreen.h"
#import "AppResourceObject.h"
#import "DriverOffline.h"
#import "HomeScreen.h"
#import "MapScreen.h"
#import "MFSideMenu.h"

@interface HudScreen (){
    
    AppResourceObject *appResourceObject;
    NSMutableArray *setting_detail;
    
    NSTimer *dataUpdate;
}

@end

@implementation HudScreen

@synthesize kmlabel;
@synthesize speedbtn;
@synthesize mapbtn;
@synthesize hudbtn;
@synthesize speedCounterLabel;
@synthesize speed;
@synthesize currentSpeed;
@synthesize homeView;
@synthesize footerImageView;
@synthesize blackTopHeader;
@synthesize footerlineImage;
@synthesize firstDivider;
@synthesize secondDivider;
@synthesize thirdDivider;
@synthesize fourthDivider;
@synthesize tripbtn;
@synthesize settingbtn;
@synthesize compassImage;

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
    // Do any additional setup after loading the view.

    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"unit"] isEqual:@"MPH"])
    {
        kmlabel.text = @"mph";
    }
    else
    {
        kmlabel.text = @"Km/h";
    }
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [hudbtn setSelected:YES];
    
    speedCounterLabel.font = [UIFont fontWithName:@"Roboto-Condensed" size:135];
    speedCounterLabel.textColor = [UIColor whiteColor];
    speedCounterLabel.backgroundColor = [UIColor clearColor];
    CGAffineTransform rotate = CGAffineTransformMakeRotation(3.14/2);
    CGAffineTransform scale = CGAffineTransformMakeScale(1,-1);
    speedCounterLabel.transform = CGAffineTransformConcat(rotate,scale);
    CGAffineTransform rotateKm = CGAffineTransformMakeRotation(3.14/2);
    CGAffineTransform scaleKm = CGAffineTransformMakeScale(1,-1);
    kmlabel.transform = CGAffineTransformConcat(rotateKm,scaleKm);
    kmlabel.backgroundColor = [UIColor clearColor];
    kmlabel.textColor = [UIColor whiteColor];
    kmlabel.font =  [UIFont fontWithName:@"Roboto-Condensed" size:40];
    
    dataUpdate = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateSpeedLabel) userInfo:nil repeats:YES];
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7"))
    {
        [self.view bringSubviewToFront:self.blackTopHeader];
    }
    
    [self.view bringSubviewToFront:homeView];
    [self.view bringSubviewToFront:footerlineImage];
    [self.view bringSubviewToFront:footerImageView];
    [self.view bringSubviewToFront:speedbtn];
    [self.view bringSubviewToFront:firstDivider];
    [self.view bringSubviewToFront:mapbtn];
    [self.view bringSubviewToFront:secondDivider];
    [self.view bringSubviewToFront:hudbtn];
    [self.view bringSubviewToFront:thirdDivider];
    [self.view bringSubviewToFront:tripbtn];
    [self.view bringSubviewToFront:fourthDivider];
    [self.view bringSubviewToFront:settingbtn];
    
    
    self.speedbtn.tag = 41;
    self.mapbtn.tag = 42;
    self.hudbtn.tag = 43;
    tripbtn.tag = 44;
    settingbtn.tag = 45;
}

- (void) updateSpeedLabel
{
    int currentSpped = [[[NSUserDefaults standardUserDefaults] objectForKey:@"currentSpeed"] intValue];
    
    if (currentSpped < 0)
    {
        currentSpped = 0;
    }
    
    if ([[[NSUserDefaults standardUserDefaults ] objectForKey:@"unit"] isEqual:@"KM"])
    {
        speedCounterLabel.text = [NSString stringWithFormat:@"%.0f",currentSpped * 3.6];
    }
    else if ([[[NSUserDefaults standardUserDefaults ] objectForKey:@"unit"] isEqual:@"MPH"])
    {
        speedCounterLabel.text = [NSString stringWithFormat:@"%.0f",currentSpped * 2.23693629];

    }
    
    CABasicAnimation *theAnimation;
    theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    theAnimation.fromValue = [NSNumber numberWithFloat:[[[NSUserDefaults standardUserDefaults] objectForKey:@"oldradians"] floatValue]];
    theAnimation.toValue=[NSNumber numberWithFloat:[[[NSUserDefaults standardUserDefaults] objectForKey:@"newradians"] floatValue]];
    theAnimation.duration = 0.5f;
    [compassImage.layer addAnimation:theAnimation forKey:@"animateMyRotation"];
    compassImage.transform = CGAffineTransformMakeRotation([[[NSUserDefaults standardUserDefaults] objectForKey:@"newradians"] floatValue]);
}


- (IBAction)footerButtonAction:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    btn.tag = btn.tag - 40;
    
    if (btn.tag == 1)
    {
        [self.view.window.layer removeAllAnimations];
        CATransition *transition = [CATransition animation];
        transition.duration = 0.4;
        transition.timingFunction = [CAMediaTimingFunction
                                     functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromLeft;
        [self.view.window.layer addAnimation:transition forKey:nil];
        HomeScreen *homeScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeScreen"];
        [homeScreen setHidesBottomBarWhenPushed:YES];
        [self.navigationController setViewControllers:[NSArray arrayWithObject:homeScreen] animated:NO];
        homeScreen = nil;
    }
    else if (btn.tag == 2)
    {
        [self.view.window.layer removeAllAnimations];
        CATransition *transition = [CATransition animation];
        transition.duration = 0.4;
        transition.timingFunction = [CAMediaTimingFunction
                                     functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromLeft;
        [self.view.window.layer addAnimation:transition forKey:nil];
        MapScreen *mapScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"MapScreen"];
        [self.navigationController setViewControllers:[NSArray arrayWithObject:mapScreen] animated:YES];

        [mapScreen setHidesBottomBarWhenPushed:YES];
    }
    else if (btn.tag == 3)
    {
    }
    else if (btn.tag == 4)
    {
    }
    else if (btn.tag == 5)
    {
    }
}

-(void)dealloc
{
    [dataUpdate invalidate];
    dataUpdate = nil;
}

- (void)viewDidUnload
{
    [self setSpeedbtn:nil];
    [self setMapbtn:nil];
    [self setHudbtn:nil];
    [self setTripbtn:nil];
    [self setSettingbtn:nil];
    [self setSpeedCounterLabel:nil];
    [self setKmlabel:nil];
    [self setFooterlineImage:nil];
    [self setFooterImageView:nil];
    [self setFirstDivider:nil];
    [self setSecondDivider:nil];
    [self setThirdDivider:nil];
    [self setFourthDivider:nil];
    
    [super viewDidUnload];
}

- (IBAction)menuAction:(id)sender
{
    [self.menuContainerViewController toggleRightSideMenuCompletion:nil];
}

- (IBAction)lemosysAction:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.lemosys.com/"]];
}

@end
