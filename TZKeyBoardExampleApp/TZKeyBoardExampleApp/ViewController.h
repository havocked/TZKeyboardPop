//
//  ViewController.h
//  TZKeyBoardExampleApp
//
//  Created by Nataniel Martin on 19/02/15.
//  Copyright (c) 2015 Nataniel Martin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TZKeyboardPop.h>

@interface ViewController : UIViewController <TZKeyboardPopDelegate> {
    TZKeyboardPop *keyboard;
}

- (IBAction)openKeyboardAction:(id)sender;

@end

