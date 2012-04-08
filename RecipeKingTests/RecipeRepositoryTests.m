//
//  recipeRepositoryTests.m
//  RecipeKing
//
//  Created by Lee Irvine on 2/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RecipeRepositoryTests.h"
#import "RecipeRepository.h"
#import "CategoryRepository.h"
#import "Recipe.h"

@implementation RecipeRepositoryTests

- (void)setUp
{
  [super setUp];
  _repository = [[RecipeRepository alloc] init];
  _categoryRepository = [[CategoryRepository alloc] init];
}

- (void)tearDown
{
  [_repository release];
  [_categoryRepository release];
  [super tearDown];
}

- (void) testShouldGetEmptyRecipe {
  Recipe *newRecipe = [_repository newRecipe];
  STAssertTrue(newRecipe != nil, @"No recipe created");
}

- (void) testShouldSaveRecipe {
  Recipe *newRecipe = [_repository newRecipe];
  newRecipe.name = @"Test Recipe";
  newRecipe.cookTime = @"2h 30m";
  newRecipe.cookTemperature = @"350";
  newRecipe.instructions = @"Test it";
  
  [_repository save: newRecipe];
  Recipe *result = [_repository recipeWithId: newRecipe.objectID];
  
  STAssertEqualObjects(newRecipe.name, result.name, @"names do not match");
  STAssertEqualObjects(newRecipe.cookTime, result.cookTime, @"cook times do not match");
  STAssertEqualObjects(newRecipe.cookTemperature, result.cookTemperature, @"cook temperatures do not match");
  STAssertEqualObjects(newRecipe.instructions, result.instructions, @"instructions do not match");
}

- (void) testShouldSaveRecipeWithCategory {
  NSString *categoryName = @"Recipe Test Category";
  [_categoryRepository add: categoryName];  
  Recipe *newRecipe = [_repository newRecipe];  
  
  [_categoryRepository setCategory: categoryName forRecipe: newRecipe];
  [_repository save: newRecipe];
  
  Recipe *result = [_repository recipeWithId: newRecipe.objectID];
  NSString *resultCategory = [result.category name];
  STAssertEqualObjects(categoryName, resultCategory, @"Category names do not much");
}

- (void)testShouldGetRecipes {
  NSArray *result = [_repository list];
  STAssertTrue([result count] > 0, @"No Recipes found");
}

@end
