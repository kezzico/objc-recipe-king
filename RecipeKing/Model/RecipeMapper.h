//
//  RecipeMapper.h
//  RecipeKing
//
//  Created by Lee Irvine on 2/19/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PCategoryRepository.h"
#import "PRecipeRepository.h"

@class Recipe;
@class EditRecipeViewModel;
@class RecipeViewModel;
@interface RecipeMapper : NSObject

- (EditRecipeViewModel *) editViewModelFromRecipe: (Recipe *) r;
- (RecipeViewModel *) viewModelFromRecipe: (Recipe *) r;
- (Recipe *) recipeFromEditViewModel: (EditRecipeViewModel *) v;
- (EditRecipeViewModel *) editRecipeViewModel;
- (NSString *) recipeToText: (Recipe *) recipe;
+ (RecipeMapper *) mapper;

@property (nonatomic, retain) id<PCategoryRepository> categoryRepository;
@property (nonatomic, retain) id<PRecipeRepository> recipeRepository;

@end
