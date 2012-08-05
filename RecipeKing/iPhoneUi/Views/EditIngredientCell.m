//
//  IngredientCellCell.m
//  RecipeKing
//
//  Created by Lee Irvine on 3/31/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import "EditIngredientCell.h"
#import "IngredientViewModel.h"

@implementation EditIngredientCell
@synthesize quantityField=_quantityField;
@synthesize nameField=_nameField;
@synthesize view=_view;
@synthesize viewModel=_viewModel;

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier {
  if ((self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier])) {
    [[NSBundle mainBundle] loadNibNamed: @"EditIngredientCell" owner: self options: nil];
    [self.contentView addSubview: _view];
  }
  return self;
}

- (void) dealloc {
  [_viewModel release];
  [_view release];
  [_quantityField release];
  [_nameField release];
  [super dealloc];
}

- (IBAction)nameChanged {
  _viewModel.name = _nameField.text;
}

- (IBAction)quantityChanged {
  _viewModel.quantity = _quantityField.text;
}

- (void) setViewModel:(IngredientViewModel *)viewModel {
  [_viewModel release];
  _viewModel = [viewModel retain];
  
  _nameField.text = viewModel.name;
  _quantityField.text = viewModel.quantity;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];
  return NO;
}


@end
