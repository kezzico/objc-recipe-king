//
//  CategoryRepositoryTests.m
//  RecipeKing
//
//  Created by Lee Irvine on 2/17/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import "CategoryRepositoryTests.h"
#import "CategoryRepository.h"

@implementation CategoryRepositoryTests

- (void)setUp
{
  [super setUp];
  _repository = [[CategoryRepository alloc] init];
}

- (void)tearDown
{
  [_repository release];
  [super tearDown];
}

- (void) testShouldAddCategory {
  NSString *expectedResult = @"testcategory";
  [_repository add: expectedResult];
  
  STAssertTrue([[_repository list] containsObject: expectedResult], @"test category not listed");  
}

- (void) testShouldListCategories {
  STAssertTrue([[_repository list] count] > 0, @"Could not list categories");  
}

- (void) testShouldRemoveCategory {
  [_repository remove: @"testcategory"];
  STAssertFalse([[_repository list] containsObject: @"testcategory"], @"test category not removed");
}

@end
