//
//  RecipeMapper.m
//  RecipeKing
//
//  Created by Lee Irvine on 2/19/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import "RecipeMapper.h"
#import "Recipe.h"
#import "EditRecipeViewModel.h"
#import "Ingredient.h"
#import "IngredientViewModel.h"
#import "NSArray-Extensions.h"
#import "RecipeViewModel.h"
#import "RecipeCategory.h"
#import "Container.h"
#import "NSString-Extensions.h"

@implementation RecipeMapper
@synthesize categoryRepository;

- (void) dealloc {
  [categoryRepository release];
  [super dealloc];
}

- (id) init {
  if(self = [super init]) {
    self.categoryRepository = [[Container shared] resolve:@protocol(PCategoryRepository)];
  }
  return self;
}

- (EditRecipeViewModel *) editViewModelFromRecipe: (Recipe *) r {
  EditRecipeViewModel *v = [[[EditRecipeViewModel alloc] init] autorelease];
  v.name = r.name;
  v.category = [r.category name];
  v.cookTemperature = r.cookTemperature;
  v.image = [UIImage imageWithData: r.image];
  v.preperation = r.preperation;
  
  v.servings = [r.servings integerValue];
  v.preperationTime = [r.preperationTime integerValue];
  v.sitTime = [r.sitTime integerValue];
  v.cookTime = [r.cookTime integerValue];

  NSArray *ingredients = [self sortIngredientsToArray: r.ingredients];
  for(Ingredient *ingredient in ingredients) {
    IngredientViewModel *iv = [[[IngredientViewModel alloc] init] autorelease];
    iv.name = ingredient.name;
    iv.quantity = ingredient.quantity;
    [v.ingredients addObject:iv];
  }
  
  return v;
}

- (NSArray *) sortIngredientsToArray:(NSSet *) ingredients {
  NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"index" ascending:YES];
  NSArray *sortDescriptors = [NSArray arrayWithObject: sortDescriptor];
  return [ingredients sortedArrayUsingDescriptors: sortDescriptors];
}

- (void) editViewModel: (EditRecipeViewModel *) v toRecipe: (Recipe *) r {
  r.name = v.name;
  r.cookTemperature = v.cookTemperature;
  r.preperation = v.preperation;
  
  r.preperationTime = [NSNumber numberWithInteger: v.preperationTime];
  r.cookTime = [NSNumber numberWithInteger: v.cookTime];
  r.sitTime = [NSNumber numberWithInteger: v.sitTime];
  r.servings = [NSNumber numberWithInteger: v.servings];
  r.image = UIImagePNGRepresentation(v.image);
  if([NSString isEmpty:v.category] == NO) {
    [categoryRepository setCategory: v.category forRecipe:r];
  }
  
  [r removeAllIngredients];
  for(IngredientViewModel *iv in v.ingredients) {
    [r addIngredientWithName:iv.name quantity:iv.quantity];
  }
}

- (RecipeViewModel *) viewModelFromRecipe: (Recipe *) r {
  RecipeViewModel *v = [[[RecipeViewModel alloc] init] autorelease];
  v.name = r.name;
  v.category = r.category.name;
  v.cookTemperature = r.cookTemperature;
  v.preperation = r.preperation;
  
  v.preperationTime = [r.preperationTime integerValue];
  v.cookTime = [r.cookTime integerValue];
  v.sitTime = [r.sitTime integerValue];
  v.servings = [r.servings integerValue];

  r.image = UIImagePNGRepresentation(v.image);
  NSArray *ingredients = [self sortIngredientsToArray: r.ingredients];
  v.ingredients = [ingredients mapObjectsMutable:^(Ingredient *ingredient) {
    IngredientViewModel *iv = [[[IngredientViewModel alloc] init] autorelease];
    iv.name = ingredient.name;
    iv.quantity = ingredient.quantity;
    return iv;
  }];
  
  return v;
}

@end
