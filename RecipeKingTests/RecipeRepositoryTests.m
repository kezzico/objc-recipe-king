//
//  recipeRepositoryTests.m
//  RecipeKing
//
//  Created by Lee Irvine on 2/17/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//
#import "RecipeRepositoryTests.h"
#import "RecipeRepository.h"
#import "CategoryRepository.h"
#import "Recipe.h"
#import "RecipeCategory.h"

@implementation RecipeRepositoryTests

- (void) testShouldSaveRecipe {
  RecipeRepository *repository = [[[RecipeRepository alloc] init] autorelease];
  Recipe *recipe = [[[Recipe alloc] init] autorelease];
  
  recipe.preparationTime = [NSNumber numberWithInt:300];
  recipe.name = @"Test Recipe";
  recipe.preparation = @"Test it";
  
  [repository saveRecipe: recipe];
  
  repository = [[[RecipeRepository alloc] init] autorelease];
  Recipe *result = [repository recipeWithId: recipe.recipeId];
  STAssertNotNil(recipe.recipeId, @"recipe id not assigned");
  STAssertEqualObjects(recipe.name, result.name, nil);
  STAssertEqualObjects(recipe.preparation, result.preparation, nil);
}

//- (void) testShouldSaveRecipeWithCategory {
//  NSString *categoryName = @"Recipe Test Category";
//  [_categoryRepository add: categoryName];  
//  Recipe *recipe = [[[Recipe alloc] init] autorelease];
//
//  
//  [_categoryRepository setCategory: categoryName forRecipe: newRecipe];
//  [_repository save];
//  
//  Recipe *result = [_repository recipeWithId: newRecipe.objectID];
//  NSString *resultCategory = result.category.name;
//  STAssertEqualObjects(categoryName, resultCategory, @"Category names do not much");
//}
//
//- (void)testShouldGetRecipes {
//  Recipe *newRecipe = [_repository insertRecipe];
//  newRecipe.name = @"test recipe";
//  [_repository save];
//  
//  NSArray *result = [_repository recipes];
//  STAssertTrue([result count] > 0, @"No Recipes found");
//}

@end
