//
//  FriendCell.h
//  SpeedTracker
//
//  Created by Test on 09/12/14.
//  Copyright (c) 2014 lemosys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
@interface FriendCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lblForName;
@property (strong, nonatomic) IBOutlet UILabel *lblForAddress;
@property (strong, nonatomic) IBOutlet UILabel *lblForSpeed;
@property (strong, nonatomic) IBOutlet AsyncImageView *profileImage;

@end
