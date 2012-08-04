//
//  TimePickerController.h
//  RecipeKing
//
//  Created by Lee Irvine on 3/25/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TimeStringConverter;
@interface TimePickerController : NSObject <UIPickerViewDataSource, UIPickerViewDelegate> {
  UITextField *_timeInput;
  TimeStringConverter *_converter;
}

@property (retain, nonatomic) IBOutlet UIPickerView *timePicker;
- (void) setTimeInput: (UITextField *) input;

@end
