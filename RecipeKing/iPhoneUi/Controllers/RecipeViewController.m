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

@implementation RecipeViewController
@synthesize titleCell;
@synthesize ingredientsHeaderCell;
@synthesize preperationHeaderCell;
@synthesize categoryView;
@synthesize recipeNameLabel;
@synthesize preperationTimeLabel;
@synthesize preperationCell;
@synthesize viewModel=_viewModel;

- (void)dealloc {
  [_viewModel release];
  [titleCell release];
  [ingredientsHeaderCell release];
  [preperationHeaderCell release];
  [categoryView release];
  [recipeNameLabel release];
  [preperationTimeLabel release];
  [preperationCell release];
  [super dealloc];
}

- (void)viewDidUnload {
  [self setTitleCell:nil];
  [self setIngredientsHeaderCell:nil];
  [self setPreperationHeaderCell:nil];
  [self setCategoryView:nil];
  [self setRecipeNameLabel:nil];
  [self setPreperationTimeLabel:nil];
  [self setPreperationCell:nil];
  [super viewDidUnload];
}

- (void) viewDidLoad {
  self.recipeNameLabel.text = _viewModel.name;
  self.preperationTimeLabel.text = [NSString stringFromTime:_viewModel.preperationTime];
  
  [self.categoryView setHidden: [NSString isEmpty: _viewModel.category]];
  self.categoryView.nameLabel.text = _viewModel.category;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 1 + [self numIngredientCells] + [self numPreperationCells];
}
- (NSInteger) numIngredientCells {
  NSInteger numIngredients = [_viewModel.ingredients count];
  if(numIngredients > 0) return 1 + numIngredients;
  
  return 0;
}

- (NSInteger) numPreperationCells {
  return 2;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if([self isIndexPathForTitleCell: indexPath]) return 90.f;
  if([self isIndexPathForIngredientHeaderCell: indexPath]) return 30.f;
  if([self isIndexPathForIngredientCell: indexPath]) return [IngredientCell height];
  if([self isIndexPathForPreperationHeaderCell: indexPath]) return 40.f;
  if([self isIndexPathForPreperationCell: indexPath]) return [PreperationCell heightWithText: _viewModel.preperation];
  return 0.f;
}

- (BOOL) isIndexPathForTitleCell:(NSIndexPath *) indexPath {
  return indexPath.row == 0;
}
- (BOOL) isIndexPathForIngredientHeaderCell:(NSIndexPath *) indexPath {
  return indexPath.row == 1;
}
- (BOOL) isIndexPathForIngredientCell:(NSIndexPath *) indexPath {
  return indexPath.row > 1 && indexPath.row < [self preperationIndex];
}
- (BOOL) isIndexPathForPreperationHeaderCell:(NSIndexPath *) indexPath {
  return indexPath.row == [self preperationIndex];
}
- (BOOL) isIndexPathForPreperationCell: (NSIndexPath *) indexPath {
  return indexPath.row == [self preperationIndex] + 1 && [self shouldShowPreperationCell];
}
- (BOOL) shouldShowPreperationCell {
  return [NSString isEmpty: _viewModel.preperation] == NO;
}

- (CGFloat) preperationIndex {
  return 1 + [self numIngredientCells];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  if([self isIndexPathForTitleCell: indexPath]) return self.titleCell;
  if([self isIndexPathForIngredientHeaderCell: indexPath]) return self.ingredientsHeaderCell;
  if([self isIndexPathForIngredientCell: indexPath]) return [self tableView: tableView ingredientCellForIndexPath: indexPath];
  if([self isIndexPathForPreperationHeaderCell: indexPath]) return self.preperationHeaderCell;
  if([self isIndexPathForPreperationCell: indexPath]) {
    [self.preperationCell setPreperation: _viewModel.preperation];
    return self.preperationCell;
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
  cell.nameLabel.text = ingredient.name;
  cell.quantityLabel.text = ingredient.quantity;
  return cell;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
}

@end
