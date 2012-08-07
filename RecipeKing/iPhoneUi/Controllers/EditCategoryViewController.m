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
@synthesize categoryInput = _categoryInput;
@synthesize doneButton = _doneButton;
@synthesize navigationBar = _navigationBar;
@synthesize existingCategories=_existingCategories;
@synthesize onDoneTouched;

- (void)viewDidUnload {
  [self setCategoryInput:nil];
  [self setNavigationBar:nil];
  [super viewDidUnload];
}

- (void)dealloc {
  [_categoryInput release];
  [_navigationBar release];
  [_existingCategories release];
  [onDoneTouched release];
  [super dealloc];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [_categoryInput becomeFirstResponder];
  [self categoryChanged];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction) cancelTouched {
  [self dismissModalViewControllerAnimated: YES];  
}

- (IBAction) doneTouched {
  [self dismissModalViewControllerAnimated: YES];
  if(onDoneTouched) onDoneTouched(_categoryInput.text);
}

- (IBAction) categoryChanged {
  [_doneButton setEnabled: [self isCategoryNameValid]];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  if([self isCategoryNameValid] == NO) {
    return NO;
  }
  
  [self dismissModalViewControllerAnimated: YES];
  if(onDoneTouched) onDoneTouched(_categoryInput.text);  
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
