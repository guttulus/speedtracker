//
//  ChangePasswordViewController.m
//  M-Track
//
//  Created by Test on 24/04/14.
//  Copyright (c) 2014 lemosys. All rights reserved.
//

#import "ForgetPasswordController.h"
#import "LoginViewController.h"
#import "DriverOnline.h"


@interface ForgetPasswordController (){

    AppResourceObject *appResourceObject;

}

@end

@implementation ForgetPasswordController
@synthesize txtFieldForEmail;

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
    
    NSAttributedString *coloredPlaceholder = [[NSAttributedString alloc] initWithString:@"Email  Address" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    [self.txtFieldForEmail setAttributedPlaceholder:coloredPlaceholder];
    
    
    // Do any additional setup after loading the view.
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleBlackOpaque;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
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

- (IBAction)changePasswordAction:(id)sender {

    appResourceObject = [AppResourceObject sharedAppResource];

    if (appResourceObject.connectionStatus) {


    NSError *error = NULL;
    NSString *regExPattern = @"^[A-Z0-9._]+@[A-Z.]+\\.[A-Z]{2,4}$";
    NSRegularExpression *regEx = [[NSRegularExpression alloc] initWithPattern:regExPattern options:NSRegularExpressionCaseInsensitive error:&error];
    
    if (self.txtFieldForEmail.text.length==0) {
        [self.txtFieldForEmail becomeFirstResponder];
        [self alertAction:@"Please enter your Email id"];
        
    }else if([[self.txtFieldForEmail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]isEqualToString:@""]){
        [self.txtFieldForEmail becomeFirstResponder];
        [self alertAction:@"Please enter your email Id"];
        
    } else if ([regEx numberOfMatchesInString:self.txtFieldForEmail.text options:0 range:NSMakeRange(0, [self.txtFieldForEmail.text length])]==0) {
        [self.txtFieldForEmail becomeFirstResponder];
        [self alertAction:@"Please enter valid email Id"];

    }
else
{
    [[[DriverOnline alloc] init] forgetPassword:self.txtFieldForEmail.text];

    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"passwordupdatedStatus"] integerValue]==1){
        
        UIAlertView *Alert=[[UIAlertView alloc]initWithTitle:@"" message:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"forgetpasswordupdatedMessage"]] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [Alert show];
        LoginViewController *loginViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        [loginViewController setHidesBottomBarWhenPushed:YES];
        //[self.navigationController pushViewController:loginViewController animated:NO];
        [self.navigationController setViewControllers:[NSArray arrayWithObject:loginViewController] animated:YES];
        
    
    }else{
        [self alertAction:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"forgetpasswordupdatedMessage"]]];
    }
    
      }
    }else{

        [self alertAction:@"Please connect internet!!!"];

    }

}

- (IBAction)registerAction:(id)sender {
}

- (IBAction)tryUsnowAction:(id)sender {
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}




- (void)alertAction:(NSString *)msg{
        
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        
    }

- (void)dealloc{

}




@end
