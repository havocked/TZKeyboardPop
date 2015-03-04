//
//  TZKeyboard.m
//  tizhr
//
//  Created by Nataniel Martin on 16/02/15.
//  Copyright (c) 2015 appstud. All rights reserved.
//

#import "TZKeyboard.h"

@implementation TZKeyboard

static UITextField *_mytextField;
static UIView *_placeholderView;

- (TZKeyboard *) initWithView:(UIView *)view {
    // make sure we only add this once
    
    tapToDismissView = [[UIView alloc] initWithFrame:view.frame];
    [tapToDismissView setAlpha:0.f];
    [tapToDismissView setBackgroundColor:[UIColor colorWithWhite:0.f alpha:0.5]];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissCustomKeyboard:)];
    [tapToDismissView addGestureRecognizer:tap];
    
    currentView = view;
    
    _placeholderView = [[UIView alloc] initWithFrame:CGRectMake(0, currentView.frame.size.height - 50, currentView.frame.size.width, 50)];
    [_placeholderView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    
    _mytextField = [[UITextField alloc] init];
    _mytextField.tintColor = [UIColor blueColor];
    [_mytextField setBackgroundColor:[UIColor whiteColor]];
    [_mytextField setPlaceholder:@"Write new title here"];
    [_mytextField setBorderStyle:UITextBorderStyleRoundedRect];
    [_mytextField setReturnKeyType:UIReturnKeyDone];
    [_mytextField setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [_placeholderView addSubview:_mytextField];
    
    [_placeholderView addConstraint:[NSLayoutConstraint constraintWithItem:_mytextField
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:_placeholderView
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:0.95
                                                           constant:0]];
    
    // Height constraint, half of parent view height
    [_placeholderView addConstraint:[NSLayoutConstraint constraintWithItem:_mytextField
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:_placeholderView
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:0.8
                                                           constant:0]];
    
    // Center horizontally
    [_placeholderView addConstraint:[NSLayoutConstraint constraintWithItem:_mytextField
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:_placeholderView
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    // Center vertically
    [_placeholderView addConstraint:[NSLayoutConstraint constraintWithItem:_mytextField
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:_placeholderView
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    
    return self;
}

- (void) dismissCustomKeyboard:(id)sender {
    [_mytextField resignFirstResponder];
    
    if([_delegate respondsToSelector:@selector(didCancelKeyboard)]){
        [_delegate didCancelKeyboard];
        [_mytextField setText:@""];
    }
}

- (void) setPlaceholderText:(NSString *)str {
    [_mytextField setPlaceholder:str];
}

- (void) setTextFieldText:(NSString *)str {
    [_mytextField setText:str];
}

- (void) showKeyboard {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShowNotif:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHideNotif:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [currentView addSubview:tapToDismissView];
    _mytextField.delegate = self;
    [currentView addSubview:_placeholderView];
    [_mytextField becomeFirstResponder];
}

- (void) keyboardWillShowNotif:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    UIViewAnimationCurve curve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    BOOL isPreiOS8 = NSFoundationVersionNumber < kCFCoreFoundationVersionNumber_iOS_8_0;
    
    if (isPreiOS8) {
        [UIView animateWithDuration:[notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] delay:0 options:curve << 16 animations:^{
            [_placeholderView setCenter:CGPointMake(_placeholderView.center.x, currentView.bounds.size.height - keyboardSize.height - 25)];
            [tapToDismissView setAlpha:1.f];
        } completion:nil];
    } else {
        [_placeholderView setCenter:CGPointMake(_placeholderView.center.x, currentView.bounds.size.height - keyboardSize.height - 25)];
        [tapToDismissView setAlpha:1.f];
    }
}

- (void) keyboardWillHideNotif:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    UIViewAnimationCurve curve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    BOOL isPreiOS8 = NSFoundationVersionNumber < kCFCoreFoundationVersionNumber_iOS_8_0;
    
    if (isPreiOS8) {
        [UIView animateWithDuration:[notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] delay:0 options:curve << 16 animations:^{
            [_placeholderView setCenter:CGPointMake(_placeholderView.center.x, currentView.bounds.size.height + 25)];
            [tapToDismissView setAlpha:0.f];
        } completion:nil];
    } else {
        [_placeholderView setCenter:CGPointMake(_placeholderView.center.x, currentView.bounds.size.height + 25)];
        [tapToDismissView setAlpha:0.f];
    }

    [tapToDismissView removeFromSuperview];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    if ([textField.text length] > 0) {
        if([_delegate respondsToSelector:@selector(didReturnKeyPressedWithText:)]){
            [_delegate didReturnKeyPressedWithText:textField.text];
        }
        [_mytextField resignFirstResponder];
        [_mytextField setText:@""];
        return YES;
    }
    return NO;
}


@end
