//
//  ChangePasswordViewController.h
//  M-Track
//
//  Created by Test on 24/04/14.
//  Copyright (c) 2014 lemosys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgetPasswordController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *txtFieldForEmail;
- (IBAction)changePasswordAction:(id)sender;
- (IBAction)registerAction:(id)sender;
- (IBAction)tryUsnowAction:(id)sender;

@end
