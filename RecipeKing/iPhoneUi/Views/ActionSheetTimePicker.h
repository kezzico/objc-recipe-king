//
//  ActionSheetPicker.h
//  RecipeKing
//
//  Created by Lee Irvine on 8/5/12.
//  Copyright (c) 2012 leescode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActionSheetTimePicker : NSObject
@property (nonatomic) NSInteger hour;
@property (nonatomic) NSInteger minute;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) UIActionSheet *actionSheet;
@property (nonatomic, retain) IBOutlet UIPickerView *picker;
@property (retain, nonatomic) IBOutlet UIButton *titleButton;
@property (retain, nonatomic) IBOutlet UIView *view;
@property (copy, nonatomic) void(^onTimeSelected)(NSInteger time);
@property (retain, nonatomic) IBOutlet UILabel *minsLabel;
- (void) showInView:(UIView *) viewToPresentFrom;
- (void) setValue:(NSInteger) time;
@end
