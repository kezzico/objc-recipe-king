//
//  RecipeListTests.h
//  RecipeKing
//
//  Created by Lee Irvine on 2/5/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
@class CategoryRepository;
@class RecipeRepository;
@interface RecipeRepositoryTests : SenTestCase {
  RecipeRepository *_repository;
  CategoryRepository *_categoryRepository;
}
@end
