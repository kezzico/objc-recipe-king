//
//  ActionSheetPicker.m
//  RecipeKing
//
//  Created by Lee Irvine on 8/5/12.
//  Copyright (c) 2012 leescode. All rights reserved.
//

#import "TimePicker.h"

@implementation TimePicker
@synthesize minsLabel = _minsLabel;
@synthesize title=_title;
@synthesize picker=_picker;
@synthesize titleButton=_titleButton;
@synthesize actionSheet=_actionSheet;
@synthesize view=_view;
@synthesize hour=_hour;
@synthesize minute=_minute;
@synthesize onTimeSelected;

- (void) dealloc {
  [_picker release];
  [_title release];
  [_titleButton release];
  [_view release];
  [_actionSheet release];
  [onTimeSelected release];
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
  
  [_picker selectRow: self.hour inComponent: 0  animated: NO];
  [_picker selectRow: self.minute inComponent: 1  animated: NO];
}

- (void) showInView:(UIView *) viewToPresentFrom {
  [self.titleButton setTitle:self.title forState:UIControlStateDisabled];
  self.actionSheet = [[[UIActionSheet alloc] initWithTitle:@"\n\n\n" delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil] autorelease];
  [_actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
  [_actionSheet addSubview:self.view];
  
  [_actionSheet showInView: viewToPresentFrom];
  [self fitToScreen];
}

- (void) fitToScreen {
  BOOL isPortraitMode = UIInterfaceOrientationIsPortrait([[UIDevice currentDevice] orientation]);
  CGSize screenSize = isPortraitMode ? CGSizeMake(320, 480) : CGSizeMake(480, 320);
  CGFloat sheetHeight = (isPortraitMode ? screenSize.height : screenSize.width) - 47;
  
  _actionSheet.bounds = CGRectMake(0, 0, screenSize.width, sheetHeight);
  _view.frame = CGRectMake(0, 0, screenSize.width, 260);
  
  CGRect minsLabelFrame = _minsLabel.frame;
  minsLabelFrame.origin.x = isPortraitMode ? 200.f : 280.f;
  _minsLabel.frame = minsLabelFrame;
}

- (IBAction)doneButtonTouched:(UIBarButtonItem *)sender {
  onTimeSelected(_hour * 100 + _minute);
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
