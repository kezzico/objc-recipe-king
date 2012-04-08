//
//  RecipeListTests.h
//  RecipeKing
//
//  Created by Lee Irvine on 2/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "PRecipeRepository.h"
#import "PCategoryRepository.h"

@interface RecipeRepositoryTests : SenTestCase {
  NSObject<PRecipeRepository> *_repository;
  NSObject<PCategoryRepository> *_categoryRepository;
}

@end
