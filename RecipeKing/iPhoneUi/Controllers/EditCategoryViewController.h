//
//  EditCategoryController.h
//  RecipeKing
//
//  Created by Lee Irvine on 3/25/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentViewController.h"
@interface EditCategoryViewController : ContentViewController <UITextFieldDelegate>
- (IBAction)categoryChanged;
@property (retain, nonatomic) NSArray *existingCategories;
@property (retain, nonatomic) IBOutlet UITextField *categoryInput;
@property (copy, nonatomic) void (^onDoneTouched)( NSString *value);
@property (retain, nonatomic) IBOutlet UIButton *doneButtonPortrait;
@property (retain, nonatomic) IBOutlet UIButton *doneButtonLandscape;
@property (retain, nonatomic) IBOutlet UIButton *cancelButtonPortrait;
@property (retain, nonatomic) IBOutlet UIButton *cancelButtonLandscape;
@end
