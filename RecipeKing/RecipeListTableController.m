//
//  RecipeListTable.m
//  RecipeKing
//
//  Created by Lee Irvine on 2/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RecipeListController.h"
#import "RecipeListTableController.h"
#import "ListRecipe.h"
#import "RecipeCell.h"
#import "CategoryCell.h"

@interface RecipeListTableController()
- (UITableViewCell *) tableView: (UITableView *) tableView recipeCellAtRow: (NSInteger) row;
- (UITableViewCell *) tableView: (UITableView *) tableView categoryCellAtRow: (NSInteger) row;
@end

@implementation RecipeListTableController
@synthesize controller=_controller;

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [_controller.recipesAndCategories count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  if([_controller rowIsRecipeCell: indexPath.row]) return [self tableView: tableView recipeCellAtRow: indexPath.row];
  return [self tableView: tableView categoryCellAtRow: indexPath.row];
}

- (UITableViewCell *) tableView: (UITableView *) tableView recipeCellAtRow: (NSInteger) row {
  static NSString *cellIdentifier = @"RecipeListRecipeCell";  
  RecipeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  if (cell == nil) {
    cell = [[[RecipeCell alloc] initWithReuseIdentifier:cellIdentifier] autorelease];
  }

  ListRecipe *recipe = [_controller.recipesAndCategories objectAtIndex: row];
  cell.recipeNameLabel.text = recipe.name;
  cell.cookTimeLabel.text = recipe.cookTime;

  return cell;
}

- (UITableViewCell *) tableView: (UITableView *) tableView categoryCellAtRow: (NSInteger) row {
  static NSString *CellIdentifier = @"RecipeListCategoryCell";  
  CategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[[CategoryCell alloc] initWithReuseIdentifier: CellIdentifier] autorelease];
  }
  
  NSString *category = [_controller.recipesAndCategories objectAtIndex: row];
  cell.categoryLabel.text = category;
  
  return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *) indexPath {
  if([_controller rowIsRecipeCell: indexPath.row]) {
    return 48.0f;
  }
  return 24.0f;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {    
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    NSMutableArray *rowsToDelete = [NSMutableArray arrayWithObject:indexPath];
    ListRecipe *recipe = [_controller.recipesAndCategories objectAtIndex: indexPath.row];
    [_controller deleteRecipe: recipe];
    [[_controller findAndRemoveEmptyCategories] enumerateIndexesUsingBlock:^(NSUInteger index, BOOL *stop) {
      [rowsToDelete addObject:[NSIndexPath indexPathForRow:index inSection: 0]];
    }];
    [tableView deleteRowsAtIndexPaths: rowsToDelete withRowAnimation:UITableViewRowAnimationFade];
  }
}

- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
  return [_controller rowIsRecipeCell: indexPath.row];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  if([_controller rowIsRecipeCell: indexPath.row]) {
    ListRecipe *recipe = [_controller.recipesAndCategories objectAtIndex: indexPath.row];    
    [_controller recipeTouched: recipe];
  }
}

@end
