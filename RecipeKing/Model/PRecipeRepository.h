//
//  PRecipeRepository.h
//  RecipeKing
//
//  Created by Lee Irvine on 2/4/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Recipe;
@protocol PRecipeRepository <NSObject>
- (NSArray *) recipes;
- (NSArray *) filter: (NSString *) search;
- (void) saveRecipe:(Recipe *) recipe;
- (void) deleteRecipe:(NSString *) recipeId;
- (Recipe *) recipeWithId: (NSString *) recipeId;
@end
