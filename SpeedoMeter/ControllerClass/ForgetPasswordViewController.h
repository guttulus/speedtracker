//
//  ForgetPasswordViewController.h

//
//  Created by Test on 23/04/14.
//  Copyright (c) 2014 lemosys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import"MBProgressHUD.h"
@interface ForgetPasswordViewController : UIViewController<UIScrollViewDelegate,MBProgressHUDDelegate>

@property (strong, nonatomic) IBOutlet UITextField *txtFieldForOLdPassword;
@property (strong, nonatomic) IBOutlet UITextField *txtFieldForNewPassword;
@property (strong, nonatomic) IBOutlet UITextField *conformPassword;
@property (strong, nonatomic) IBOutlet UIScrollView *passwordScrollView;

- (IBAction)submitButton:(id)sender;
- (IBAction)headerAction:(id)sender;
- (IBAction)menuAction:(id)sender;
- (IBAction)lemosysAction:(id)sender;

@end
