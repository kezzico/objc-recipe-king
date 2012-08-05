//
//  RecipeMapper.h
//  RecipeKing
//
//  Created by Lee Irvine on 2/19/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PCategoryRepository.h"

@class Recipe;
@class EditRecipeViewModel;
@class RecipeViewModel;
@interface RecipeMapper : NSObject

- (EditRecipeViewModel *) editViewModelFromRecipe: (Recipe *) r;
- (RecipeViewModel *) viewModelFromRecipe: (Recipe *) r;
- (void) editViewModel: (EditRecipeViewModel *) v toRecipe: (Recipe *) r;

@property (nonatomic, retain) id<PCategoryRepository> categoryRepository;

@end
