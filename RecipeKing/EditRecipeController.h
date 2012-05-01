//
//  EditRecipeController.h
//  RecipeKing
//
//  Created by Lee Irvine on 3/17/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EditRecipeTableController;
@class CategoryPickerController;
@class TimePickerController;
@class RecipeViewModel;

@protocol PCategoryRepository;
@protocol PRecipeRepository;

@interface EditRecipeController : UITableViewController <UIImagePickerControllerDelegate, UIActionSheetDelegate, UINavigationControllerDelegate>
- (IBAction)listCategoriesTouched;
- (IBAction)recipeNameChanging: (UITextField *)field;
- (IBAction)recipeNameChanged:(UITextField *)sender;
- (IBAction)preperationTimeChanged:(UITextField *)sender;
- (IBAction)categoryChanged:(UITextField *)sender;
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
@property (retain, nonatomic) IBOutlet UILabel *preperationLabel;
@property (retain, nonatomic) IBOutlet RecipeViewModel *viewModel;
@property (retain, nonatomic) UIBarButtonItem *doneButton;
@property (retain, nonatomic) IBOutlet UITextField *totalPrepTimeInput;
@property (retain, nonatomic) IBOutlet UITextField *categoryInput;
@property (retain, nonatomic) IBOutlet UITextField *cookTimeInput;
@property (retain, nonatomic) IBOutlet UITextField *sitTimeInput;
@property (retain, nonatomic) IBOutlet CategoryPickerController *categoryPickerController;
@property (retain, nonatomic) IBOutlet TimePickerController *timePickerController;
@property (retain, nonatomic) IBOutlet NSObject<PCategoryRepository> *categoryRepository;
@property (retain, nonatomic) IBOutlet NSObject<PRecipeRepository> *recipeRepository;
@property (retain, nonatomic) IBOutlet EditRecipeTableController *editRecipeTable;
@property (retain, nonatomic) IBOutlet UIImageView *backgroundView;
@property (retain, nonatomic) IBOutlet UIActionSheet *photoSourceOptions;
@end
