//
//  PRecipeRepository.h
//  RecipeKing
//
//  Created by Lee Irvine on 2/4/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Recipe;
@protocol PRecipeRepository <NSObject>
@required
- (NSArray *) list;
- (NSArray *) filter: (NSString *) search;
- (void) save: (Recipe *) recipe;
- (void) remove: (NSManagedObjectID *) recipeId;
- (Recipe *) recipeWithId: (NSManagedObjectID *) recipeId;
- (Recipe *) newRecipe;
@end
