//
//  MapperTests.h
//  RecipeKing
//
//  Created by Lee Irvine on 2/19/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
@class RecipeRepository;
@class RecipeListMapper;
@class RecipeMapper;

@interface RecipeMapperTests : SenTestCase {
  RecipeRepository *_recipeRepository;
  RecipeListMapper *_listMapper;
  RecipeMapper *_recipeMapper;
}
@end
