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

const int kIngredientsSection = 2;

@interface EditRecipeTableController ()
- (UITableViewCell *) tableView:(UITableView *)tableView ingredientCellForRow: (NSInteger) row;
@end

@implementation EditRecipeTableController
@synthesize recipeNameCell=_recipeNameCell;
@synthesize totalPrepTimeCell=_totalPrepTimeCell;
@synthesize cookTimeCell=_cookTimeCell;
@synthesize sitTimeCell=_sitTimeCell;
@synthesize categoryCell=_categoryCell;
@synthesize addFieldCell=_addFieldCell;
@synthesize preperationCell=_preperationCell;
@synthesize photoCell=_photoCell;
@synthesize temperatureCell=_temperatureCell;
@synthesize servingsCell=_servingsCell;
@synthesize addIngredientCell = _addIngredientCell;
@synthesize ingredients=_ingredients;

- (void)dealloc {
  [_recipeNameCell release];
  [_totalPrepTimeCell release];
  [_cookTimeCell release];
  [_sitTimeCell release];
  [_categoryCell release];
  [_addFieldCell release];
  [_preperationCell release];
  [_photoCell release];
  [_temperatureCell release];
  [_servingsCell release];
  [_sections release];
  [_addIngredientCell release];
  [super dealloc];
}

- (void) setupSections {
  _sections = [[NSArray arrayWithObjects:
    [NSArray arrayWithObjects: _recipeNameCell, _totalPrepTimeCell, nil], 
    [NSArray arrayWithObjects: _categoryCell, _preperationCell, _addFieldCell, nil], 
    _ingredients, 
    nil] retain];
}

- (void) addIngredient: (UITableView *) tableView {
  IngredientViewModel *ingredient = [[[IngredientViewModel alloc] init] autorelease];
  [_ingredients addObject: ingredient];
  NSIndexPath *index = [NSIndexPath indexPathForRow:[_ingredients count] - 1 inSection: kIngredientsSection];
  [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:index] withRowAnimation:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if(section == kIngredientsSection) {
    return [_ingredients count] + 1;
  }
  return [[_sections objectAtIndex: section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return [_sections count];
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  switch (section) {
    case kIngredientsSection: return @"Ingredients";
  }
  return @"";
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
  if(row == [_ingredients count]) return _addIngredientCell;
    
  static NSString *reuseId = @"editIngredientCell";
  EditIngredientCell *cell = (EditIngredientCell *)[tableView dequeueReusableCellWithIdentifier: reuseId];
  if (cell == nil) {
    cell = [[[EditIngredientCell alloc] initWithReuseIdentifier: reuseId] autorelease];
  }
  
  IngredientViewModel *ingredient = [_ingredients objectAtIndex: row];
  cell.viewModel = ingredient;
  cell.selectionStyle = UITableViewCellSelectionStyleNone;
  return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {    
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    [_ingredients removeObjectAtIndex: indexPath.row];
    NSArray *rowsToDelete = [NSArray arrayWithObject:indexPath];
    [tableView deleteRowsAtIndexPaths: rowsToDelete withRowAnimation:UITableViewRowAnimationFade];
  }
}

- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
  return indexPath.section == kIngredientsSection && indexPath.row != [_ingredients count];
}


@end
