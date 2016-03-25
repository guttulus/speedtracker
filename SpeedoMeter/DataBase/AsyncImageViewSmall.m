//
//  AsyncImageViewSmall.m
//  Beautifo!
//
//  Created by techvalens on 22/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "AsyncImageViewSmall.h"
//#import "CustomUSerCell.h"
@implementation AsyncImageViewSmall

-(void)loadImage:(NSString *)url {
   // [self setBackgroundImage:[UIImage imageNamed:@"1.jpeg"] forState:UIControlStateNormal];
   
        //[self.layer setBorderWidth:1];
       // [self.layer setBorderColor:[UIColor blackColor].CGColor];
      
//    if ([self.superview isKindOfClass:[CustomUSerCell class]]) {
//      
//        [self.layer setCornerRadius:4];
//        self.layer.masksToBounds = YES;
//    }
  [self.layer setBackgroundColor:[UIColor blackColor].CGColor];
    if(nil==arrayForURL){
		arrayForURL =[[NSMutableArray alloc] initWithObjects:nil];
	}
    delegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    if (url!=nil){
		if([delegate.dictionaryForImageCacheing objectForKey:url])
		{
			[self setBackgroundImage:[UIImage imageWithData:[delegate.dictionaryForImageCacheing valueForKey:url]] forState:UIControlStateNormal];
            [self setBackgroundImage:[UIImage imageWithData:[delegate.dictionaryForImageCacheing valueForKey:url]] forState:UIControlStateHighlighted];
		}else{
            [arrayForURL addObject:url];
            imageData = [[NSMutableData alloc] initWithCapacity:0];
//            NSURLRequest *request = [NSURLRequest 
//                                     requestWithURL:[NSURL URLWithString:url] 
//                                     cachePolicy:NSURLRequestReloadIgnoringCacheData
//                                     timeoutInterval:30.0];
           // NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
           // connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
            
//            NSData *tempImageData=[NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
//            [self setBackgroundImage:[UIImage imageWithData:tempImageData] forState:UIControlStateNormal];
//            [delegate.dictionaryForImageCacheing setObject:tempImageData forKey:url] ;
            
            [NSThread detachNewThreadSelector:@selector(loadimagedata:) toTarget:self withObject:url];
        }
    }
    
}

-(void) loadimagedata:(NSString *)sender{
    UIActivityIndicatorView *indicator=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    indicator.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    [self addSubview:indicator];
    [indicator startAnimating];
    
    NSData *tempImageData=[NSData dataWithContentsOfURL:[NSURL URLWithString:sender]];
   
    if (tempImageData!=nil) {
        [self setBackgroundImage:[UIImage imageWithData:tempImageData] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageWithData:tempImageData] forState:UIControlStateHighlighted];
         [delegate.dictionaryForImageCacheing setObject:tempImageData forKey:sender] ;
    }
   // [delegate.dictionaryForImageCacheing setObject:tempImageData forKey:sender] ;
    [indicator stopAnimating];
    [indicator removeFromSuperview];
    
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [imageData setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)nsdata {
    [imageData appendData:nsdata];	
    
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [self abort];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    self.contentMode = UIViewContentModeScaleAspectFit;
//    if(imageData==nil){
//        [self setBackgroundImage:[UIImage imageNamed:@"DeafaultUser.png"] forState:UIControlStateNormal];
//        [arrayForURL removeObjectAtIndex:0];
//    }else
//    {
//		[self setBackgroundImage:[UIImage imageWithData:imageData] forState:UIControlStateNormal];
//        [delegate.dictionaryForImageCacheing setObject:imageData forKey:[arrayForURL objectAtIndex:0]] ;
//        [arrayForURL removeObjectAtIndex:0];
//    }
    [self abort];
}


-(void)abort{
    if(connection != nil){
        [connection cancel];
        connection = nil;
    }
    
    
    if(imageData != nil){
        imageData = nil;
    }
}




-(NSData*)findImage:(id)sender{
    //NSData *imageData = UIImagePNGRepresentation([UIImage imageNamed:@"JustAnnounced.png"]);
    return returnImage;
}

@end
