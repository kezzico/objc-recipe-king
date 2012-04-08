//
//  MapperTests.m
//  RecipeKing
//
//  Created by Lee Irvine on 2/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MapperTests.h"
#import "Recipe.h"
#import "Category.h"
#import "RecipeListMapper.h"
#import "RecipeRepository.h"
#import "CategoryRepository.h"

@implementation MapperTests

- (void)setUp
{
  [super setUp];
  RecipeRepository *rrepository = [[RecipeRepository alloc] init];
  CategoryRepository *crepository = [[CategoryRepository alloc] init];
  
  NSMutableArray *recipes = [[NSMutableArray alloc] init];
  Recipe *recipe1 = [rrepository newRecipe]; [recipes addObject: recipe1];
  Recipe *recipe2 = [rrepository newRecipe]; [recipes addObject: recipe2];
  Recipe *recipe3 = [rrepository newRecipe]; [recipes addObject: recipe3];
  Recipe *recipe4 = [rrepository newRecipe]; [recipes addObject: recipe4];
  Recipe *recipe5 = [rrepository newRecipe]; [recipes addObject: recipe5];
  
  [crepository add: @"Fruit"];  
  [crepository add: @"Vegetable"];  
  
  [crepository setCategory: @"Fruit" forRecipe: recipe1];
  recipe1.name = @"Apple";
  [crepository setCategory: @"Fruit" forRecipe: recipe2];
  recipe2.name = @"Banana";
  [crepository setCategory: @"Fruit" forRecipe: recipe3];
  recipe3.name = @"Orange";
  [crepository setCategory: @"Vegetable" forRecipe: recipe4];
  recipe4.name = @"Broccoli";
  [crepository setCategory: @"Vegetable" forRecipe: recipe5];
  recipe5.name = @"Turnip";

  _data = [[NSArray alloc] initWithArray: recipes];
  
  [recipes release];
  [crepository release];
  [rrepository release];
}

- (void)tearDown
{
  [_data release];
  [super tearDown];
}


- (void) testShouldMapListOfRecipesToViewModels {
  RecipeListMapper *mapper = [[RecipeListMapper alloc] init];
  NSArray *result = [mapper recipeListToViewModel: _data];
  
  STAssertEqualObjects([result objectAtIndex: 0], @"Fruit", @"Did not map category to first cell");
  STAssertEqualObjects([[result objectAtIndex: 1] name], @"Apple", @"Did not map recipe to second cell");
  STAssertEqualObjects([result objectAtIndex: 4], @"Vegetable", @"Did not map category to fifth cell");
}

@end
