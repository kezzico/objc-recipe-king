//
//  EditPreperationController.h
//  RecipeKing
//
//  Created by Lee Irvine on 4/7/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentViewController.h"
@interface EditPreparationController : ContentViewController <UITextViewDelegate>

@property (retain, nonatomic) NSString *preparation;
@property (retain, nonatomic) IBOutlet UIButton *doneButtonPortrait;
@property (retain, nonatomic) IBOutlet UIButton *doneButtonLandscape;
@property (retain, nonatomic) IBOutlet UITextView *textField;
@property (copy, nonatomic) void (^onDoneTouched)( NSString *value);
@end
