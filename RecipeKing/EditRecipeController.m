//
//  EditRecipeController.m
//  RecipeKing
//
//  Created by Lee Irvine on 3/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
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
  [super viewDidUnload];  
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.tableView.backgroundView = _backgroundView;
  [self setupNavigationBar];
    
  _editRecipeTable.ingredients = _viewModel.ingredients;
  [_editRecipeTable setupSections];
  
  [[NSNotificationCenter defaultCenter] addObserver: self selector:@selector(categoryListChanged) 
    name:@"categoryListChanged" object: nil];
  
  [_categoryPickerController setCategories: [_categoryRepository list]];
  [_categoryPickerController setCategoryInput: _categoryInput];
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

- (void) categoryListChanged {
  [_categoryPickerController setCategories: [_categoryRepository list]];
  [_categoryPickerController categoriesDidChange];
}

- (IBAction)preperationTouched {
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
  [self.navigationController pushViewController: vc animated: YES];  
}

- (IBAction)addIngredientReleased:(UIButton *)sender {
  [_editRecipeTable addIngredient: self.tableView];
}

- (IBAction)timeFieldTouched:(id)sender {
  [_timePickerController setTimeInput: sender];
}

@end
