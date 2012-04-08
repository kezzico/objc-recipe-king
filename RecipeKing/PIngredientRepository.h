//
//  PIngredientRepository.h
//  RecipeKing
//
//  Created by Lee Irvine on 2/19/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Recipe;
@class Ingredient;
@protocol PIngredientRepository <NSObject>
- (Ingredient *) addIngredientToRecipe: (Recipe *) recipe;
- (void) deleteIngredientsFromRecipe: (Recipe *) recipe;
@end
