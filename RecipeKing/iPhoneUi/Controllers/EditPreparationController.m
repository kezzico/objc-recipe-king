//
//  EditPreperationController.m
//  RecipeKing
//
//  Created by Lee Irvine on 4/7/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import "EditPreparationController.h"

@implementation EditPreparationController
@synthesize textField;
@synthesize onDoneTouched;
@synthesize preparation;

- (void) dealloc {
  [onDoneTouched release];
  [textField release];
  [preparation release];
  [super dealloc];
}

- (void)viewDidUnload {
  [self setTextField:nil];
  [super viewDidUnload];
}

- (void) viewDidLoad {
  [self.navigationItem setHidesBackButton:YES animated:NO];
  
  [self.textField becomeFirstResponder];
  self.textField.text = self.preparation;
  [self sizeToFit];
  
  UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneTouched)];
  self.navigationItem.rightBarButtonItem = doneButton;
}

- (void) doneTouched {
  [self.navigationController popViewControllerAnimated: YES];
  onDoneTouched(self.preparation);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation) fromInterfaceOrientation {
  [self sizeToFit];
}

- (void) sizeToFit {
  BOOL isPortraitMode = UIInterfaceOrientationIsPortrait([[UIDevice currentDevice] orientation]);
  CGRect tframe = textField.frame;
  tframe.size.height = isPortraitMode ? 200 : 104;
  textField.frame = tframe;
}

- (void) textViewDidChange:(UITextView *)textView {
  self.preparation = textView.text;
}

@end
