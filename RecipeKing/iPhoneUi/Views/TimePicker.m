//
//  ActionSheetPicker.m
//  RecipeKing
//
//  Created by Lee Irvine on 8/5/12.
//  Copyright (c) 2012 leescode. All rights reserved.
//

#import "TimePicker.h"
#import "ScreenHelper.h"

@implementation TimePicker

- (void) dealloc {
  [_picker release];
  [_title release];
  [_titleButton release];
  [_view release];
  [_actionSheet release];
  [_onTimeSelected release];
  [_minsLabel release];
  [super dealloc];
}

- (id) init {
  if(self = [super init]) {
    [[NSBundle mainBundle] loadNibNamed: @"TimePicker" owner: self options: nil];
  }
  return self;
}

- (void) setValue:(NSInteger) time {
  self.hour = time / 100;
  self.minute = time % 100;
  
  [self.picker selectRow: self.hour inComponent:0 animated: NO];
  [self.picker selectRow: self.minute inComponent:1 animated: NO];
}

- (void) showInView:(UIView *) viewToPresentFrom {
  [self.titleButton setTitle:self.title forState:UIControlStateDisabled];
  self.actionSheet = [[[UIActionSheet alloc] initWithTitle:@"" delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil] autorelease];
  [self.actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
  [self.actionSheet addSubview:self.view];
  
  [self.actionSheet showInView: viewToPresentFrom];
  [self fitToSize: viewToPresentFrom.frame.size];
}

- (void) fitToSize:(CGSize) size {
  const CGFloat pickerHeight = 260.f;
  self.actionSheet.frame = CGRectMake(0, 0, size.width, size.height);
  self.view.frame = CGRectMake(0, size.height - pickerHeight, size.width, pickerHeight);
  
  CGRect minsLabelFrame = self.minsLabel.frame;
  minsLabelFrame.origin.x = [ScreenHelper widthForPortrait:200.f landscape:280.f wideLandscape:324.f];
  self.minsLabel.frame = minsLabelFrame;
}

- (IBAction)doneButtonTouched:(UIBarButtonItem *)sender {
  _onTimeSelected(_hour * 100 + _minute);
  [self.actionSheet dismissWithClickedButtonIndex:0 animated:YES];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
  _hour = [pickerView selectedRowInComponent: 0];
  _minute = [pickerView selectedRowInComponent: 1];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
  return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
  return component == 0 ? 48 : 60;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
  if(component == 0) return [[NSNumber numberWithInteger:row] description];
  else return [[NSNumber numberWithInteger:row] description];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
  return pickerView.frame.size.width / 2.f - 30;
}

@end
