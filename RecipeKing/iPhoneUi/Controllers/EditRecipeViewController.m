//
//  EditRecipeController.m
//  RecipeKing
//
//  Created by Lee Irvine on 3/17/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import "EditRecipeViewModel.h"
#import "EditRecipeViewController.h"
#import "EditRecipeTableController.h"
#import "CategoryListController.h"
#import "IngredientViewModel.h"
#import "EditPreperationController.h"
#import "UIView+Extensions.h"
#import "RecipeMapper.h"
#import "Container.h"
#import "ControllerFactory.h"
#import "NSString-Extensions.h"
#import "UIImage+Extensions.h"
#import "TimePicker.h"
#import "PhotoPicker.h"
#import "NumberPicker.h"

@implementation EditRecipeViewController
@synthesize recipeNameField = _recipeNameField;
@synthesize prepTimePlaceHolderLabel = _prepTimePlaceHolderLabel;
@synthesize prepTimeLabel = _prepTimeLabel;
@synthesize categoryLabel = _categoryLabel;
@synthesize preperationLabel = _preperationLabel;
@synthesize photoLabel = _photoLabel;
@synthesize servingsLabel = _servingsLabel;
@synthesize viewModel = _viewModel;
@synthesize doneButton = _doneButton;
@synthesize editRecipeTable = _editRecipeTable;
@synthesize backgroundView = _backgroundView;
@synthesize recipeRepository = _recipeRepository;
@synthesize timePicker=_timePicker;
@synthesize photoPicker = _photoPicker;
@synthesize numberPicker = _numberPicker;

- (void) dealloc {
  [_timePicker release];
  [_doneButton release];
  [_editRecipeTable release];
  [_viewModel release];
  [_backgroundView release];
  [_recipeRepository release];
  [_preperationLabel release];
  [_categoryLabel release];
  [_recipeNameField release];
  [_prepTimePlaceHolderLabel release];
  [_prepTimeLabel release];
  [_photoPicker release];
  [_photoLabel release];
  [_numberPicker release];
  [_servingsLabel release];
  [super dealloc];
}

- (void)viewDidUnload {
  [self.editRecipeTable unload];
  [self setEditRecipeTable:nil];
  [self setDoneButton: nil];
  [self setBackgroundView:nil];
  [self setPreperationLabel:nil];
  [self setCategoryLabel:nil];
  [self setRecipeNameField:nil];
  [self setPrepTimePlaceHolderLabel:nil];
  [self setPrepTimeLabel:nil];
  [self setPhotoPicker:nil];
  [self setPhotoLabel:nil];
  [self setNumberPicker:nil];
  [self setServingsLabel:nil];
  [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
}

- (void)viewDidLoad {
  NSLog(@"load");
  [super viewDidLoad];
  self.recipeRepository = [[Container shared] resolve:@protocol(PRecipeRepository)];
  
  [self.tableView setBackgroundView: _backgroundView];
  [self setupNavigationBar];
  [self updateFields];
  
  _editRecipeTable.viewModel = self.viewModel;
  [_editRecipeTable setupSections];
}

- (void) updateFields {
  self.recipeNameField.text = _viewModel.name;
  self.preperationLabel.text = _viewModel.preperation;
  [self updateCategoryField];
  [self updateServingsField];
  [self updatePreperationTimeLabel];
  [self updateImageField];
}

- (void) updateServingsField {
  NSInteger s = _viewModel.servings;
  self.servingsLabel.text = s > 0 ? [[NSNumber numberWithInteger:s] description] : @"";
}

- (void) updatePreperationTimeLabel {
  if(_viewModel.preperationTime == 0) {
    [self.prepTimeLabel setHidden:YES];
    [self.prepTimePlaceHolderLabel setHidden:NO];
  } else {
    [self.prepTimeLabel setHidden:NO];
    [self.prepTimePlaceHolderLabel setHidden:YES];
    self.prepTimeLabel.text = [NSString stringFromTime: _viewModel.preperationTime];
  }
}

- (void) updateCategoryField {
  self.categoryLabel.text = _viewModel.category == nil ? @"None" : _viewModel.category;
}

- (void) updateImageField {
  self.photoLabel.text = _viewModel.photo == nil ? @"No photo added" : @"Photo set";
}

- (void) saveRecipe {
  Recipe *recipe = nil;
  if(self.viewModel.recipeId != nil) {
    recipe = [self.recipeRepository recipeWithId:self.viewModel.recipeId];
  } else {
    recipe = [self.recipeRepository newRecipe];
  }
  
  RecipeMapper *mapper = [[[RecipeMapper alloc] init] autorelease];
  [mapper editViewModel:self.viewModel toRecipe:recipe];
  [self.recipeRepository save];
  [[NSNotificationCenter defaultCenter] postNotificationName:@"recipeChanged" object:self];
}

- (void) setupNavigationBar {
  UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] 
    initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelTouched)];

  _doneButton = [[UIBarButtonItem alloc] 
    initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneTouched)];
  
  self.navigationItem.leftBarButtonItem = [cancelButton autorelease];
  self.navigationItem.rightBarButtonItem = _doneButton;
  [_doneButton setEnabled: [self isRecipeNameValid]];
}

- (BOOL) isRecipeNameValid {
  return [NSString isEmpty:_viewModel.name] == NO;
}

- (void)doneTouched {
  [self saveRecipe];
  [self dismissModalViewControllerAnimated: YES];
}

- (void)cancelTouched {
  [self dismissModalViewControllerAnimated: YES];
}

- (IBAction) preperationTouched {
  [self.view endEditing:YES];
  
  EditPreperationController *vc = [[[EditPreperationController alloc] 
    initWithNibName: @"EditPreperationController" bundle: nil] autorelease];
  
  [vc setPreperationText: _viewModel.preperation];
  vc.onDoneTouched = ^(NSString *value){
    _preperationLabel.text = value;
    _viewModel.preperation = value;
  };
  
  [self.navigationController pushViewController: vc animated: YES];
}

- (IBAction)servingsTouched:(UIButton *)sender {
  [self.view endEditing:YES];
  _numberPicker.title = @"Servings";
  _numberPicker.value = _viewModel.servings;
  _numberPicker.onNumberSelected = ^(NSInteger number) {
    _viewModel.servings = number;
    [self updateServingsField];
  };
  
  [_numberPicker showInView:self.view];
}

- (IBAction) categoryTouched: (UIButton *) sender {
  [self.view endEditing:YES];
  CategoryListController *vc = [ControllerFactory buildCategoryListViewController];
  [self.navigationController pushViewController: vc animated: YES];
  vc.onCategorySelected = ^(NSString *category) {
    _viewModel.category = category;
    [self updateCategoryField];
  };
}

- (IBAction) preperationTimeTouched:(UIButton *)sender {
  [self.view endEditing:YES];
  _timePicker.title = @"Preperation Time";
  _timePicker.value = _viewModel.preperationTime;
  _timePicker.onTimeSelected = ^(NSInteger time) {
    _viewModel.preperationTime = time;
    [self updatePreperationTimeLabel];
  };
  
  [_timePicker showInView:self.view];
}

- (IBAction)recipeNameChanged: (UITextField *) field {
  self.viewModel.name = field.text;
  [_doneButton setEnabled: [self isRecipeNameValid]];
}

- (IBAction)photoTouched:(UIButton *)sender {
  [self.view endEditing:YES];
  self.photoPicker.showRemovePhotoOption = _viewModel.photo != nil;
  [self.photoPicker showPicker];
  self.photoPicker.onImageChosen = ^(UIImage *photo) {
    _viewModel.photo = [photo imageByScalingAndCroppingForSize:CGSizeMake(640, 640)];
    [self updateImageField];
  };
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [self.view endEditing:YES];
  return NO;
}

@end
