//
//  RecipeSerializerTests.h
//  RecipeKing
//
//  Created by Lee Irvine on 11/11/12.
//  Copyright (c) 2012 leescode. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
@class RecipeRepository;
@class RecipeSerializer;
@interface RecipeSerializerTests : SenTestCase {
  RecipeRepository *_repository;
  RecipeSerializer *_serializer;
}

@end
