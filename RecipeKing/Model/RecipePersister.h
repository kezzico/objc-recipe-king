//
//  PersistentStore.h
//  RecipeKing
//
//  Created by Lee Irvine on 9/12/12.
//  Copyright (c) 2012 leescode. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Recipe;
@interface RecipePersister : NSObject
- (NSString *) generateUid;
- (NSString *) recipesDirectory;
- (NSArray *) loadRecipes;
- (void) saveRecipe:(Recipe *) recipe;
@end
