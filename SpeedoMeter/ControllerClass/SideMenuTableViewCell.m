//
//  SideMenuTableViewCell.m
//  speedtracker
//
//  Created by Test on 25/07/14.
//  Copyright (c) 2014 lemosys. All rights reserved.
//

#import "SideMenuTableViewCell.h"

@implementation SideMenuTableViewCell
@synthesize imageViewForCell,lblForCell;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

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
