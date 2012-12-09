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
#import "ContentViewController.h"
@class EditRecipeTableController;
@class CategoryPickerController;
@class TimePickerController;
@class EditRecipeViewModel;
@class TimePicker;
@class PhotoPicker;
@class NumberPicker;
@class EditRecipeLocalizationController;
@interface EditRecipeViewController : ContentViewController <UITableViewDataSource, UITableViewDelegate>
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) id<PCategoryRepository> categoryRepository;
@property (retain, nonatomic) id<PRecipeRepository> recipeRepository;
@property (retain, nonatomic) EditRecipeViewModel *viewModel;

- (IBAction)categoryTouched:(UIButton *) sender;
- (IBAction)preparationTimeTouched:(UIButton *)sender;
- (IBAction)photoTouched:(UIButton *)sender;
- (IBAction)preparationTouched;
- (IBAction)servingsTouched:(UIButton *)sender;
- (IBAction)recipeNameChanged: (UITextField *) field;

@property (retain, nonatomic) IBOutlet EditRecipeLocalizationController *localizer;
@property (retain, nonatomic) IBOutlet UITextField *recipeNameField;
@property (retain, nonatomic) IBOutlet UILabel *prepTimePlaceHolderLabel;
@property (retain, nonatomic) IBOutlet UILabel *prepTimeLabel;
@property (retain, nonatomic) IBOutlet UILabel *categoryLabel;
@property (retain, nonatomic) IBOutlet UILabel *preparationLabel;
@property (retain, nonatomic) IBOutlet UILabel *photoLabel;
@property (retain, nonatomic) IBOutlet UILabel *servingsLabel;
@property (retain, nonatomic) IBOutlet TimePicker *timePicker;
@property (retain, nonatomic) IBOutlet PhotoPicker *photoPicker;
@property (retain, nonatomic) IBOutlet NumberPicker *numberPicker;
@property (retain, nonatomic) IBOutlet EditRecipeTableController *editRecipeTable;
@property (retain, nonatomic) IBOutlet UIButton *doneButtonPortrait;
@property (retain, nonatomic) IBOutlet UIButton *doneButtonLandscape;
@end
