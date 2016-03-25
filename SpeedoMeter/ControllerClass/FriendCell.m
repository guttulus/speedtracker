//
//  FriendCell.m
//  SpeedTracker
//
//  Created by Test on 09/12/14.
//  Copyright (c) 2014 lemosys. All rights reserved.
//

#import "FriendCell.h"

@implementation FriendCell

@synthesize lblForName;
@synthesize lblForAddress;
@synthesize lblForSpeed;
@synthesize profileImage;

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
