//
//  EditRecipeTests.m
//  RecipeKing
//
//  Created by Lee Irvine on 3/31/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import "EditRecipeTests.h"
#import "EditRecipeTableController.h"
#import "IngredientViewModel.h"
#import "EditIngredientCell.h"
#import "EditRecipeViewModel.h"

@implementation EditRecipeTests

- (void) testShouldGetIngredientCell {
  NSIndexPath *path = [NSIndexPath indexPathForRow: 0 inSection: 2];
  IngredientViewModel *ingredient = [[IngredientViewModel alloc] init];
  ingredient.name = @"test recipe name";
  ingredient.quantity = @"test quantity";
  
  EditRecipeTableController *controller = [[EditRecipeTableController alloc] init];
  controller.viewModel = [[[EditRecipeViewModel alloc] init] autorelease];
  controller.viewModel.ingredients = [NSArray arrayWithObject: ingredient];
  EditIngredientCell *cell = (EditIngredientCell *)[controller tableView: nil cellForRowAtIndexPath: path];
  
  STAssertEqualObjects(cell.nameField.text, ingredient.name, @"got %@", cell.nameField.text);
}

@end
