//
//  RecipeMapper.h
//  RecipeKing
//
//  Created by Lee Irvine on 2/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PIngredientRepository.h"
#import "PCategoryRepository.h"

@class Recipe;
@class RecipeViewModel;
@interface RecipeMapper : NSObject

- (void) recipe: (Recipe *) r toViewModel: (RecipeViewModel *) v;
- (void) json: (NSDictionary *) data toViewModel: (RecipeViewModel *) v;
- (void) viewModel: (RecipeViewModel *) v toRecipe: (Recipe *) r;
- (NSDictionary *) viewModelToJson: (RecipeViewModel *) v;

@property (nonatomic, retain) NSObject<PIngredientRepository> *ingredientRepository;
@property (nonatomic, retain) NSObject<PCategoryRepository> *categoryRepository;

@end
