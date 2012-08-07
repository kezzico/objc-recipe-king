//
//  NumberPicker.h
//  RecipeKing
//
//  Created by Lee Irvine on 8/7/12.
//  Copyright (c) 2012 leescode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NumberPicker : NSObject
- (IBAction)doneButtonTouched:(id)sender;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) UIActionSheet *actionSheet;
@property (nonatomic, retain) IBOutlet UIPickerView *picker;
@property (retain, nonatomic) IBOutlet UIButton *titleButton;
@property (retain, nonatomic) IBOutlet UIView *view;
@property (nonatomic) NSInteger number;
@property (copy, nonatomic) void(^onNumberSelected)(NSInteger number);
- (void) showInView:(UIView *) viewToPresentFrom;
- (void) setValue:(NSInteger) number;

@end
