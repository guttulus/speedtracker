//
//  MyProfile.h
//  SpeedTracker
//
//  Created by Test on 11/12/14.
//  Copyright (c) 2014 lemosys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
@interface MyProfile : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *lblForName;
@property (strong, nonatomic) IBOutlet AsyncImageView *profileImage;
@property (strong, nonatomic) IBOutlet UIButton *backButton;

- (IBAction)backAction:(id)sender;
- (IBAction)speedoAction:(id)sender;
- (IBAction)mapAction:(id)sender;
- (IBAction)hudAction:(id)sender;
- (IBAction)menuAction:(id)sender;
- (IBAction)lemosysAction:(id)sender;


@end
