//
//  EditRecipeTests.m
//  RecipeKing
//
//  Created by Lee Irvine on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EditRecipeTests.h"
#import "EditRecipeTableController.h"
#import "IngredientViewModel.h"
#import "EditIngredientCell.h"

@implementation EditRecipeTests

- (void) testShouldGetIngredientCell {
  NSIndexPath *path = [NSIndexPath indexPathForRow: 0 inSection: 2];
  IngredientViewModel *ingredient = [[IngredientViewModel alloc] init];
  ingredient.name = @"test recipe name";
  ingredient.quantity = @"test quantity";
  
  EditRecipeTableController *controller = [[EditRecipeTableController alloc] init];
  controller.ingredients = [NSArray arrayWithObject: ingredient];
  EditIngredientCell *cell = (EditIngredientCell *)[controller tableView: nil cellForRowAtIndexPath: path];
  
  STAssertTrue([cell.nameField.text isEqualToString: ingredient.name], @"Strings are not equal");
}

@end
