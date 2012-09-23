//
//  RecipeViewController.m
//  RecipeKing
//
//  Created by Lee Irvine on 4/25/12.
//  Copyright (c) 2012 leescode. All rights reserved.
//

#import "RecipeViewController.h"
#import "RecipeViewModel.h"
#import "NSString-Extensions.h"
#import "RecipeCategoryView.h"
#import "IngredientCell.h"
#import "IngredientViewModel.h"
#import "PreperationCell.h"
#import "ImageViewController.h"
#import "ControllerFactory.h"
#import "Container.h"
#import "EditRecipeViewController.h"
#import "UINavigationBarSkinned.h"
#import "RecipeMapper.h"
#import "ScreenHelper.h"

@implementation RecipeViewController
@synthesize titleCell;
@synthesize ingredientsHeaderCell;
@synthesize preparationHeaderCell;
@synthesize categoryView;
@synthesize servingsView;
@synthesize servingsLabel;
@synthesize recipeNameLabel;
@synthesize preparationTimeLabel;
@synthesize recipePhotoButton;
@synthesize preparationCell;
@synthesize titleView;
@synthesize repository;
@synthesize viewModel=_viewModel;

- (void)dealloc {
  [_viewModel release];
  [titleCell release];
  [ingredientsHeaderCell release];
  [preparationHeaderCell release];
  [categoryView release];
  [recipeNameLabel release];
  [preparationTimeLabel release];
  [preparationCell release];
  [servingsView release];
  [servingsLabel release];
  [recipePhotoButton release];
  [titleView release];
  [repository release];
  [_toolbarCell release];
  [super dealloc];
}

- (void)viewDidUnload {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
  [self setTitleCell:nil];
  [self setIngredientsHeaderCell:nil];
  [self setPreparationHeaderCell:nil];
  [self setCategoryView:nil];
  [self setRecipeNameLabel:nil];
  [self setPreparationTimeLabel:nil];
  [self setPreparationCell:nil];
  [self setServingsView:nil];
  [self setServingsLabel:nil];
  [self setRecipePhotoButton:nil];
  [self setTitleView:nil];
  [self setToolbarCell:nil];
  [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
}

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
  [self.tableView reloadData];
}

- (void) viewDidLoad {
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recipeChanged:)
    name:@"recipeChanged" object:nil];
  
  self.repository = [[Container shared] resolve:@protocol(PRecipeRepository)];
  [self updateFields];
  [self createEditRecipeButton];
}

- (void) createEditRecipeButton {
  UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editRecipeTouched)];
  self.navigationItem.rightBarButtonItem = [addButton autorelease];
}

- (void) editRecipeTouched {
  Recipe *recipe = [self.repository recipeWithId:_viewModel.recipeId];
  EditRecipeViewController *vc = [ControllerFactory buildEditViewControllerForRecipe: recipe];
  UINavigationController *nc = [UINavigationBarSkinned navigationControllerWithRoot: vc];
  [self presentViewController:nc animated:YES completion:^{}];
}

- (void) refresh {
  Recipe *recipe = [self.repository recipeWithId:_viewModel.recipeId];
  RecipeMapper *mapper = [[[RecipeMapper alloc] init] autorelease];
  self.viewModel = [mapper viewModelFromRecipe:recipe];
  [self updateFields];
  [self.tableView reloadData];

}

- (void) recipeChanged:(NSNotification *) notification {
  [self refresh];
}

- (void) updateFields {
  self.recipeNameLabel.text = _viewModel.name;
  self.preparationTimeLabel.text = [NSString stringFromTime:_viewModel.preparationTime];
  
  self.categoryView.category = _viewModel.category;
  self.servingsLabel.text = [NSString stringWithFormat:@"x%d", _viewModel.servings];

  [self.recipePhotoButton setHidden: _viewModel.photo == nil];
  [self.servingsView setHidden: _viewModel.servings == 0];
  [self.categoryView setHidden: [NSString isEmpty: _viewModel.category]];
  
  if(_viewModel.photo) [self showPhoto];
  else [self hidePhoto];
}
- (void) showPhoto {
  [self.recipePhotoButton setHidden:NO];
  [self.recipePhotoButton setBackgroundImage:_viewModel.photoThumbnail forState:UIControlStateNormal];

  CGRect titleFrame = self.titleView.frame;
  titleFrame.size.width = [ScreenHelper screenWidth] - 80.f;
  self.titleView.frame = titleFrame;
}

- (void) hidePhoto {
  [self.recipePhotoButton setHidden:YES];

  CGRect titleFrame = self.titleView.frame;
  titleFrame.size.width = [ScreenHelper screenWidth];
  self.titleView.frame = titleFrame;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  const NSInteger toolBarAndHeader = 2;
  return toolBarAndHeader + [self numIngredientCells] + [self numPreparationCells];
}

- (NSInteger) numIngredientCells {
  NSInteger numIngredients = [_viewModel.ingredients count];
  if(numIngredients > 0) return 1 + numIngredients;
  return 0;
}

- (NSInteger) numPreparationCells {
  NSInteger total = 0;
  if([self shouldShowPreperationCell]) total++;
  return total > 0 ? total + 1 : 0;
}

- (NSInteger) preparationIndex {
  return 1 + [self numIngredientCells];
}

- (NSInteger) toolbarIndex {
  NSInteger total = 0;
  total += [self numPreparationCells];
  total += [self numIngredientCells];
  return total + 1;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if([self isIndexPathForTitleCell: indexPath]) return 80.f;
  if([self isIndexPathForIngredientHeaderCell: indexPath]) return 30.f;
  if([self isIndexPathForIngredientCell: indexPath]) return [IngredientCell height];
  if([self isIndexPathForPreperationHeaderCell: indexPath]) return 30.f;
  if([self isIndexPathForPreperationCell: indexPath]) return [PreperationCell heightWithText: _viewModel.preparation];
  if([self isIndexPathForToolbarCell: indexPath]) return 40.f;
  return 0.f;
}

- (BOOL) isIndexPathForTitleCell:(NSIndexPath *) indexPath {
  return indexPath.row == 0;
}
- (BOOL) isIndexPathForIngredientHeaderCell:(NSIndexPath *) indexPath {
  return indexPath.row == 1 && [self numIngredientCells] > 0;
}
- (BOOL) isIndexPathForIngredientCell:(NSIndexPath *) indexPath {
  return indexPath.row > 1 && indexPath.row < [self preparationIndex];
}
- (BOOL) isIndexPathForPreperationHeaderCell:(NSIndexPath *) indexPath {
  return indexPath.row == [self preparationIndex] && [self shouldShowPreperationCell];;
}
- (BOOL) isIndexPathForPreperationCell: (NSIndexPath *) indexPath {
  return indexPath.row == [self preparationIndex] + 1 && [self shouldShowPreperationCell];
}
- (BOOL) isIndexPathForToolbarCell: (NSIndexPath *) indexPath {
  return indexPath.row == [self toolbarIndex];
}
- (BOOL) shouldShowPreperationCell {
  return [NSString isEmpty: _viewModel.preparation] == NO;
}


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  if([self isIndexPathForTitleCell: indexPath]) return self.titleCell;
  if([self isIndexPathForIngredientHeaderCell: indexPath]) return self.ingredientsHeaderCell;
  if([self isIndexPathForIngredientCell: indexPath]) return [self tableView: tableView ingredientCellForIndexPath: indexPath];
  if([self isIndexPathForPreperationHeaderCell: indexPath]) return self.preparationHeaderCell;
  if([self isIndexPathForPreperationCell: indexPath]) {
    [self.preparationCell setPreparation: _viewModel.preparation];
    return self.preparationCell;
  }
  if([self isIndexPathForToolbarCell: indexPath]) return self.toolbarCell;
  return nil;
}

- (UITableViewCell *) tableView:(UITableView *)tableView ingredientCellForIndexPath:(NSIndexPath *) indexPath {
  static NSString *reuseId = @"ingredientCell";
  IngredientCell *cell = (IngredientCell *)[tableView dequeueReusableCellWithIdentifier: reuseId];
  if(cell == nil) {
    cell = [[[IngredientCell alloc] initWithReuseIdentifier:reuseId] autorelease];
  }
  
  IngredientViewModel *ingredient = [self.viewModel.ingredients objectAtIndex:indexPath.row - 2];
  cell.nameLabel.text = [ingredient.name trim];
  cell.quantityLabel.text = [ingredient.quantity trim];
  [cell setQuantityWidth: _viewModel.widestQuantity];
  return cell;
}

- (IBAction)shareTouched:(id)sender {
}

- (IBAction)photoTouched:(id)sender {
  UIViewController *vc = [ControllerFactory imageViewControllerWithImage:_viewModel.photo];
  [self.navigationController pushViewController:vc animated:YES];
}

@end
