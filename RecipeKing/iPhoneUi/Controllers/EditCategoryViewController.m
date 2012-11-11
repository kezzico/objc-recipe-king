//
//  EditCategoryController.m
//  RecipeKing
//
//  Created by Lee Irvine on 3/25/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import "EditCategoryViewController.h"
#import "UINavigationBarSkinned.h"
#import "NSString-Extensions.h"

@implementation EditCategoryViewController

- (void)viewDidUnload {
  [self setCategoryInput:nil];
  [super viewDidUnload];
}

- (void)dealloc {
  [_categoryInput release];
  [_existingCategories release];
  [_onDoneTouched release];
  [super dealloc];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self setupMenuButtons];
  [self.categoryInput becomeFirstResponder];
  [self categoryChanged];
}

- (void) setupMenuButtons {
  UIBarButtonItem *cancelButton = [[[UIBarButtonItem alloc]
                      initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self
                      action:@selector(cancelTouched)] autorelease];
  
  self.doneButton = [[[UIBarButtonItem alloc]
                      initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self
                      action:@selector(doneTouched)] autorelease];
  
  self.navigationItem.rightBarButtonItem = self.doneButton;
  self.navigationItem.leftBarButtonItem = cancelButton;
}


- (void) cancelTouched {
  [self dismissModalViewControllerAnimated: YES];  
}

- (void) doneTouched {
  [self dismissModalViewControllerAnimated: YES];
  if(_onDoneTouched) _onDoneTouched(_categoryInput.text);
}

- (IBAction) categoryChanged {
  [_doneButton setEnabled: [self isCategoryNameValid]];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  if([self isCategoryNameValid] == NO) {
    return NO;
  }
  
  [self dismissModalViewControllerAnimated: YES];
  if(_onDoneTouched) _onDoneTouched(_categoryInput.text);
  return YES;
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
