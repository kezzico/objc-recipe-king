//
//  RecipeSerializerTests.m
//  RecipeKing
//
//  Created by Lee Irvine on 11/11/12.
//  Copyright (c) 2012 leescode. All rights reserved.
//

#import "ManagedContextFactory.h"
#import "RecipeSerializerTests.h"
#import "RecipeSerializer.h"
#import "RecipeRepository.h"
#import "Recipe.h"
#import "RecipeCategory.h"

@implementation RecipeSerializerTests

+ (void) setUp {
  [ManagedContextFactory resetStoreCoordinator];
}

- (void)setUp {
  _repository = [[RecipeRepository alloc] init];
  _serializer = [[RecipeSerializer alloc] init];
}

- (void)tearDown {
  [_repository release];
  [_serializer release];
}

- (void) _testSerializing {
  Recipe *recipe = [_repository recipeWithName:@"pancake"];
  NSData *json = [_serializer serialize: recipe];
  
  NSDictionary *result = [NSJSONSerialization JSONObjectWithData:json options:0 error:nil];
  STAssertEqualObjects([result valueForKey:@"name"], @"pancake", nil);
}

- (void) _testRestoring {
  NSString *path = [TEST_DATA_PATH stringByAppendingPathComponent: @"recipe.json"];
  NSData *json = [NSData dataWithContentsOfFile: path];
  
  Recipe *result = [_serializer restore: json];
  STAssertEqualObjects(result.name, @"pancake", nil);
}

- (void) testIgnoringUnproperlyFormattedFile {
  NSString *path = [TEST_DATA_PATH stringByAppendingPathComponent: @"badrecipe.recipe"];
  NSData *json = [NSData dataWithContentsOfFile: path];
  STAssertNotNil(json, @"should atleast get some data");
  
  Recipe *result = [_serializer restore: json];
  STAssertNil(result, @"should be nil");
}

- (void) testIgnoringMalformedRecipe {
  NSString *path = [TEST_DATA_PATH stringByAppendingPathComponent: @"improper.recipe"];
  NSData *json = [NSData dataWithContentsOfFile: path];
  STAssertNotNil(json, @"should atleast get some data");
  
  Recipe *result = [_serializer restore: json];
  STAssertNil(result, @"should be nil");
  
}

@end
