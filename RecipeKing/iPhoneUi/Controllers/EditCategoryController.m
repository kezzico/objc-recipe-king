//
//  EditCategoryController.m
//  RecipeKing
//
//  Created by Lee Irvine on 3/25/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import "EditCategoryController.h"
#import "UINavigationBarSkinned.h"

@interface EditCategoryController ()

@end

@implementation EditCategoryController
@synthesize categoryInput = _categoryInput;
@synthesize categoryValue = _categoryValue;
@synthesize doneButton = _doneButton;
@synthesize navigationBar = _navigationBar;
@synthesize onDoneTouched;
- (void)viewDidUnload {
  [self setCategoryInput:nil];
  [self setNavigationBar:nil];
  [super viewDidUnload];
}

- (void)dealloc {
  [_categoryInput release];
  [_categoryValue release];
  [onDoneTouched release];
  [_navigationBar release];
  [super dealloc];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  _categoryInput.text = _categoryValue;
  [_categoryInput becomeFirstResponder];  
  [self categoryChanged];
}

- (IBAction)cancelTouched {
  [self dismissModalViewControllerAnimated: YES];  
}

- (IBAction)doneTouched {
  [self dismissModalViewControllerAnimated: YES];
  if(onDoneTouched) onDoneTouched(_categoryInput.text);
}

- (IBAction)categoryChanged {
  NSString *name = _categoryInput.text;
  bool enableDoneButton = [name length] && ![name isEqualToString: _categoryValue];
  [_doneButton setEnabled: enableDoneButton];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
