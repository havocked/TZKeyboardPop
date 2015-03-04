//
//  ViewController.m
//  TZKeyBoardExampleApp
//
//  Created by Nataniel Martin on 19/02/15.
//  Copyright (c) 2015 Nataniel Martin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    keyboard = [[TZKeyboardPop alloc] initWithView:self.view];
    keyboard.delegate = self;
    
    
    [keyboard setTextFieldTextViewMode:UITextFieldViewModeWhileEditing];
    
    [keyboard setPlaceholderText:@"Hello word"];
    [keyboard setTextFieldText:@"Yo yo what'up ?"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)openKeyboardAction:(id)sender {
    [keyboard showKeyboard];
}

#pragma mark - TZKeyboardPopDelegates

- (void)didShowKeyboard {
    NSLog(@"Keyboard was shown !");
}

- (void) didCancelKeyboard {
    NSLog(@"Keyboard canceled !");
}

- (void) didReturnKeyPressedWithText:(NSString *)str {
    NSLog(@"Well, my guess is that you wrote: [%@]", str);
}

@end
