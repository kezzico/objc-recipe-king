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
#import "EditPreparationController.h"
#import "UIView+Extensions.h"
#import "RecipeMapper.h"
#import "Container.h"
#import "ControllerFactory.h"
#import "NSString-Extensions.h"
#import "UIImage+Extensions.h"
#import "TimePicker.h"
#import "PhotoPicker.h"
#import "NumberPicker.h"
#import "Recipe.h"
#import "jsonHelper.h"
#import "NavigationController.h"
#import "EditRecipeLocalizationController.h"

@implementation EditRecipeViewController

- (void) dealloc {
  [_timePicker release];
  [_editRecipeTable release];
  [_viewModel release];
  [_recipeRepository release];
  [_preparationLabel release];
  [_categoryLabel release];
  [_recipeNameField release];
  [_prepTimePlaceHolderLabel release];
  [_prepTimeLabel release];
  [_photoPicker release];
  [_photoLabel release];
  [_numberPicker release];
  [_servingsLabel release];
  [_photoLabel release];
  [_tableView release];
  [_localizer release];
  [_doneButtonPortrait release];
  [_doneButtonLandscape release];
  [super dealloc];
}

- (void) viewDidUnload {
  [self.localizer didUnload];
  [self.editRecipeTable unload];
  [self setEditRecipeTable:nil];
  [self setPreparationLabel:nil];
  [self setCategoryLabel:nil];
  [self setRecipeNameField:nil];
  [self setPrepTimePlaceHolderLabel:nil];
  [self setPrepTimeLabel:nil];
  [self setPhotoLabel:nil];
  [self setNumberPicker:nil];
  [self setServingsLabel:nil];
  [self setPhotoLabel:nil];
  [self setTableView:nil];
  [self setLocalizer:nil];
  [self setDoneButtonPortrait:nil];
  [self setDoneButtonLandscape:nil];
  [super viewDidUnload];
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
}

- (void) viewDidLoad {
  [super viewDidLoad];
  [self.localizer didLoad];
  self.recipeRepository = [[Container shared] resolve:@protocol(PRecipeRepository)];
  
  [self updateFields];
  
  _editRecipeTable.viewModel = self.viewModel;
  [_editRecipeTable setupSections];
  [self enableDoneButton:[self isRecipeNameValid]];
}

- (void) updateFields {
  self.recipeNameField.text = _viewModel.name;
  self.preparationLabel.text = _viewModel.preparation;
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
  if(_viewModel.preparationTime == 0) {
    [self.prepTimeLabel setHidden:YES];
    [self.prepTimePlaceHolderLabel setHidden:NO];
  } else {
    [self.prepTimeLabel setHidden:NO];
    [self.prepTimePlaceHolderLabel setHidden:YES];
    self.prepTimeLabel.text = [NSString stringFromTime: _viewModel.preparationTime];
  }
}

- (void) updateCategoryField {
  self.categoryLabel.text = _viewModel.category == nil ? _L(@"EmptyCategory") : _viewModel.category;
}

- (void) updateImageField {
  self.photoLabel.text = _viewModel.photo == nil ? _L(@"NoPhotoSet") : _L(@"PhotoSet");
}

- (void) saveRecipe {
  if([_viewModel.oldName isEqual:_viewModel.name] == NO && _viewModel.oldName) {
    Recipe *recipe = [self.recipeRepository recipeWithName:_viewModel.oldName];
    [self.recipeRepository remove:recipe];
  }

  RecipeMapper *mapper = [RecipeMapper mapper];
  [mapper recipeFromEditViewModel:self.viewModel];
  [self.recipeRepository sync];
  
  
  NSDictionary *postInfo = @{
    @"oldname" : valueOrNull(_viewModel.oldName),
    @"newname" : _viewModel.name
  };
  
  [[NSNotificationCenter defaultCenter] postNotificationName:@"recipeChanged" object:nil userInfo: postInfo];
}

- (BOOL) isRecipeNameValid {
  NSString *name = [_viewModel.name lowercaseString];
  if([NSString isEmpty: name]) return NO;
  if([self isRecipeNameAvailable: name] == NO) return NO;
  return YES;
}

- (BOOL) isRecipeNameAvailable: (NSString *) recipeName {
  recipeName = [recipeName lowercaseString];
  for(NSString *unavailableName in _viewModel.unavailableRecipeNames) {
    if([recipeName isEqual: [unavailableName lowercaseString]]) return NO;
  }
  
  return YES;
}

- (IBAction) doneTouched:(id) sender {
  [self saveRecipe];
  [self.navcontroller dismissModalViewControllerAnimated: YES];
}

- (IBAction)cancelTouched:(id)sender {
  [self.navcontroller dismissModalViewControllerAnimated: YES];
}

- (IBAction) preparationTouched {
  [self.view endEditing:YES];
  
  EditPreparationController *vc = [ControllerFactory buildPreparationController];
  vc.preparation = _viewModel.preparation;
  vc.onDoneTouched = ^(NSString *value){
    _preparationLabel.text = value;
    _viewModel.preparation = value;
  };
  
  [self.navcontroller pushViewController:vc];
}

- (IBAction)servingsTouched:(UIButton *)sender {
  [self.view endEditing:YES];
  _numberPicker.title = _L(@"Servings");
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
  vc.selectedCategory = _viewModel.category;
  [self.navcontroller pushViewController: vc];
  vc.onCategorySelected = ^(NSString *category) {
    _viewModel.category = category;
    [self updateCategoryField];
  };
}

- (IBAction) preparationTimeTouched:(UIButton *)sender {
  [self.view endEditing:YES];
  _timePicker.title = _L(@"PreparationTime");
  _timePicker.value = _viewModel.preparationTime;
  _timePicker.onTimeSelected = ^(NSInteger time) {
    _viewModel.preparationTime = time;
    [self updatePreperationTimeLabel];
  };
  
  [_timePicker showInView:self.view];
}

- (IBAction) recipeNameChanged: (UITextField *) field {
  self.viewModel.name = field.text;
  [self enableDoneButton:[self isRecipeNameValid]];
}

- (void) enableDoneButton:(BOOL) enable {
  self.doneButtonLandscape.enabled = enable;
  self.doneButtonPortrait.enabled = enable;
}

- (IBAction)photoTouched:(UIButton *)sender {
  [self.view endEditing:YES];
  self.photoPicker.controller = self.navcontroller;
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
