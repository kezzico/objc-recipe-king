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
#import "RecipeMapper.h"
#import "ScreenHelper.h"
#import "SharingController.h"
#import "NavigationController.h"

@implementation RecipeViewController

- (void)dealloc {
  [_viewModel release];
  [_titleCell release];
  [_ingredientsHeaderCell release];
  [_preparationHeaderCell release];
  [_categoryView release];
  [_recipeNameLabel release];
  [_preparationTimeLabel release];
  [_preparationCell release];
  [_servingsView release];
  [_servingsLabel release];
  [_recipePhotoButton release];
  [_titleView release];
  [_repository release];
  [_sharingController release];
  [_tableView release];
  [super dealloc];
}

- (void)viewDidUnload {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
  [self.sharingController didUnload];
  self.sharingController = nil;
  self.repository = nil;
  
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
  [self setSharingController:nil];
  [self setTableView:nil];
  [super viewDidUnload];
}

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
  [self.tableView reloadData];
}

- (void) viewDidLoad {
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recipeChanged:)
    name:@"recipeChanged" object:nil];
  
  self.repository = [[Container shared] resolve:@protocol(PRecipeRepository)];
  self.sharingController.recipe = [self.repository recipeWithName:_viewModel.name];
  [self updateFields];
}

- (IBAction)editRecipeTouched:(id)sender {
  Recipe *recipe = [self.repository recipeWithName:_viewModel.name];
  EditRecipeViewController *vc = [ControllerFactory buildEditViewControllerForRecipe: recipe];
  NavigationController *nc = [NavigationController navWithRoot:vc];
  [self.navcontroller presentViewController:nc animated:YES completion:^{}];
}

- (void) refresh {
  Recipe *recipe = [self.repository recipeWithName:_viewModel.name];
  RecipeMapper *mapper = [[[RecipeMapper alloc] init] autorelease];
  self.viewModel = [mapper viewModelFromRecipe:recipe];
  [self updateFields];
  [self.tableView reloadData];

}

- (void) recipeChanged:(NSNotification *) notification {
  NSString *oldName = [notification.userInfo valueForKey:@"oldname"];
  NSString *newName = [notification.userInfo valueForKey:@"newname"];
  
  if([_viewModel.name isEqual: oldName]) {
    _viewModel.name = newName;
  }
  
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
  return [self numIngredientCells] + [self numPreparationCells] + 1;
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

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if([self isIndexPathForTitleCell: indexPath]) return 80.f;
  if([self isIndexPathForIngredientHeaderCell: indexPath]) return 30.f;
  if([self isIndexPathForIngredientCell: indexPath]) return [IngredientCell height];
  if([self isIndexPathForPreperationHeaderCell: indexPath]) return 30.f;
  if([self isIndexPathForPreperationCell: indexPath]) return [PreperationCell heightWithText: _viewModel.preparation];
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

- (IBAction)photoTouched:(id)sender {
  ContentViewController *vc = [ControllerFactory imageViewControllerWithImage:_viewModel.photo];
  [self.navcontroller pushViewController:vc];
}

@end
