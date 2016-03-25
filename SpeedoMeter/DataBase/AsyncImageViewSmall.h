//
//  AsyncImageViewSmall.h
//  Beautifo!
//
//  Created by techvalens on 22/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"

@interface AsyncImageViewSmall : UIButton{

@private
    
	NSURLConnection *connection;
	NSMutableData   *imageData;
	NSData *returnImage;
	//UIImage *returnImageNew;
    AppDelegate *delegate;
    NSMutableArray *arrayForURL;
}

-(void)loadImage:(NSString *)url;
-(void)abort;
-(NSData*)findImage:(id)sender;

@end

