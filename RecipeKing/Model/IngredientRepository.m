//
//  IngredientRepository.m
//  RecipeKing
//
//  Created by Lee Irvine on 2/19/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import "IngredientRepository.h"
#import "Ingredient.h"
#import "Recipe.h"

@implementation IngredientRepository

- (id) init {
  if((self = [super init])) {
    _entityName = @"Ingredient";
  }
  return self;
}

- (Ingredient *) addIngredientToRecipe: (Recipe *) recipe {
  NSManagedObjectContext *context = recipe.managedObjectContext;
  Ingredient *ingredient = [NSEntityDescription
    insertNewObjectForEntityForName: _entityName
    inManagedObjectContext: context];  
  ingredient.recipe = recipe;
  return ingredient;
}

- (void) deleteIngredientsFromRecipe: (Recipe *) recipe {
  NSManagedObjectContext *context = recipe.managedObjectContext;
  for(Ingredient *ingredient in recipe.ingredients) {
    [context delete: ingredient];
  }
}

@end
