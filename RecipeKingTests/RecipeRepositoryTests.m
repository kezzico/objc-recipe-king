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
  [RecipeRepositoryTests deleteRecipeFiles];
}

+ (void) deleteRecipeFiles {
  NSURL *documentsDirectory = [[[NSFileManager defaultManager] URLsForDirectory: NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
  NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtURL:documentsDirectory includingPropertiesForKeys:nil options:0 error:nil];
  
  for (NSURL *file in files) {
    [[NSFileManager defaultManager] removeItemAtURL:file error: nil];
  }
}

- (void)setUp {
  _repository = [[RecipeRepository alloc] init];
  _categoryRepository = [[CategoryRepository alloc] init];
}

- (void)tearDown {
  [_repository release];
  [_categoryRepository release];
}

- (void) testNewRecipesAreSavedToDocuments {
  [_repository recipeWithName:@"pie"];
  [_repository recipeWithName:@"cake"];
  
  [_repository sync];
  
  NSString *piePath = [[_repository urlForRecipeName:@"pie"] path];
  NSString *cakePath = [[_repository urlForRecipeName:@"cake"] path];
  
  STAssertTrue([[NSFileManager defaultManager] fileExistsAtPath: piePath], nil);
  STAssertTrue([[NSFileManager defaultManager] fileExistsAtPath: cakePath], nil);
}

//- (void) testShouldGetEmptyRecipe {
//  Recipe *newRecipe = [_repository recipeWithName:@"myrecipe"];
//  STAssertTrue(newRecipe != nil, @"No recipe created");
//}
//
//- (void) testShouldSaveRecipe {
//  Recipe *newRecipe = [_repository recipeWithName:@"myrecipe"];
//  newRecipe.name = @"Test Recipe";
//  newRecipe.preparationTime = [NSNumber numberWithInt:300];
//  newRecipe.preparation = @"Test it";
//  [_repository save];
//  
//  Recipe *result = [_repository recipeWithName:@"myrecipe"];
//  STAssertEqualObjects(newRecipe.name, result.name, @"names do not match");
//  STAssertEqualObjects(newRecipe.preparation, result.preparation, @"instructions do not match");
//}
//
//- (void) testShouldSaveRecipeWithCategory {
//  NSString *categoryName = @"Recipe Test Category";
//  [_categoryRepository add: categoryName];  
//  Recipe *newRecipe = [_repository recipeWithName:@"myrecipe"];
//  
//  [_categoryRepository setCategory: categoryName forRecipe: newRecipe];
//  [_repository save];
//  
//  Recipe *result = [_repository recipeWithName:@"myrecipe"];
//  NSString *resultCategory = result.category.name;
//  STAssertEqualObjects(categoryName, resultCategory, @"Category names do not much");
//  
//  [_categoryRepository setCategory: nil forRecipe: newRecipe];
//  [_repository save];
//  
//  result = [_repository recipeWithName:@"myrecipe"];
//  STAssertNil(result.category, @"should be nil");
//}
//
//- (void)testShouldGetRecipes {
//  Recipe *newRecipe = [_repository recipeWithName:@"myrecipe"];
//  newRecipe.name = @"test recipe";
//  [_repository save];
//  
//  NSArray *result = [_repository recipesGroupedByCategory];
//  STAssertTrue([result count] > 0, @"No Recipes found");
//}

@end
