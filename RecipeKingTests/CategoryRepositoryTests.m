//
//  CategoryRepositoryTests.m
//  RecipeKing
//
//  Created by Lee Irvine on 2/17/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//
#import "ManagedContextFactory.h"
#import "CategoryRepositoryTests.h"
#import "CategoryRepository.h"

@implementation CategoryRepositoryTests

+ (void) setUp {
  [ManagedContextFactory resetStoreCoordinator];
}

- (void) setUp {
  _repository = [[CategoryRepository alloc] init];
}

- (void)tearDown {
  [_repository release];
  [super tearDown];
}

- (void) testShouldAddCategory {
  NSString *expectedResult = @"testcategory";
  [_repository add: expectedResult];
  NSArray *result =[_repository allCategories];
  STAssertTrue([result containsObject: expectedResult], @"test category not listed");
}

- (void) testShouldNotAddCategoryWithSameName {
  NSString *categoryName = @"testcategory";
  [_repository add: categoryName];
  NSArray *result = [_repository allCategories];
  STAssertTrue([result count] == 1, @"should be only 1");
}

- (void) testShouldRemoveCategory {
  [_repository remove: @"testcategory"];
  NSArray *result =[_repository allCategories];
  STAssertFalse([result containsObject: @"testcategory"], @"test category not removed");
}

@end
