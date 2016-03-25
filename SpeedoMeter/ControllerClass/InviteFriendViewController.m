//
//  SpeedTrackerMemberViewController.m
//  speedtracker
//
//  Created by Test on 26/11/14.
//  Copyright (c) 2014 lemosys. All rights reserved.
//

#import "InviteFriendViewController.h"
#import "MapScreen.h"
#import "MFSideMenu.h"
@interface InviteFriendViewController ()
{
    MBProgressHUD *HUD;
}

@end

@implementation InviteFriendViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    NSAttributedString *coloredPlaceholder = [[NSAttributedString alloc] initWithString:@"Email Address" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:231.0/255.0 green:231.0/255.0 blue:231.0/255.0 alpha:0.5]}];
    [_txtFieldForEmail setAttributedPlaceholder:coloredPlaceholder];
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)sendButtonAction:(id)sender
{
    AppResourceObject *appresources=[AppResourceObject sharedAppResource];
    if (appresources.connectionStatus)
    {
        [HUD show:YES];
        NSError *error = NULL;
        NSString *regExPattern = @"^[A-Z0-9._]+@[A-Z.]+\\.[A-Z]{2,4}$";
        NSRegularExpression *regEx = [[NSRegularExpression alloc] initWithPattern:regExPattern options:NSRegularExpressionCaseInsensitive error:&error];
        
        if (_txtFieldForEmail.text.length==0)
        {
            [_txtFieldForEmail becomeFirstResponder];
            [self alertAction:@"Please enter your Email id"];
            [HUD hide:YES];
        }
        else if([[_txtFieldForEmail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]isEqualToString:@""])
        {
            [_txtFieldForEmail becomeFirstResponder];
            [self alertAction:@"Please enter your email Id"];
            [HUD hide:YES];
        }
        else if ([regEx numberOfMatchesInString:_txtFieldForEmail.text options:0 range:NSMakeRange(0, [_txtFieldForEmail.text length])]==0)
        {
            [_txtFieldForEmail becomeFirstResponder];
            [self alertAction:@"Please enter valid email Id"];
            [HUD hide:YES];
        }
        else
        {
            [[[DriverOnline alloc] init] inviteFriends:_txtFieldForEmail.text];
            [HUD hide:YES];

            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"Status"] integerValue]==1)
            {
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:[[NSUserDefaults standardUserDefaults] objectForKey:@"Message"]delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                [alert show];
            }
            else
            {
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:[[NSUserDefaults standardUserDefaults] objectForKey:@"Message"]delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                [alert show];
            }
        }
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Oops" message:@"Internet not working." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    _txtFieldForEmail.text=@"";
    [_txtFieldForEmail resignFirstResponder];
}

- (IBAction)menuButtonAction:(id)sender
{
    [self.menuContainerViewController toggleRightSideMenuCompletion:nil];
}

- (IBAction)speedButtonAction:(id)sender
{
    HomeScreen *homeScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeScreen"];
    [self.navigationController setViewControllers:[NSArray arrayWithObject:homeScreen] animated:YES];
}

- (IBAction)hudButonAction:(id)sender
{
    HudScreen *hudScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"HudScreen"];
    [self.navigationController setViewControllers:[NSArray arrayWithObject:hudScreen] animated:YES];
}

- (IBAction)mapButtonAction:(id)sender
{
    MapScreen *mapScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"MapScreen"];
    [self.navigationController setViewControllers:[NSArray arrayWithObject:mapScreen] animated:YES];
}

- (IBAction)lemosysButtonAction:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.lemosys.com/"]];
}


// pragma mark is used for easy access of code in Xcode
#pragma mark - TextField Delegates

// This method is called once we click inside the textField
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGSize result = [[UIScreen mainScreen] bounds].size;
    
    if (result.height == 480)
    {
        if(textField == self.txtFieldForEmail)
        {
            [UIView beginAnimations:Nil context:NULL];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDuration:0.5];
            [UIView setAnimationBeginsFromCurrentState:YES];
            self.view.frame = CGRectMake(self.view.frame.origin.x,(self.view.frame.origin.y-60) , self.view.frame.size.width, self.view.frame.size.height);
            [UIView commitAnimations];
        }
    }
}

// This method is called once we complete editing
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    CGSize result = [[UIScreen mainScreen] bounds].size;
    
    if (result.height == 480)
    {
        if(textField == _txtFieldForEmail)
        {
            [UIView beginAnimations:Nil context:NULL];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDuration:0.5];
            [UIView setAnimationBeginsFromCurrentState:YES];
            self.view.frame = CGRectMake(self.view.frame.origin.x,(self.view.frame.origin.y+60) , self.view.frame.size.width, self.view.frame.size.height);
            [UIView commitAnimations];
        }
    }
}

// This method enables or disables the processing of return key
-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)alertAction:(NSString *)msg
{
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}

@end
