//
//  EditPreperationController.m
//  RecipeKing
//
//  Created by Lee Irvine on 4/7/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import "EditPreparationController.h"
#import "ScreenHelper.h"

@implementation EditPreparationController

- (void) dealloc {
  [_onDoneTouched release];
  [_textField release];
  [_preparation release];
  [super dealloc];
}

- (void)viewDidUnload {
  [self setTextField:nil];
  [super viewDidUnload];
}

- (void) viewDidLoad {
  [super viewDidLoad];
  [self.navigationItem setHidesBackButton:YES animated:NO];
  
  self.textField.text = self.preparation;
  UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneTouched)];
  self.navigationItem.rightBarButtonItem = doneButton;
  
  [self.textField becomeFirstResponder];
  [self sizeToFit];
}

- (void) doneTouched {
  [self.navigationController popViewControllerAnimated: YES];
  _onDoneTouched(self.preparation);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation) fromInterfaceOrientation {
  [self sizeToFit];
}

- (void) sizeToFit {
  CGRect tframe = self.textField.frame;
  tframe.size.height = [ScreenHelper heightForPortrait:200 landscape:104 tallPortrait:288];
  self.textField.frame = tframe;
}

- (void) textViewDidChange:(UITextView *)textView {
  self.preparation = textView.text;
}

@end
