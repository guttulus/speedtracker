//
//  AlertView.h
//  BillKiller
//
//  Created by LemosysNewMacMini on 27/11/14.
//  Copyright (c) 2014 LemosysNewMacMini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertView : UIAlertView

+ (void) showAlert:alertText withTitle:alertTitle;

+ (void) showAlert:alertText withTitle:alertTitle andTag:(int)tag;

+ (void) showAlert:alertText withTitle:alertTitle andDelegate:(id)delegate;

+ (void) showAlert:alertText withTitle:alertTitle delegate:(id)delegate andTag:(int)tag;

+ (void) showTestFieldAlert:alertText withTitle:alertTitle delegate:(id)delegate andag:(int)tag;

@end
