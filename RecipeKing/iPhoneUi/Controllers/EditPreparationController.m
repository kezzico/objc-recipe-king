//
//  EditPreperationController.m
//  RecipeKing
//
//  Created by Lee Irvine on 4/7/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import "EditPreparationController.h"
#import "NavigationController.h"
#import "ScreenHelper.h"

@implementation EditPreparationController

- (void) dealloc {
  [_onDoneTouched release];
  [_textField release];
  [_preparation release];
  [_doneButtonPortrait release];
  [_doneButtonLandscape release];
  [super dealloc];
}

- (void)viewDidUnload {
  [self setTextField:nil];
  [self setDoneButtonPortrait:nil];
  [self setDoneButtonLandscape:nil];
  [super viewDidUnload];
}

- (void) viewDidLoad {
  [super viewDidLoad];
  [self.navcontroller hideBackButton: YES];
  self.textField.text = self.preparation;
  [self.textField becomeFirstResponder];
  [self sizeToFit];
  
  [self.doneButtonLandscape setTitle:_L(@"Done") forState:UIControlStateNormal];
  [self.doneButtonPortrait setTitle:_L(@"Done") forState:UIControlStateNormal];
}

- (IBAction) doneTouched:(id)sender {
  [self.navcontroller popViewController];
  _onDoneTouched(self.preparation);
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
