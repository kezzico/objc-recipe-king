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

@interface EditRecipeViewController : UITableViewController <UIImagePickerControllerDelegate, UIActionSheetDelegate, UINavigationControllerDelegate>
@property (retain, nonatomic) IBOutlet UIImageView *backgroundView;
@property (retain, nonatomic) IBOutlet UIActionSheet *photoSourceOptions;
@property (retain, nonatomic) id<PCategoryRepository> categoryRepository;
@property (retain, nonatomic) id<PRecipeRepository> recipeRepository;
@property (retain, nonatomic) IBOutlet EditRecipeViewModel *viewModel;
@property (retain, nonatomic) UIBarButtonItem *doneButton;

- (IBAction)setCategoryTouched:(UIButton *) sender;
- (IBAction)recipeNameChanged: (UITextField *) field;
- (IBAction)preperationTimeChanged:(UITextField *)sender;
- (IBAction)servingsChanged:(UITextField *)sender;
- (IBAction)temperatureChanged:(UITextField *)sender;
- (IBAction)sitTimeChanged:(UITextField *)sender;
- (IBAction)cookTimeChanged:(UITextField *)sender;
- (IBAction)addButtonTouched:(UIButton *)sender;
- (IBAction)addFieldReleased:(UIButton *)sender;
- (IBAction)addIngredientReleased:(UIButton *)sender;
- (IBAction)preperationTouched;
- (IBAction)timeFieldTouched:(UITextField *)sender;
- (IBAction)photoFieldTouched:(UIButton *)sender;

@property (retain, nonatomic) IBOutlet UITextField *recipeNameField;
@property (retain, nonatomic) IBOutlet UITextField *preperationTimeField;
@property (retain, nonatomic) IBOutlet UILabel *categoryLabel;
@property (retain, nonatomic) IBOutlet UILabel *preperationLabel;
@property (retain, nonatomic) IBOutlet UITextField *temperatureField;
@property (retain, nonatomic) IBOutlet UITextField *sitTimeField;
@property (retain, nonatomic) IBOutlet UITextField *cookTimeField;
@property (retain, nonatomic) IBOutlet UITextField *servingsField;



@property (retain, nonatomic) IBOutlet EditRecipeTableController *editRecipeTable;
@end
