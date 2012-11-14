//
//  EditRecipeTable.m
//  RecipeKing
//
//  Created by Lee Irvine on 3/24/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import "EditRecipeTableController.h"
#import "EditIngredientCell.h"
#import "IngredientViewModel.h"
#import "EditRecipeViewModel.h"

const int kIngredientsSection = 2;
const int kMiscFieldSection = 1;

@implementation EditRecipeTableController

- (void)dealloc {
  [_recipeNameCell release];
  [_totalPrepTimeCell release];
  [_categoryCell release];
  [_preparationCell release];
  [_photoCell release];
  [_servingsCell release];
  [_sections release];
  [_addIngredientCell release];
  [_tableView release];
  [super dealloc];
}

- (void) unload {
  [self setTableView:nil];
  [self setRecipeNameCell:nil];
  [self setCategoryCell:nil];
  [self setPreparationCell:nil];
  [self setPhotoCell:nil];
  [self setServingsCell:nil];
  [self setAddIngredientCell:nil];
}

- (void) setupSections {
  self.sections = [NSArray arrayWithObjects:
    [NSArray arrayWithObjects: _recipeNameCell, _totalPrepTimeCell, nil], 
    [NSArray arrayWithObjects: _categoryCell, _servingsCell, _preparationCell, _photoCell, nil],
    _viewModel.ingredients, nil];
}

- (IBAction)addIngredientTouchedDown:(UIButton *)sender {
  UITableViewCell *cell = [self findParentCell: sender];
  [cell setSelected:YES animated:NO];
  [cell setSelected:NO animated:YES];
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

- (IBAction)addIngredientTouched:(UIButton *)sender {
  [self addIngredient];
}

- (IngredientViewModel *) addIngredient {
  IngredientViewModel *ingredient = [[[IngredientViewModel alloc] init] autorelease];
  [_viewModel.ingredients addObject: ingredient];
  NSIndexPath *index = [NSIndexPath indexPathForRow:[_viewModel.ingredients count] - 1 inSection: kIngredientsSection];
  [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:index] withRowAnimation:YES];
  
  return ingredient;
}

#pragma mark table view delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if(section == kIngredientsSection) {
    return [_viewModel.ingredients count] + 1;
  }
  return [[_sections objectAtIndex: section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return [_sections count];
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  switch (section) {
    case kIngredientsSection: return _L(@"Ingredients");
  }
  return @"";
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {  
  return 40.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = nil;
  if(indexPath.section == kIngredientsSection) {
    cell = [self tableView: tableView ingredientCellForRow: indexPath.row];
  } else {
    NSArray *section = [_sections objectAtIndex: indexPath.section];
    if(section != nil) cell = [section objectAtIndex: indexPath.row];
  }

  return cell;
}

- (UITableViewCell *) tableView:(UITableView *)tableView ingredientCellForRow: (NSInteger) row {
  if(row == [_viewModel.ingredients count]) return _addIngredientCell;
    
  static NSString *reuseId = @"editIngredientCell";
  EditIngredientCell *cell = (EditIngredientCell *)[tableView dequeueReusableCellWithIdentifier: reuseId];
  if (cell == nil) {
    cell = [[[EditIngredientCell alloc] initWithReuseIdentifier: reuseId] autorelease];
  }
  
  IngredientViewModel *ingredient = [_viewModel.ingredients objectAtIndex: row];
  cell.viewModel = ingredient;
  cell.selectionStyle = UITableViewCellSelectionStyleNone;
  return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    [_viewModel.ingredients removeObjectAtIndex: indexPath.row];
    [tableView deleteRowsAtIndexPaths: [NSArray arrayWithObject: indexPath] withRowAnimation:UITableViewRowAnimationFade];
  }
}

- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
  return indexPath.section == kIngredientsSection && indexPath.row != [_viewModel.ingredients count];
}

@end
