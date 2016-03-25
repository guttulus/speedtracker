//
//  RegistrationViewController.m

//
//  Created by Test on 22/04/14.
//  Copyright (c) 2014 lemosys. All rights reserved.
//

#import "RegistrationViewController.h"
#import "AppResourceObject.h"
#import "AddUser.h"
#import "HomeScreen.h"
#import "DriverOnline.h"
#import "MFSideMenu.h"
#import <CoreLocation/CoreLocation.h>
#import "DriverOffline.h"

@interface RegistrationViewController ()
{
    AppResourceObject *appResourceObject;
    NSMutableArray *data;
    MBProgressHUD *HUD;
}

@end

@implementation RegistrationViewController

@synthesize txtFieldForEmail,txtFieldForPassword,txtFieldForConformPasword;
@synthesize settingUnitname;
@synthesize registrationScrollView;

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
    self.registrationScrollView.delegate = self;
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate = self;
    HUD.labelText = @"Loading...";
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    NSAttributedString *coloredPlaceholder = [[NSAttributedString alloc] initWithString:@"Email Address" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:231.0/255.0 green:231.0/255.0 blue:231.0/255.0 alpha:0.5]}];
    [txtFieldForEmail setAttributedPlaceholder:coloredPlaceholder];
    
    NSAttributedString *coloredPlaceholder1 = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:231.0/255.0 green:231.0/255.0 blue:231.0/255.0 alpha:0.5]}];
    [txtFieldForPassword setAttributedPlaceholder:coloredPlaceholder1];
    
    NSAttributedString *coloredPlaceholder2 = [[NSAttributedString alloc] initWithString:@"Conform Password" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:231.0/255.0 green:231.0/255.0 blue:231.0/255.0 alpha:0.5]}];
    [txtFieldForConformPasword setAttributedPlaceholder:coloredPlaceholder2];
    
    txtFieldForEmail.textColor=[UIColor colorWithRed:231.0/255.0 green:231.0/255.0 blue:231.0/255.0 alpha:0.5];
    txtFieldForPassword.textColor=[UIColor colorWithRed:231.0/255.0 green:231.0/255.0 blue:231.0/255.0 alpha:0.5];
    txtFieldForConformPasword.textColor=[UIColor colorWithRed:231.0/255.0 green:231.0/255.0 blue:231.0/255.0 alpha:0.5];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGSize result = [[UIScreen mainScreen] bounds].size;
    
    if (result.height == 480)
    {
        if(textField == txtFieldForEmail)
        {
            [UIView beginAnimations:Nil context:NULL];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDuration:0.5];
            [UIView setAnimationBeginsFromCurrentState:YES];
            registrationScrollView.frame = CGRectMake(registrationScrollView.frame.origin.x,(registrationScrollView.frame.origin.y-10) , registrationScrollView.frame.size.width, registrationScrollView.frame.size.height);
            [UIView commitAnimations];
        }
        else if(textField == txtFieldForPassword)
        {
            [UIView beginAnimations:Nil context:NULL];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDuration:0.5];
            [UIView setAnimationBeginsFromCurrentState:YES];
            registrationScrollView.frame = CGRectMake(registrationScrollView.frame.origin.x,(registrationScrollView.frame.origin.y-47) , registrationScrollView.frame.size.width, registrationScrollView.frame.size.height);
            [UIView commitAnimations];
        }
        else if(textField == txtFieldForConformPasword)
        {
            [UIView beginAnimations:Nil context:NULL];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDuration:0.5];
            [UIView setAnimationBeginsFromCurrentState:YES];
            registrationScrollView.frame = CGRectMake(registrationScrollView.frame.origin.x,(registrationScrollView.frame.origin.y-70) , registrationScrollView.frame.size.width, registrationScrollView.frame.size.height);
            [UIView commitAnimations];
        }
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    CGSize result = [[UIScreen mainScreen] bounds].size;
    
    if (result.height == 480)
    {
        if(textField == txtFieldForEmail)
        {
            [UIView beginAnimations:Nil context:NULL];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDuration:0.5];
            [UIView setAnimationBeginsFromCurrentState:YES];
            registrationScrollView.frame = CGRectMake(registrationScrollView.frame.origin.x,(registrationScrollView.frame.origin.y + 10) , registrationScrollView.frame.size.width, registrationScrollView.frame.size.height);
            [UIView commitAnimations];
        }
        else if(textField == txtFieldForPassword)
        {
            [UIView beginAnimations:Nil context:NULL];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDuration:0.5];
            [UIView setAnimationBeginsFromCurrentState:YES];
            registrationScrollView.frame = CGRectMake(registrationScrollView.frame.origin.x,(registrationScrollView.frame.origin.y+47) , registrationScrollView.frame.size.width, registrationScrollView.frame.size.height);
            [UIView commitAnimations];
        }
        else if(textField == txtFieldForConformPasword)
        {
            [UIView beginAnimations:Nil context:NULL];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDuration:0.5];
            [UIView setAnimationBeginsFromCurrentState:YES];
            registrationScrollView.frame = CGRectMake(registrationScrollView.frame.origin.x,(registrationScrollView.frame.origin.y + 70) , registrationScrollView.frame.size.width, registrationScrollView.frame.size.height);
            [UIView commitAnimations];
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"should return");
    [textField resignFirstResponder];
	return YES;
}

- (IBAction)registerAction:(id)sender
{
    appResourceObject = [AppResourceObject sharedAppResource];
    
    if (appResourceObject.connectionStatus)
    {
        [HUD show:YES];
        NSError *error = NULL;

        NSString *regExPattern = @"^[A-Z0-9._]+@[A-Z.]+\\.[A-Z]{2,4}$";
        NSRegularExpression *regEx = [[NSRegularExpression alloc] initWithPattern:regExPattern options:NSRegularExpressionCaseInsensitive error:&error];

        if (txtFieldForEmail.text.length==0)
        {
            [txtFieldForEmail becomeFirstResponder];
            [self alertAction:@"Please enter your Email id"];
            [HUD hide:YES];
        }
        else if([[txtFieldForEmail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]isEqualToString:@""])
        {
            [txtFieldForEmail becomeFirstResponder];
            [self alertAction:@"Please enter your email Id"];
            [HUD hide:YES];
        }
        else if ([regEx numberOfMatchesInString:txtFieldForEmail.text options:0 range:NSMakeRange(0, [txtFieldForEmail.text length])]==0)
        {
            [txtFieldForEmail becomeFirstResponder];
            [self alertAction:@"Please enter valid email Id"];
           [HUD hide:YES];

        }
        else if (txtFieldForPassword.text.length==0)
        {
           [txtFieldForPassword becomeFirstResponder];
           [self alertAction:@"Please enter your password"];
           [HUD hide:YES];

        }
        else if ([[txtFieldForPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]isEqualToString:@""])
        {
            [txtFieldForPassword becomeFirstResponder];
            [self alertAction:@"Please enter your password"];
            [HUD hide:YES];

        }
        else if (txtFieldForConformPasword.text.length==0)
        {
            [txtFieldForConformPasword becomeFirstResponder];
            [self alertAction:@"Please reenter your password"];
            [HUD hide:YES];

        }
        else if ([[txtFieldForConformPasword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]isEqualToString:@""])
        {
            [txtFieldForConformPasword becomeFirstResponder];
            [self alertAction:@"Please reenter your password"];
            [HUD hide:YES];
        }
        else if (![txtFieldForPassword.text isEqualToString:self.txtFieldForConformPasword.text])
        {
            [txtFieldForPassword becomeFirstResponder];
            [self alertAction:@"Sorry your password doesn't match"];
            [HUD hide:YES];
        }
        else
        {
//            if (self.CLController == nil)
//            {
//                
//                self.CLController = [[CoreLocationController alloc] init];
//                self.CLController.delegate = self;
//                self.CLController.locMgr.desiredAccuracy = kCLLocationAccuracyBest;
//                self.CLController.locMgr.distanceFilter = kCLDistanceFilterNone;
//                self.CLController.locMgr.headingFilter = 1;
//            }
//            
//            if([CLLocationManager locationServicesEnabled]){
//                
//                [self.CLController.locMgr startUpdatingLocation];
//                [self.CLController.locMgr startUpdatingHeading];
//                [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",@"availble" ] forKey:@"availble"];
//            }
//            else
//            {
//                [[NSUserDefaults standardUserDefaults] setObject:@"0.00000" forKey:@"newLongtitude"];
//                [[NSUserDefaults standardUserDefaults] setObject:@"0.00000" forKey:@"newLatitude"];
//            }
            
            AddUser *adduser = [[AddUser alloc] init];
            adduser.email_ID = txtFieldForEmail.text;
            adduser.password = txtFieldForPassword.text;
            adduser.deviceID = [[NSUserDefaults standardUserDefaults]  objectForKey:@"udid"];
            adduser.deviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"devicetoken"];
            adduser.usercurrentLat = [[[NSUserDefaults standardUserDefaults] objectForKey:@"newlatitude"]doubleValue];
            adduser.usercurrentLang = [[[NSUserDefaults standardUserDefaults] objectForKey:@"newlongtitude"]doubleValue];
            adduser.usercurrentLocation = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentLocation"];
            [[[DriverOnline alloc] init] SetUserDetail:adduser];
            
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"fbid"];
            
            adduser = nil;
            
            [HUD hide:YES];

            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"registrationStaus"] integerValue]==1)
            {
                UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"SpeedTracker" message:@"you have successfully registerd" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alertView show];
                alertView = nil;
            }
            else
            {
                [self alertAction:@"you enterd wrong email_id or password"];
            }
        }
    }
    else
    {
        [self alertAction:@"Please connect internet!!!"];
    }
}

- (IBAction)back:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)lemosysAction:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.lemosys.com/"]];
}

- (IBAction)forgetPassword:(id)sender
{

}
    
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
      if (buttonIndex == 0)
      {
          appResourceObject = [AppResourceObject sharedAppResource];
          appResourceObject.isloginwithFb = FALSE;
          appResourceObject.strForTryUsNow = @"NO";
          [[NSUserDefaults standardUserDefaults] setBool:appResourceObject.isloginwithFb forKey:@"loginwithfborGeust"];
          settingUnitname=@"KM";
          
          [[NSUserDefaults standardUserDefaults] setObject:self.settingUnitname forKey:@"unit"];
          [[NSUserDefaults standardUserDefaults] synchronize];
          
          UIStoryboard *mainStoryboard = nil;
          CGSize result = [[UIScreen mainScreen] bounds].size;
          
          if(result.height == 480)
          {
              NSLog(@"iphone 4");
              
              mainStoryboard = [UIStoryboard storyboardWithName:@"iPhone4" bundle:[NSBundle mainBundle]];
          }
          else if(result.height == 568)
          {
              NSLog(@"iphone 5");
              
              mainStoryboard = [UIStoryboard storyboardWithName:@"iPhone5" bundle:[NSBundle mainBundle]];
          }
          
          UIViewController *guestRightSideMenuViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"rightSideMenuViewController"];
          
          [self.menuContainerViewController setRightMenuViewController:guestRightSideMenuViewController];
          HomeScreen *homeScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeScreen"];
          [self.navigationController pushViewController:homeScreen animated:YES];
          homeScreen = nil;
      }
}

- (void)alertAction:(NSString *)msg
{
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Oops!" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
    alertView = nil;
}

@end
