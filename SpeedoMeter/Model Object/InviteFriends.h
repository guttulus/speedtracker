//
//  InviteFriends.h
//
//  Created by Test on 12/06/14.
//  Copyright (c) 2014 lemosys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InviteFriends : NSObject
@property(strong,nonatomic)NSString *fb_id;
@property(strong,nonatomic)NSString *fb_name;
@property(strong,nonatomic)NSString *fb_image;
@property(strong,nonatomic)NSString *register_friendName;
@property(assign)double friendslattitude;
@property(assign)double friendslongitude;
@property(assign)int friendsspeed;
@property(strong,nonatomic)NSString *friends_image;
@property(strong,nonatomic)NSString *friendslocationName;
@property(assign)BOOL isCheckd;
@end
