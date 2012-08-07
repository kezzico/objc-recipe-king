//
//  MapperTests.m
//  RecipeKing
//
//  Created by Lee Irvine on 2/19/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import "RecipeMapperTests.h"
#import "Recipe.h"
#import "RecipeCategory.h"
#import "RecipeListMapper.h"
#import "RecipeMapper.h"
#import "RecipeRepository.h"
#import "CategoryRepository.h"
#import "ManagedContextFactory.h"
#import "RecipeViewModel.h"
#import "EditRecipeViewModel.h"
#import "IngredientViewModel.h"

@implementation RecipeMapperTests

+ (void) setUp {
  [ManagedContextFactory resetStoreCoordinator];
  RecipeRepository *rrepository = [[[RecipeRepository alloc] init] autorelease];
  CategoryRepository *crepository = [[[CategoryRepository alloc] init] autorelease];
  
  [crepository add: @"Chinese"];
  [crepository add: @"Desert"];

  Recipe *recipe1 = [rrepository newRecipe];
  Recipe *recipe2 = [rrepository newRecipe];
  Recipe *recipe3 = [rrepository newRecipe];
  Recipe *recipe4 = [rrepository newRecipe];

  recipe1.name = @"Stir Fry";
  [crepository setCategory: @"Chinese" forRecipe: recipe1];
  [recipe1 addIngredientWithName:@"Shrimp" quantity:@"4"];
  [recipe1 addIngredientWithName:@"Rice" quantity:@"1/4 cup"];
  recipe1.preperation = @"Stir hard and fry long";
  recipe1.preperationTime = [NSNumber numberWithInt: 100];
  recipe1.servings = [NSNumber numberWithInt:1];
  
  recipe2.name = @"Cajun Cow Pie";
  [crepository setCategory: @"Desert" forRecipe: recipe2];
  [recipe2 addIngredientWithName:@"poo" quantity:@"8 gallons"];
  
  recipe3.name = @"Chocolate Surprise";
  [recipe3 addIngredientWithName:@"chocolate" quantity:@"1"];
  [recipe3 addIngredientWithName:@"surprise" quantity:@"extra"];

  recipe4.name = @"Apple Pie";
  [crepository setCategory: @"Desert" forRecipe: recipe4];
  
  [rrepository save];
}
- (void) setUp {
  _recipeRepository = [[RecipeRepository alloc] init];
  _listMapper = [[RecipeListMapper alloc] init];
  _recipeMapper = [[RecipeMapper alloc] init];
}
- (void) tearDown {
  [_recipeRepository release];
  [_listMapper release];
  [_recipeMapper release];
}

- (void) testShouldMapListOfRecipesToViewModels {
  NSArray *recipes = [_recipeRepository allRecipes];
  NSArray *result = [_listMapper recipeListToViewModel: recipes];
  
  STAssertTrue([result count] == 6, @"got %d", [result count]);
  if([result count] != 6) return;
  
  STAssertEqualObjects([[result objectAtIndex: 0] name], @"Chocolate Surprise", @"got %@", [result objectAtIndex:0]);
  STAssertEqualObjects([result objectAtIndex: 1], @"Chinese", @"got %@", [result objectAtIndex:1]);
  STAssertEqualObjects([[result objectAtIndex: 2] name], @"Stir Fry", @"got %@", [result objectAtIndex:2]);
  STAssertEqualObjects([result objectAtIndex: 3], @"Desert", @"got %@", [result objectAtIndex:3]);
  STAssertEqualObjects([[result objectAtIndex: 4] name], @"Apple Pie", @"got %@", [[result objectAtIndex:4] name]);
  STAssertEqualObjects([[result objectAtIndex: 5] name], @"Cajun Cow Pie", @"got %@", [[result objectAtIndex:5] name]);
}

- (void) testMappingRecipeToRecipeViewModel {
  Recipe *recipe = [[_recipeRepository allRecipes] objectAtIndex:1];
  RecipeViewModel *result = [_recipeMapper viewModelFromRecipe:recipe];
  
  STAssertEqualObjects(recipe.name, result.name, @"got %@", result.name);
  STAssertEqualObjects(recipe.category.name, result.category, @"got %@", result.category);
  STAssertEqualObjects(recipe.preperation, result.preperation, @"got %@", result.preperation);
  STAssertTrue([recipe.preperationTime integerValue] == result.preperationTime, @"got %d", result.preperationTime);
  STAssertTrue([recipe.servings integerValue] == result.servings, @"got %d", result.servings);
  STAssertTrue([result.ingredients count] == 2, @"got %d", [result.ingredients count]);
  
  if([result.ingredients count] != 2) return;
  STAssertEqualObjects([[result.ingredients objectAtIndex:0] name], @"Shrimp", @"wrong");
  STAssertEqualObjects([[result.ingredients objectAtIndex:0] quantity], @"4", @"wrong");
  STAssertEqualObjects([[result.ingredients objectAtIndex:1] name], @"Rice", @"wrong");
  STAssertEqualObjects([[result.ingredients objectAtIndex:1] quantity], @"1/4 cup", @"wrong");
  
}

- (void) testMappingRecipeToEditViewModel {
  Recipe *recipe = [[_recipeRepository allRecipes] objectAtIndex:1];
  EditRecipeViewModel *result = [_recipeMapper editViewModelFromRecipe:recipe];
  
  STAssertEqualObjects(recipe.name, result.name, @"got %@", result.name);
  STAssertEqualObjects(recipe.category.name, result.category, @"got %@", result.category);
  STAssertEqualObjects(recipe.preperation, result.preperation, @"got %@", result.preperation);
  STAssertTrue([recipe.preperationTime integerValue] == result.preperationTime, @"got %d", result.preperationTime);
  STAssertTrue([recipe.servings integerValue] == result.servings, @"got %d", result.servings);
  STAssertTrue([result.ingredients count] == 2, @"got %d", [result.ingredients count]);
  
  if([result.ingredients count] != 2) return;
  STAssertEqualObjects([[result.ingredients objectAtIndex:0] name], @"Shrimp", @"wrong");
  STAssertEqualObjects([[result.ingredients objectAtIndex:0] quantity], @"4", @"wrong");
  STAssertEqualObjects([[result.ingredients objectAtIndex:1] name], @"Rice", @"wrong");
  STAssertEqualObjects([[result.ingredients objectAtIndex:1] quantity], @"1/4 cup", @"wrong");
  
}

- (void) testMappingEditViewModelToRecipe {
  Recipe *result = [_recipeRepository newRecipe];
  EditRecipeViewModel *recipe = [[[EditRecipeViewModel alloc] init] autorelease];
  
  recipe.name = @"Test Recipe";
  recipe.category = @"Desert";
  recipe.preperation = @"cook it all the way";
  
  recipe.servings = 1;
  recipe.preperationTime = 2;
  
  IngredientViewModel *ingredient = [[[IngredientViewModel alloc] init] autorelease];
  recipe.ingredients = [NSArray arrayWithObject: ingredient];
  ingredient.name = @"Shrimp";
  ingredient.quantity = @"4";
  
  [_recipeMapper editViewModel:recipe toRecipe:result];

  STAssertEqualObjects(recipe.name, result.name, @"got %@", result.name);
  STAssertEqualObjects(recipe.category, result.category.name, @"got %@", result.category.name);
  STAssertEqualObjects(recipe.preperation, result.preperation, @"got %@", result.preperation);
  STAssertTrue(recipe.preperationTime == [result.preperationTime integerValue], @"got %d", result.preperationTime);
  STAssertTrue(recipe.servings == [result.servings integerValue], @"got %d", result.servings);
  STAssertTrue([result.ingredients count] == 1, @"got %d", [result.ingredients count]);
  
  if([result.ingredients count] == 1) return;
  STAssertEqualObjects([[result.ingredients anyObject] name], @"Shrimp", @"wrong");
  STAssertEqualObjects([[result.ingredients anyObject] quantity], @"4", @"wrong");
  
}

@end
