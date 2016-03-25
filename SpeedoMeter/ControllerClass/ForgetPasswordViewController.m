//
//  ForgetPasswordViewController.m

//
//  Created by Test on 23/04/14.
//  Copyright (c) 2014 lemosys. All rights reserved.
//
#import "LoginViewController.h"
#import "ForgetPasswordViewController.h"
#import "AppResourceObject.h"
#import "DriverOnline.h"
#import "MFSideMenu.h"
#import "MapScreen.h"
#import "HomeScreen.h"

@interface ForgetPasswordViewController ()
{
    AppResourceObject *appResourcesObject;
    MBProgressHUD *HUD;
}

@end

@implementation ForgetPasswordViewController

@synthesize txtFieldForOLdPassword;
@synthesize txtFieldForNewPassword;
@synthesize conformPassword;
@synthesize passwordScrollView;

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
    
    passwordScrollView.delegate=self;
    
    NSAttributedString *coloredPlaceholder = [[NSAttributedString alloc] initWithString:@"Old Password" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:231.0/255.0 green:231.0/255.0 blue:231.0/255.0 alpha:0.5]}];
    [txtFieldForOLdPassword setAttributedPlaceholder:coloredPlaceholder];
    
    NSAttributedString *coloredPlaceholder1 = [[NSAttributedString alloc] initWithString:@"New Password" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:231.0/255.0 green:231.0/255.0 blue:231.0/255.0 alpha:0.5]}];
    [txtFieldForNewPassword setAttributedPlaceholder:coloredPlaceholder1];
    
    NSAttributedString *coloredPlaceholder2 = [[NSAttributedString alloc] initWithString:@"Conform Password" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:231.0/255.0 green:231.0/255.0 blue:231.0/255.0 alpha:0.5]}];
    [conformPassword setAttributedPlaceholder:coloredPlaceholder2];
    
    txtFieldForOLdPassword.textColor=[UIColor colorWithRed:231.0/255.0 green:231.0/255.0 blue:231.0/255.0 alpha:0.5];
    txtFieldForNewPassword.textColor=[UIColor colorWithRed:231.0/255.0 green:231.0/255.0 blue:231.0/255.0 alpha:0.5];
    conformPassword.textColor=[UIColor colorWithRed:231.0/255.0 green:231.0/255.0 blue:231.0/255.0 alpha:0.5];

    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    
    HUD.delegate = self;
    HUD.labelText = @"Loading...";
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
        if(textField == txtFieldForNewPassword)
        {
            [UIView beginAnimations:Nil context:NULL];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDuration:0.5];
            [UIView setAnimationBeginsFromCurrentState:YES];
            passwordScrollView.frame = CGRectMake(passwordScrollView.frame.origin.x,(passwordScrollView.frame.origin.y-65) , passwordScrollView.frame.size.width, passwordScrollView.frame.size.height);
            [UIView commitAnimations];
        }
        else if(textField == txtFieldForOLdPassword)
        {
            [UIView beginAnimations:Nil context:NULL];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDuration:0.5];
            [UIView setAnimationBeginsFromCurrentState:YES];
            passwordScrollView.frame = CGRectMake(passwordScrollView.frame.origin.x,(passwordScrollView.frame.origin.y-20) , passwordScrollView.frame.size.width, passwordScrollView.frame.size.height);
            [UIView commitAnimations];
        }
        else if(textField == conformPassword)
        {
            [UIView beginAnimations:Nil context:NULL];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDuration:0.5];
            [UIView setAnimationBeginsFromCurrentState:YES];
            passwordScrollView.frame = CGRectMake(passwordScrollView.frame.origin.x,(passwordScrollView.frame.origin.y-95) , passwordScrollView.frame.size.width, passwordScrollView.frame.size.height);
            [UIView commitAnimations];
        }
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    CGSize result = [[UIScreen mainScreen] bounds].size;
    
    if (result.height == 480)
    {
        if(textField == txtFieldForNewPassword)
        {
            [UIView beginAnimations:Nil context:NULL];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDuration:0.5];
            [UIView setAnimationBeginsFromCurrentState:YES];
            passwordScrollView.frame = CGRectMake(passwordScrollView.frame.origin.x,(passwordScrollView.frame.origin.y+65) , passwordScrollView.frame.size.width, passwordScrollView.frame.size.height);
            [UIView commitAnimations];
        }
        else if(textField == txtFieldForOLdPassword)
        {
            [UIView beginAnimations:Nil context:NULL];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDuration:0.5];
            [UIView setAnimationBeginsFromCurrentState:YES];
            passwordScrollView.frame = CGRectMake(passwordScrollView.frame.origin.x,(passwordScrollView.frame.origin.y+20) , passwordScrollView.frame.size.width, passwordScrollView.frame.size.height);
            [UIView commitAnimations];
        }
        else if(textField == conformPassword)
        {
            [UIView beginAnimations:Nil context:NULL];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDuration:0.5];
            [UIView setAnimationBeginsFromCurrentState:YES];
            passwordScrollView.frame = CGRectMake(passwordScrollView.frame.origin.x,(passwordScrollView.frame.origin.y+95) , passwordScrollView.frame.size.width, passwordScrollView.frame.size.height);
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)submitButton:(id)sender
{
    appResourcesObject = [AppResourceObject sharedAppResource];

    if (appResourcesObject.connectionStatus)
    {
        [HUD show:YES];

        if ([[txtFieldForOLdPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]isEqualToString:@""])
        {
            [txtFieldForOLdPassword becomeFirstResponder];
            [self alertAction:@"Please enter your old password"];
            [HUD hide:YES];

        }
        else if ([[txtFieldForNewPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]isEqualToString:@""])
        {
            [txtFieldForNewPassword becomeFirstResponder];
            [self alertAction:@"Please enter your new password"];
            [HUD hide:YES];
        }
        else if ([[conformPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]isEqualToString:@""])
        {
            [conformPassword becomeFirstResponder];
            [self alertAction:@"Please reenter your new password"];
            [HUD hide:YES];
        }
        else if (![self.txtFieldForNewPassword.text isEqualToString:self.conformPassword.text])
        {
            [conformPassword becomeFirstResponder];
            [self alertAction:@"Sorry your password doesn't match"];
            [HUD hide:YES];

        }
        else
        {
        
            [[[DriverOnline alloc] init] changePassword:txtFieldForOLdPassword.text withConfirmPassword:txtFieldForNewPassword.text];
            [HUD hide:YES];
            
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"passwordupdatedStatus"] integerValue]==1)
            {
                appResourcesObject = [AppResourceObject sharedAppResource];

                appResourcesObject.check=TRUE;
                UIAlertView *cancelAlert=[[UIAlertView alloc]initWithTitle:@"" message:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"passwordupdatedMessage"]] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                [cancelAlert show];
            
            }
            else
            {
                [self alertAction:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"passwordupdatedMessage"]]];
            }
        }
    }
    else
    {
        [self alertAction:@"Please connect internet!!!"];
    }
}

- (IBAction)settingAction:(id)sender
{
    //pop to specific view controller
    HomeScreen *back = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeScreen"];
    NSMutableArray *vcs =  [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    NSLog(@"vcs=%@",vcs);
    [vcs insertObject:back atIndex:[vcs count]-1];
    [self.navigationController setViewControllers:vcs animated:NO];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (appResourcesObject.check==TRUE)
    {
        if (buttonIndex == 0)
        {
            CATransition *transition = [CATransition animation];
            transition.duration = 0.4;
            transition.timingFunction = [CAMediaTimingFunction
                                     functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            transition.type = kCATransitionPush;
            transition.subtype = kCATransitionFromLeft;
            [self.view.window.layer addAnimation:transition forKey:nil];
        
            LoginViewController *homeScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
            [homeScreen setHidesBottomBarWhenPushed:YES];
            [self.navigationController setViewControllers:[NSArray arrayWithObject:homeScreen] animated:NO];
        }
    }
}

- (IBAction)headerAction:(id)sender
{
    NSInteger i = [sender tag];
    NSLog(@"i is %ld",(long)i);
    
    UIButton *btn = (UIButton *)sender;
    NSLog(@"button tag is %ld",(long)btn.tag);
    btn.tag = btn.tag - 40;
    
    NSLog(@"button tag is %ld",(long)btn.tag);
    
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
        MapScreen *mapScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"MapScreen"];
        [self.navigationController setViewControllers:[NSArray arrayWithObject:mapScreen] animated:YES];
        [self.navigationController setViewControllers:[NSArray arrayWithObject:mapScreen] animated:YES];
    }
    else if (btn.tag == 3)
    {
        HudScreen *hudScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"HudScreen"];
        [self.navigationController setViewControllers:[NSArray arrayWithObject:hudScreen] animated:YES];
        hudScreen = nil;
    }
}

- (IBAction)menuAction:(id)sender
{
    [self.menuContainerViewController toggleRightSideMenuCompletion:nil];
}

- (IBAction)lemosysAction:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.lemosys.com/"]];
}

- (void) alertAction:(NSString *)msg
{
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}

@end
