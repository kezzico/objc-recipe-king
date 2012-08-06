//
//  EditRecipeController.h
//  RecipeKing
//
//  Created by Lee Irvine on 3/17/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PRecipeRepository.h"
#import "PCategoryRepository.h"

@class EditRecipeTableController;
@class CategoryPickerController;
@class TimePickerController;
@class EditRecipeViewModel;
@class ActionSheetTimePicker;
@interface EditRecipeViewController : UITableViewController <UIImagePickerControllerDelegate, UIActionSheetDelegate, UINavigationControllerDelegate>
@property (retain, nonatomic) IBOutlet UIImageView *backgroundView;
@property (retain, nonatomic) IBOutlet UIActionSheet *photoSourceOptions;
@property (retain, nonatomic) id<PCategoryRepository> categoryRepository;
@property (retain, nonatomic) id<PRecipeRepository> recipeRepository;
@property (retain, nonatomic) IBOutlet EditRecipeViewModel *viewModel;
@property (retain, nonatomic) UIBarButtonItem *doneButton;

- (IBAction)categoryTouched:(UIButton *) sender;
- (IBAction)preperationTimeTouched:(UIButton *)sender;
- (IBAction)sitTimeTouched:(UIButton *)sender;
- (IBAction)cookTimeTouched:(UIButton *)sender;
- (IBAction)recipeNameChanged: (UITextField *) field;
- (IBAction)preperationTouched;

- (IBAction)servingsChanged:(UITextField *)sender;
- (IBAction)temperatureChanged:(UITextField *)sender;
- (IBAction)photoFieldTouched:(UIButton *)sender;

- (IBAction)addButtonTouchedDown:(UIButton *)sender;
- (IBAction)addFieldTouched:(UIButton *)sender;

@property (retain, nonatomic) IBOutlet UITextField *recipeNameField;
@property (retain, nonatomic) IBOutlet UILabel *prepTimePlaceHolderLabel;
@property (retain, nonatomic) IBOutlet UILabel *prepTimeLabel;
@property (retain, nonatomic) IBOutlet UILabel *sitTimeLabel;
@property (retain, nonatomic) IBOutlet UILabel *cookTimeLabel;

@property (retain, nonatomic) IBOutlet UILabel *categoryLabel;
@property (retain, nonatomic) IBOutlet UILabel *preperationLabel;
@property (retain, nonatomic) IBOutlet UITextField *temperatureField;
@property (retain, nonatomic) IBOutlet UITextField *servingsField;
@property (retain, nonatomic) IBOutlet ActionSheetTimePicker *timePicker;


@property (retain, nonatomic) IBOutlet EditRecipeTableController *editRecipeTable;
@end
