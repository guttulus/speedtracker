//
//  AlertView.m
//  BillKiller
//
//  Created by LemosysNewMacMini on 27/11/14.
//  Copyright (c) 2014 LemosysNewMacMini. All rights reserved.
//

#import "AlertView.h"

@implementation AlertView

#pragma mark UIAlertViewdeleaget

+ (void) showAlert:alertText withTitle:alertTitle
{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:alertTitle message:alertText delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes",nil];
    [alert show];
}

+ (void) showAlert:alertText withTitle:alertTitle andTag:(int)tag
{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:alertTitle message:alertText delegate:nil cancelButtonTitle:@"No" otherButtonTitles:@"Yes",nil];
    alert.tag = tag;
    [alert show];
}

+ (void) showAlert:alertText withTitle:alertTitle andDelegate:(id)delegate
{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:alertTitle message:alertText delegate:delegate cancelButtonTitle:@"No" otherButtonTitles:@"Yes",nil];
    [alert show];
}

+ (void) showAlert:alertText withTitle:alertTitle delegate:(id)delegate andTag:(int)tag
{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:alertTitle message:alertText delegate:delegate cancelButtonTitle:@"No" otherButtonTitles:@"Yes",nil];
    alert.tag = tag;
    [alert show];
}

+ (void) showTestFieldAlert:alertText withTitle:alertTitle delegate:(id)delegate andag:(int)tag
{
    if ([[UIDevice currentDevice].systemVersion floatValue]< 7.0)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alertTitle message:alertText delegate:delegate cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil] ;
        alertView.tag = tag;
        
        CGRect rect = {30, 35, 220, 20};
        UITextField *textField = [[UITextField alloc] initWithFrame:rect];
        textField.tag = 10;
        textField.backgroundColor = [UIColor whiteColor];
        textField.font = [UIFont  fontWithName:@"Nexa Light" size:15.0f];
        textField.keyboardType = UIKeyboardTypeNumberPad;
        textField.borderStyle = UITextBorderStyleLine;
        textField.placeholder = @"Amount";
        [textField becomeFirstResponder];
        [alertView addSubview:textField];
        [alertView show];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alertTitle message:alertText delegate:delegate cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil] ;
        alertView.tag = tag;
        
        alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
        UITextField *textField  = [alertView textFieldAtIndex:0];
        textField.placeholder = @"Amount";
        textField.keyboardType = UIKeyboardTypeNumberPad;
        [textField becomeFirstResponder];
        [alertView show];
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
