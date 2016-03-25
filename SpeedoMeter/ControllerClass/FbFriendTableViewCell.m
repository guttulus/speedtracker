//
//  FbFriendTableViewCell.m
//
//  Created by Test on 12/06/14.
//  Copyright (c) 2014 lemosys. All rights reserved.
//

#import "FbFriendTableViewCell.h"
@implementation FbFriendTableViewCell

@synthesize btnForImage,btnFor_checkBox,lblForName;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier detail:(InviteFriends *)invitefriends withIndex:(int)index
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        // Initialization code
        
        btnForImage  = [[AsyncImageView alloc] initWithFrame:CGRectMake(10,5,50,50)];
        btnForImage.backgroundColor = [UIColor clearColor];
        [btnForImage loadImage:[invitefriends fb_image]];
        [self addSubview:btnForImage];

        lblForName=[[UILabel alloc] initWithFrame:CGRectMake(74,10,200,40)];
        lblForName.backgroundColor = [UIColor clearColor];
        lblForName.text = [invitefriends fb_name];
        lblForName.font = [UIFont fontWithName:@"Arial" size: 14];
        lblForName.numberOfLines = 0;
        lblForName.textColor = [UIColor whiteColor];
        [self addSubview:lblForName];

        btnFor_checkBox = [UIButton buttonWithType:UIButtonTypeCustom];
        btnFor_checkBox.frame = CGRectMake(284,20,30,30);
        btnFor_checkBox.backgroundColor = [UIColor clearColor];
        btnFor_checkBox.tag = index;
        
        [btnFor_checkBox setBackgroundImage:[UIImage imageNamed:@"Checkbox1.png"] forState:UIControlStateNormal];
        [btnFor_checkBox setBackgroundImage:[UIImage imageNamed:@"Checkbox2.png"] forState:UIControlStateSelected];
        [btnFor_checkBox setBackgroundImage:[UIImage imageNamed:@"Checkbox2.png"] forState:UIControlStateHighlighted];
        [btnFor_checkBox addTarget:self.delegate action:@selector(checkBoxPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnFor_checkBox];
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
