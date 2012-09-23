//
//  recipeRepositoryTests.m
//  RecipeKing
//
//  Created by Lee Irvine on 2/17/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//
#import "ManagedContextFactory.h"
#import "RecipeRepositoryTests.h"
#import "RecipeRepository.h"
#import "CategoryRepository.h"
#import "Recipe.h"
#import "RecipeCategory.h"

@implementation RecipeRepositoryTests

+ (void) setUp {
  [ManagedContextFactory resetStoreCoordinator];
}

- (void)setUp {
  _repository = [[RecipeRepository alloc] init];
  _categoryRepository = [[CategoryRepository alloc] init];
}

- (void)tearDown {
  [_repository release];
  [_categoryRepository release];
}

- (void) testShouldGetEmptyRecipe {
  Recipe *newRecipe = [_repository newRecipe];
  STAssertTrue(newRecipe != nil, @"No recipe created");
}

- (void) testShouldSaveRecipe {
  Recipe *newRecipe = [_repository newRecipe];
  newRecipe.name = @"Test Recipe";
  newRecipe.preparationTime = [NSNumber numberWithInt:300];
  newRecipe.preparation = @"Test it";
  [_repository save];
  
  Recipe *result = [_repository recipeWithId: newRecipe.objectID];
  STAssertEqualObjects(newRecipe.name, result.name, @"names do not match");
  STAssertEqualObjects(newRecipe.preparation, result.preparation, @"instructions do not match");
}

- (void) testShouldSaveRecipeWithCategory {
  NSString *categoryName = @"Recipe Test Category";
  [_categoryRepository add: categoryName];  
  Recipe *newRecipe = [_repository newRecipe];  
  
  [_categoryRepository setCategory: categoryName forRecipe: newRecipe];
  [_repository save];
  
  Recipe *result = [_repository recipeWithId: newRecipe.objectID];
  NSString *resultCategory = result.category.name;
  STAssertEqualObjects(categoryName, resultCategory, @"Category names do not much");
  
  [_categoryRepository setCategory: nil forRecipe: newRecipe];
  [_repository save];
  
  result = [_repository recipeWithId: newRecipe.objectID];
  STAssertNil(result.category, @"should be nil");
}

- (void)testShouldGetRecipes {
  Recipe *newRecipe = [_repository newRecipe];
  newRecipe.name = @"test recipe";
  [_repository save];
  
  NSArray *result = [_repository allRecipes];
  STAssertTrue([result count] > 0, @"No Recipes found");
}

@end
