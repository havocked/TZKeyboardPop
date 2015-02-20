//
//  TZKeyboard.h
//  tizhr
//
//  Created by Nataniel Martin on 16/02/15.
//  Copyright (c) 2015 appstud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#ifndef kCFCoreFoundationVersionNumber_iOS_8_0
    #define kCFCoreFoundationVersionNumber_iOS_8_0 1129.15
#endif

@class TZKeyboard;
@protocol TZKeyboardDelegate <NSObject>
@optional
- (void) didShowKeyboard;
- (void) didCancelKeyboard;
- (void) didReturnKeyPressedWithText:(NSString *)str;
@end

@interface TZKeyboard : NSObject <UITextFieldDelegate> {
    UIView *currentView;
    UIView *tapToDismissView;
}

@property (nonatomic, weak) id<TZKeyboardDelegate> delegate;
@property (nonatomic, assign) NSInteger tag;

- (id)initWithView:(UIView *)view;

- (void) setPlaceholderText:(NSString *)str;
- (void) setTextFieldText:(NSString *)str;
- (void) showKeyboard;

@end
