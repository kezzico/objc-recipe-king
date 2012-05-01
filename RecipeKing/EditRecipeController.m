//
//  EditRecipeController.m
//  RecipeKing
//
//  Created by Lee Irvine on 3/17/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import "RecipeViewModel.h"
#import "EditRecipeController.h"
#import "EditRecipeTableController.h"
#import "TimePickerController.h"
#import "CategoryPickerController.h"
#import "CategoryRepository.h"
#import "CategoryListController.h"
#import "IngredientViewModel.h"
#import "ExtraFieldsController.h"
#import "EditPreperationController.h"
#import "UIView+Extensions.h"

@interface EditRecipeController()
- (void) setupNavigationBar;
- (void) doneTouched;
- (void) cancelTouched;
- (UITableViewCell *) findParentCell: (UIView *) view;
@end

@implementation EditRecipeController
@synthesize preperationLabel = _preperationLabel;
@synthesize viewModel = _viewModel;
@synthesize doneButton = _doneButton;
@synthesize editRecipeTable = _editRecipeTable;
@synthesize backgroundView = _backgroundView;
@synthesize photoSourceOptions = _photoSourceOptions;
@synthesize totalPrepTimeInput = _totalPrepTimeInput;
@synthesize categoryInput = _categoryInput;
@synthesize cookTimeInput = _cookTimeInput;
@synthesize sitTimeInput = _sitTimeInput;
@synthesize categoryPickerController = _categoryPickerController;
@synthesize timePickerController = _timePickerController;
@synthesize categoryRepository = _categoryRepository;
@synthesize recipeRepository = _recipeRepository;

- (void) dealloc {
  [_doneButton release];
  [_editRecipeTable release];
  [_totalPrepTimeInput release];
  [_categoryPickerController release];
  [_categoryRepository release];
  [_categoryInput release];
  [_timePickerController release];
  [_cookTimeInput release];
  [_sitTimeInput release];
  [_viewModel release];
  [_backgroundView release];
  [_recipeRepository release];
  [_preperationLabel release];
  [_photoSourceOptions release];
  [super dealloc];
}

- (void)viewDidUnload {
  [[NSNotificationCenter defaultCenter] removeObserver: self];  
  [self setEditRecipeTable:nil];
  [self setTotalPrepTimeInput:nil];
  [self setDoneButton: nil];
  [self setCategoryPickerController:nil];
  [self setCategoryInput:nil];
  [self setTimePickerController:nil];
  [self setCookTimeInput:nil];
  [self setSitTimeInput:nil];
  [self setBackgroundView:nil];
  [self setViewModel:nil];
  [self setPreperationLabel:nil];
  [self setPhotoSourceOptions:nil];
  [super viewDidUnload];  
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.tableView setBackgroundView: _backgroundView];
  [self setupPhotoSourceOptions];
  [self setupNavigationBar];
    
  _editRecipeTable.ingredients = _viewModel.ingredients;
  [_editRecipeTable setupSections];
  
  [[NSNotificationCenter defaultCenter] addObserver: self selector:@selector(categoryListChanged) 
    name:@"categoryListChanged" object: nil];
  
  [_categoryPickerController setCategories: [_categoryRepository list]];
  [_categoryPickerController setCategoryInput: _categoryInput];
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

- (void) imagePickerController:(UIImagePickerController *) imagePicker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
//  UIImage *output = [image imageByScalingAndCroppingForSize: CGSizeMake(40, 40)];
  [self dismissModalViewControllerAnimated: YES];    
}

- (void) categoryListChanged {
  [_categoryPickerController setCategories: [_categoryRepository list]];
  [_categoryPickerController categoriesDidChange];
}

- (IBAction)preperationTouched {
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
  [self dismissModalViewControllerAnimated: YES];
}

- (void)cancelTouched {
  [self dismissModalViewControllerAnimated: YES];  
}

- (IBAction)listCategoriesTouched {
  CategoryListController *categoryList = [[[CategoryListController alloc] 
    initWithNibName: @"CategoryListController" bundle: nil] autorelease];  
  [self.navigationController pushViewController: categoryList animated: YES];
}

- (IBAction)recipeNameChanging: (UITextField *) field {
  BOOL canPressDone = [field.text length] > 0;
  [_doneButton setEnabled: canPressDone];
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

- (IBAction)recipeNameChanged:(UITextField *)sender {
  _viewModel.name = sender.text;
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

- (IBAction)addButtonTouched:(UIButton *)sender {
  UITableViewCell *cell = [self findParentCell: sender];
  [cell setSelected:YES animated:NO];
  [cell setSelected:NO animated:YES];
}

- (IBAction)addFieldReleased:(UIButton *)sender {
  ExtraFieldsController *vc = [[ExtraFieldsController alloc] init];
  vc.fields = [_editRecipeTable.extraFields allKeys];
  vc.onFieldChosen = ^(NSString *field) {
    [_editRecipeTable table:self.tableView addExtraField: field];
  };
  [self.navigationController pushViewController: vc animated: YES];
}

- (IBAction)addIngredientReleased:(UIButton *)sender {
  [_editRecipeTable addIngredient: self.tableView];
}

- (IBAction)timeFieldTouched:(id)sender {
  [_timePickerController setTimeInput: sender];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];
  return NO;
}

- (IBAction)photoFieldTouched:(UIButton *)sender {
  if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
    [_photoSourceOptions showInView: self.view];
  } else {
    UIImagePickerController *imagePicker = [[[UIImagePickerController alloc] init] autorelease];
    imagePicker.delegate = self;
    [self presentModalViewController: imagePicker animated:YES];
  }
}

- (void) removeKeyboard {
  UIView *firstResponder = [self.view findFirstResponder];
  [firstResponder resignFirstResponder];  
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  [self removeKeyboard];
}

@end
