//
//  RegistrationViewController.h

//
//  Created by Test on 22/04/14.
//  Copyright (c) 2014 lemosys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import <CoreLocation/CoreLocation.h>

@interface RegistrationViewController : UIViewController<UIScrollViewDelegate,MBProgressHUDDelegate>

@property (strong, nonatomic) NSString *settingUnitname;

@property (strong, nonatomic) IBOutlet UIImageView *black_header;
@property (strong, nonatomic) IBOutlet UITextField *txtFieldForEmail;
@property (strong, nonatomic) IBOutlet UITextField *txtFieldForPassword;
@property (strong, nonatomic) IBOutlet UITextField *txtFieldForConformPasword;
@property (strong, nonatomic) IBOutlet UIScrollView *registrationScrollView;

- (IBAction)registerAction:(id)sender ;
- (IBAction)back:(id)sender;
- (IBAction)lemosysAction:(id)sender;

@end


