//
//  EditCategoryController.m
//  RecipeKing
//
//  Created by Lee Irvine on 3/25/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import "EditCategoryViewController.h"
#import "NSString-Extensions.h"

@implementation EditCategoryViewController

- (void)viewDidUnload {
  [self setCategoryInput:nil];
  [self setDoneButtonPortrait:nil];
  [self setDoneButtonLandscape:nil];
  [self setCancelButtonPortrait:nil];
  [self setCancelButtonLandscape:nil];
  [super viewDidUnload];
}

- (void)dealloc {
  [_categoryInput release];
  [_existingCategories release];
  [_onDoneTouched release];
  [_doneButtonPortrait release];
  [_doneButtonLandscape release];
  [_cancelButtonPortrait release];
  [_cancelButtonLandscape release];
  [super dealloc];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.categoryInput.placeholder = _L(@"CategoryName");
  [self.doneButtonLandscape setTitle:_L(@"Done") forState:UIControlStateNormal];
  [self.doneButtonPortrait setTitle:_L(@"Done") forState:UIControlStateNormal];
  [self.cancelButtonLandscape setTitle:_L(@"Cancel") forState:UIControlStateNormal];
  [self.cancelButtonPortrait setTitle:_L(@"Cancel") forState:UIControlStateNormal];
  
  [self.categoryInput becomeFirstResponder];
  [self categoryChanged];
}

- (IBAction)cancelTouched:(id)sender {
  [self.navcontroller dismissModalViewControllerAnimated: YES];
}

- (IBAction)doneTouched:(id)sender {
  [self.navcontroller dismissModalViewControllerAnimated: YES];
  if(_onDoneTouched) _onDoneTouched(_categoryInput.text);
}

- (IBAction) categoryChanged {
  [self enableDoneButton: [self isCategoryNameValid]];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  if([self isCategoryNameValid] == NO) {
    return NO;
  }
  
  [self.navcontroller dismissModalViewControllerAnimated: YES];
  if(_onDoneTouched) _onDoneTouched(_categoryInput.text);
  return YES;
}

- (void) enableDoneButton:(BOOL) enable {
  self.doneButtonLandscape.enabled = enable;
  self.doneButtonPortrait.enabled = enable;
}

- (BOOL) isCategoryNameValid {
  NSString *category = _categoryInput.text;
  if([NSString isEmpty: category]) return NO;
  
  if([category caseInsensitiveCompare:@"None"] == NSOrderedSame) return NO;
  
  for(NSString *c in self.existingCategories) {
    if([c caseInsensitiveCompare:category] == NSOrderedSame) return NO;
  }
  
  return YES;
}

@end
