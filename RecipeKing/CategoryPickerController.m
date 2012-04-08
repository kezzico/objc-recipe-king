//
//  CategoryPickerController.m
//  RecipeKing
//
//  Created by Lee Irvine on 3/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CategoryPickerController.h"

NSString *noCategoryName = @"None";

@interface CategoryPickerController ()
- (NSInteger) getIndexOfCategory: (NSString *) name;
- (void) updateTextField: (NSInteger) selectedRow;
@end

@implementation CategoryPickerController
@synthesize categories=_categories;
@synthesize categoryPicker = _categoryPicker;

- (void) dealloc {
  [_categories release];
  [_categoryInput release];
  [_categoryPicker release];
  [super dealloc];
}

- (void) setCategoryInput: (UITextField *) input {
  [_categoryInput release];
  _categoryInput = [input retain];
  NSInteger categoryIndex = [self getIndexOfCategory: input.text];
  
  [_categoryPicker selectedRowInComponent: categoryIndex];
  _categoryInput.inputView = _categoryPicker;
}

- (NSInteger) getIndexOfCategory: (NSString *) name {
  if([name isEqualToString: noCategoryName]) return 0;
  
  NSInteger output = 0;
  if([_categories containsObject: name]) {
    output = [_categories indexOfObject: name];
  }
  return output;
}

- (void) categoriesDidChange {
  [_categoryPicker reloadAllComponents];
  [self updateTextField: [_categoryPicker selectedRowInComponent: 0]];
}

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
  return 1;
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
  return [_categories count] + 1;
}

- (NSString *) pickerView:(UIPickerView *) pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
  if(row == 0) return noCategoryName;
  return [_categories objectAtIndex: row - 1];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
  [self updateTextField: row];
}

- (void) updateTextField: (NSInteger) selectedRow {
  if(selectedRow == 0) _categoryInput.text = noCategoryName;
  else _categoryInput.text = [_categories objectAtIndex: selectedRow - 1];  
}

@end
