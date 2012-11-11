//
//  NumberPicker.m
//  RecipeKing
//
//  Created by Lee Irvine on 8/7/12.
//  Copyright (c) 2012 leescode. All rights reserved.
//

#import "NumberPicker.h"
#import "ScreenHelper.h"

@implementation NumberPicker

- (void) dealloc {
  [_picker release];
  [_title release];
  [_titleButton release];
  [_view release];
  [_actionSheet release];
  [_onNumberSelected release];
  [super dealloc];
}

- (id) init {
  if(self = [super init]) {
    [[NSBundle mainBundle] loadNibNamed: @"NumberPicker" owner: self options: nil];
  }
  return self;
}

- (void) setValue:(NSInteger) number {
  [_picker selectRow: number inComponent: 0  animated: NO];
}

- (void) showInView:(UIView *) viewToPresentFrom {
  [self.titleButton setTitle:self.title forState:UIControlStateDisabled];
  self.actionSheet = [[[UIActionSheet alloc] initWithTitle:@"" delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil] autorelease];
  [_actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
  [_actionSheet addSubview:self.view];
  
  [_actionSheet showInView: viewToPresentFrom];
  [self fitToSize:viewToPresentFrom.frame.size];
}

- (void) fitToSize:(CGSize) size {
  const CGFloat pickerHeight = 260.f;
  self.actionSheet.frame = CGRectMake(0, 0, size.width, size.height);
  self.view.frame = CGRectMake(0, size.height - pickerHeight, size.width, pickerHeight);
}

- (void) fitToScreen {
  BOOL isPortraitMode = [ScreenHelper isPortraitMode];
  CGSize screenSize = isPortraitMode ? CGSizeMake(320, 480) : CGSizeMake(480, 320);
  CGFloat sheetHeight = (isPortraitMode ? screenSize.height : screenSize.width) - 47;
 
  self.actionSheet.bounds = CGRectMake(0, 0, screenSize.width, sheetHeight);
  self.view.frame = CGRectMake(0, 0, screenSize.width, 260);
}

- (IBAction)doneButtonTouched:(UIBarButtonItem *)sender {
  _onNumberSelected(self.number);
  [self.actionSheet dismissWithClickedButtonIndex:0 animated:YES];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
  _number = [pickerView selectedRowInComponent: 0];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
  return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
  return 100;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
  return [[NSNumber numberWithInteger:row] description];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
  return 120.f;
}
@end
