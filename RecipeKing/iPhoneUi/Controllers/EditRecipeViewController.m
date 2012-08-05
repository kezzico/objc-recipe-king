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
#import "TimePickerController.h"
#import "CategoryListController.h"
#import "IngredientViewModel.h"
#import "ExtraFieldsController.h"
#import "EditPreperationController.h"
#import "UIView+Extensions.h"
#import "RecipeMapper.h"
#import "Container.h"
#import "ControllerFactory.h"
#import "NSString-Extensions.h"

@implementation EditRecipeViewController
@synthesize recipeNameField = _recipeNameField;
@synthesize preperationTimeField = _preperationTimeField;
@synthesize categoryLabel = _categoryLabel;
@synthesize preperationLabel = _preperationLabel;
@synthesize temperatureField = _temperatureField;
@synthesize sitTimeField = _sitTimeField;
@synthesize cookTimeField = _cookTimeField;
@synthesize servingsField = _servingsField;
@synthesize viewModel = _viewModel;
@synthesize doneButton = _doneButton;
@synthesize editRecipeTable = _editRecipeTable;
@synthesize backgroundView = _backgroundView;
@synthesize photoSourceOptions = _photoSourceOptions;
@synthesize recipeRepository = _recipeRepository;

- (void) dealloc {
  [_doneButton release];
  [_editRecipeTable release];
  [_viewModel release];
  [_backgroundView release];
  [_recipeRepository release];
  [_preperationLabel release];
  [_photoSourceOptions release];
  [_categoryLabel release];
  [_recipeNameField release];
  [_preperationTimeField release];
  [_temperatureField release];
  [_sitTimeField release];
  [_cookTimeField release];
  [_servingsField release];
  [super dealloc];
}

- (void)viewDidUnload {
  [self setEditRecipeTable:nil];
  [self setDoneButton: nil];
  [self setBackgroundView:nil];
  [self setViewModel:nil];
  [self setPreperationLabel:nil];
  [self setPhotoSourceOptions:nil];
  [self setCategoryLabel:nil];
  [self setRecipeNameField:nil];
  [self setPreperationTimeField:nil];
  [self setTemperatureField:nil];
  [self setSitTimeField:nil];
  [self setCookTimeField:nil];
  [self setServingsField:nil];
  [super viewDidUnload];  
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.recipeRepository = [[Container shared] resolve:@protocol(PRecipeRepository)];
  
  [self.tableView setBackgroundView: _backgroundView];
  [self setupPhotoSourceOptions];
  [self setupNavigationBar];
  
  [self updateFields];
  [_editRecipeTable setupSections];
}

- (void) setViewModel:(EditRecipeViewModel *)viewModel {
  _viewModel = viewModel;
  self.editRecipeTable.viewModel = viewModel;
}

- (void) updateFields {
  self.recipeNameField.text = _viewModel.name;
  self.preperationTimeField.text = [NSString stringFromTime: _viewModel.preperationTime];
  self.categoryLabel.text = _viewModel.category;
  self.preperationLabel.text = _viewModel.preperation;
  self.temperatureField.text = _viewModel.cookTemperature;
  
  // TODO: add integer fields and the image here
}

- (void) setupPhotoSourceOptions {
  [_photoSourceOptions addButtonWithTitle: @"Take Photo"];
  [_photoSourceOptions addButtonWithTitle: @"Choose Photo"];
  [_photoSourceOptions addButtonWithTitle: @"Cancel"];
  _photoSourceOptions.cancelButtonIndex = 2;
  _photoSourceOptions.delegate = self;  
}

- (void) setupNavigationBar {
  UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] 
    initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelTouched)];

  _doneButton = [[UIBarButtonItem alloc] 
    initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneTouched)];
  
  self.navigationItem.leftBarButtonItem = [cancelButton autorelease];
  self.navigationItem.rightBarButtonItem = _doneButton;
  [_doneButton setEnabled: NO];
}

- (void) imagePickerController:(UIImagePickerController *) imagePicker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
//  UIImage *output = [image imageByScalingAndCroppingForSize: CGSizeMake(40, 40)];
  [self dismissModalViewControllerAnimated: YES];    
}

- (IBAction) preperationTouched {
  [self removeKeyboard];
  
  EditPreperationController *vc = [[[EditPreperationController alloc] 
    initWithNibName: @"EditPreperationController" bundle: nil] autorelease];
  
  [vc setPreperationText: _viewModel.preperation];
  vc.onDoneTouched = ^(NSString *value){
    _preperationLabel.text = value;
    _viewModel.preperation = value;
  };
  
  [self.navigationController pushViewController: vc animated: YES];
}

- (void)doneTouched {
  [self saveRecipe];
  [self dismissModalViewControllerAnimated: YES];
}

- (void)cancelTouched {
  [self dismissModalViewControllerAnimated: YES];  
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
  [[NSNotificationCenter defaultCenter] postNotificationName:@"recipeListChanged" object:self];  
}

- (IBAction) setCategoryTouched: (UIButton *) sender {
  CategoryListController *vc = [ControllerFactory buildCategoryListViewController];
  [self.navigationController pushViewController: vc animated: YES];
  vc.onCategorySelected = ^(NSString *category) {
    _viewModel.category = category;
    self.categoryLabel.text = category;
  };
}

- (IBAction)recipeNameChanged: (UITextField *) field {
  self.viewModel.name = field.text;
  [_doneButton setEnabled: [field.text length] > 0];
}

- (UITableViewCell *) findParentCell: (UIView *) view {
  while(view.superview != nil) {
    if(view.superview.class == UITableViewCell.class) {
      return (UITableViewCell *)view.superview;
    }
    view = view.superview;
  }
  return nil;
}

- (IBAction)preperationTimeChanged:(UITextField *)sender {
  _viewModel.preperationTime = sender.text;
}
- (IBAction)categoryChanged:(UITextField *)sender {
  _viewModel.category = sender.text;
  [sender resignFirstResponder];
}
- (IBAction)servingsChanged:(UITextField *)sender {
  _viewModel.servings = [sender.text intValue];
}
- (IBAction)temperatureChanged:(UITextField *)sender {
  _viewModel.cookTemperature = sender.text;
}
- (IBAction)sitTimeChanged:(UITextField *)sender {
  _viewModel.sitTime = sender.text;
}
- (IBAction)cookTimeChanged:(UITextField *)sender {
  _viewModel.cookTime = sender.text;
}

- (IBAction)addButtonTouchedDown:(UIButton *)sender {
  UITableViewCell *cell = [self findParentCell: sender];
  [cell setSelected:YES animated:NO];
  [cell setSelected:NO animated:YES];
}

- (IBAction)addFieldTouched:(UIButton *)sender {
  ExtraFieldsController *vc = [[ExtraFieldsController alloc] init];
  vc.fields = [_editRecipeTable.extraFields allKeys];
  vc.onFieldChosen = ^(NSString *field) {
    [_editRecipeTable addExtraField: field];
  };
  [self.navigationController pushViewController: vc animated: YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];
  return NO;
}

- (void) removeKeyboard {
  UIView *firstResponder = [self.view findFirstResponder];
  [firstResponder resignFirstResponder];  
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  [self removeKeyboard];
}

#pragma mark image picker

- (IBAction)photoFieldTouched:(UIButton *)sender {
  if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
    [_photoSourceOptions showInView: self.view];
  } else {
    UIImagePickerController *imagePicker = [[[UIImagePickerController alloc] init] autorelease];
    imagePicker.delegate = self;
    [self presentModalViewController: imagePicker animated:YES];
  }
}

- (void) actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger) buttonIndex {
  if(buttonIndex > 1) return;
  UIImagePickerController *imagePicker = [[[UIImagePickerController alloc] init] autorelease];
  imagePicker.delegate = self;
  imagePicker.sourceType = buttonIndex == 0 ?
  UIImagePickerControllerSourceTypeCamera :
  UIImagePickerControllerSourceTypePhotoLibrary;
  
  [self presentModalViewController: imagePicker animated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *) imagePicker {
  [self dismissModalViewControllerAnimated:YES];
}

@end
