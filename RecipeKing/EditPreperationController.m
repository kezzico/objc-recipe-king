//
//  EditPreperationController.m
//  RecipeKing
//
//  Created by Lee Irvine on 4/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EditPreperationController.h"

@interface EditPreperationController ()

@end

@implementation EditPreperationController
@synthesize onDoneTouched;

- (void) dealloc {
  [onDoneTouched release];
  [super dealloc];
}

- (void) viewDidLoad {
  [self.view becomeFirstResponder];
  [self.navigationItem setHidesBackButton:YES animated:NO];
  UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] 
    initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneTouched)];
  
  self.navigationItem.rightBarButtonItem = doneButton;
}

- (void) doneTouched {
  [self.navigationController popViewControllerAnimated: YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void) setPreperationText: (NSString *) value {
  UITextView *view = (UITextView *)self.view;
  view.text = value;
}

- (void) viewWillDisappear:(BOOL)animated {
  UITextView *view = (UITextView *)self.view;
  onDoneTouched(view.text);
  [super viewWillDisappear:animated];
}

@end
