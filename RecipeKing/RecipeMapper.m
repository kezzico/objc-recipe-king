//
//  RecipeMapper.m
//  RecipeKing
//
//  Created by Lee Irvine on 2/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RecipeMapper.h"
#import "Recipe.h"
#import "RecipeViewModel.h"
#import "Ingredient.h"
#import "IngredientViewModel.h"

@implementation RecipeMapper
@synthesize ingredientRepository=_ingredientRepository;
@synthesize categoryRepository=_categoryRepository;

- (void) dealloc {
  [_ingredientRepository release];
  [super dealloc];
}

- (void) recipe: (Recipe *) r toViewModel: (RecipeViewModel *) v {
  v.name = r.name;
  v.cookTime = r.cookTime;
  v.cookTemperature = r.cookTemperature;
  v.preperation = r.instructions;
  v.category = [r.category name];  
  v.image = [UIImage imageWithData: r.image];
  
  v.ingredients = [[NSMutableArray alloc] initWithCapacity: [r.ingredients count]];
  for(Ingredient *ingredient in r.ingredients) {
    IngredientViewModel *iv = [[IngredientViewModel alloc] init];
    iv.name = ingredient.name;
    iv.quantity = ingredient.quantity;
    [v.ingredients addObject: iv];
  }
}

- (void) viewModel: (RecipeViewModel *) v toRecipe: (Recipe *) r {
  r.name = r.name;
  r.cookTime = r.cookTime;
  r.cookTemperature = r.cookTemperature;
  r.instructions = r.instructions;
  [_categoryRepository setCategory: v.category forRecipe:r];
  r.image = UIImagePNGRepresentation(v.image);  
  
  NSInteger index = 0;
  [_ingredientRepository deleteIngredientsFromRecipe: r];
  for(IngredientViewModel *iv in v.ingredients) {
    Ingredient *ingredient = [_ingredientRepository addIngredientToRecipe: r];
    ingredient.index = [[NSNumber alloc] initWithInt: index++];
    ingredient.name = iv.name;
    ingredient.quantity = iv.quantity;
  }
}

- (void) json: (NSDictionary *) data toViewModel: (RecipeViewModel *) v {
  
}

- (NSDictionary *) viewModelToJson: (RecipeViewModel *) v {
  return nil;
}

- (NSString *) viewModelToText: (RecipeViewModel *) v {
  return nil;
}

@end
