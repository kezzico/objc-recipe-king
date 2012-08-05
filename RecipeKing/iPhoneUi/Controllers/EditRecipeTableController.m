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
@synthesize tableView = _tableView;
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
@synthesize sections=_sections;
@synthesize extraFields=_extraFields;

- (void)dealloc {
  [_extraFields release];
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
  [_tableView release];
  [super dealloc];
}

- (void) setupSections {
  self.sections = [NSArray arrayWithObjects:
    [NSArray arrayWithObjects: _recipeNameCell, _totalPrepTimeCell, nil], 
    [NSMutableArray arrayWithObjects: _categoryCell, _preperationCell, _addFieldCell, nil],
    _viewModel.ingredients, nil];
  
  self.extraFields = [NSMutableDictionary 
    dictionaryWithObjects: [NSArray arrayWithObjects:_temperatureCell, _cookTimeCell, _sitTimeCell, _servingsCell, _photoCell, nil]
                  forKeys: [NSArray arrayWithObjects:@"Cook Temperature", @"Cook Time", @"Sit Time", @"Servings", @"Photo", nil]];
}

- (void) addExtraField:(NSString *) fieldName {
  UITableViewCell *extraField = [_extraFields valueForKey: fieldName];
  [_extraFields removeObjectForKey: fieldName];
  
  NSMutableArray *section = [_sections objectAtIndex: kMiscFieldSection];
  [section insertObject:extraField atIndex: [section count] - 1];

  [self.tableView reloadData];
  if([_extraFields count] == 0) {
    [self removeExtraFieldButton];
  }
}

- (void) removeExtraFieldButton {
  NSMutableArray *section = [_sections objectAtIndex: kMiscFieldSection];
  [section removeObjectAtIndex: [section count] - 1];
  NSIndexPath *index = [NSIndexPath indexPathForRow:[section count] - 1 inSection: kMiscFieldSection];
  [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:index] withRowAnimation:NO];
}

- (void) addIngredient: (UITableView *) tableView {
  IngredientViewModel *ingredient = [[[IngredientViewModel alloc] init] autorelease];
  [_viewModel.ingredients addObject: ingredient];
  NSIndexPath *index = [NSIndexPath indexPathForRow:[_viewModel.ingredients count] - 1 inSection: kIngredientsSection];
  [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:index] withRowAnimation:YES];
}

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
    case kIngredientsSection: return @"Ingredients";
  }
  return @"";
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if(indexPath.section == kMiscFieldSection) {
    NSArray *section = [_sections objectAtIndex: indexPath.section];
    if([section objectAtIndex: indexPath.row] == _photoCell) return 240.0f;    
  }
  
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
    NSArray *rowsToDelete = [NSArray arrayWithObject:indexPath];
    [tableView deleteRowsAtIndexPaths: rowsToDelete withRowAnimation:UITableViewRowAnimationFade];
  }
}

- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
  return indexPath.section == kIngredientsSection && indexPath.row != [_viewModel.ingredients count];
}

@end
