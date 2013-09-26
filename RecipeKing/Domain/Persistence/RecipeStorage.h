//
//  RecipeStorage.h
//  RecipeKing
//
//  Created by Lee Irvine on 9/13/13.
//  Copyright (c) 2013 Lee Irvine. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Recipe;
@protocol RecipeStorage <NSObject>
@required
- (void) digestChanges: (NSArray *) changes;
- (void) saveRecipe: (Recipe *) recipe;
- (void) deleteRecipe: (Recipe *) recipe;
- (NSArray *) recipes;
@end
