//
//  TimePickerController.m
//  RecipeKing
//
//  Created by Lee Irvine on 3/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TimePickerController.h"
#import "TimeStringConverter.h"

const NSInteger kMaxHours = 48;
const NSInteger kMaxMinutes = 60;

@implementation TimePickerController
@synthesize timePicker = _timePicker;

- (id) init {
  if((self = [super init])) {
    _converter = [[TimeStringConverter alloc] init];
  }
  return self;
}

- (void)dealloc {
  [_timePicker release];
  [_timeInput release];
  [_converter release];
  [super dealloc];
}

- (void) setTimeInput:(UITextField *)input {
  [_timeInput autorelease];
  _timeInput = [input retain];
  _timeInput.inputView = _timePicker;
  
  NSInteger hours = [_converter getHoursFromTimeString: input.text] % kMaxHours;
  NSInteger minutes = [_converter getMinutesFromTimeString: input.text] % kMaxMinutes;
  [_timePicker selectRow: hours inComponent: 0  animated: YES];
  [_timePicker selectRow: minutes inComponent: 1  animated: YES];
}

- (CGFloat) pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
  if(component == 0) return 80.0f;
  else return 120.0f;
}

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
  return 2;
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
  if(component == 0) return kMaxHours;
  else return kMaxMinutes;
}

- (NSString *) pickerView:(UIPickerView *) pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
  if(component == 0) return [NSString stringWithFormat: @"%d hrs", row];
  else return [NSString stringWithFormat: @"%d mins", row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
  NSInteger hours = [pickerView selectedRowInComponent: 0];
  NSInteger minutes = [pickerView selectedRowInComponent: 1];
  _timeInput.text = [_converter stringWithHours: hours minutes: minutes];
}

@end
