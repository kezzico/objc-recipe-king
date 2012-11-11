//
//  RecipeSerializer.h
//  RecipeKing
//
//  Created by Lee Irvine on 11/10/12.
//  Copyright (c) 2012 leescode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PCategoryRepository.h"
#import "PRecipeRepository.h"

@class Recipe;
@interface RecipeSerializer : NSObject
+ (RecipeSerializer *) serializer;
- (NSData *) serialize: (Recipe *) recipe;
- (Recipe *) restore: (NSData *) data;
@property (nonatomic, retain) id<PCategoryRepository> categoryRepository;
@property (nonatomic, retain) id<PRecipeRepository> recipeRepository;

@end
