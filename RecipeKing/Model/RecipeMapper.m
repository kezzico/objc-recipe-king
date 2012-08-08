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
#import "UIImage+Extensions.h"

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
  v.photo = [UIImage imageWithData: r.photo];
  v.preperation = r.preperation;
  v.recipeId = r.objectID;
  
  v.servings = [r.servings integerValue];
  v.preperationTime = [r.preperationTime integerValue];

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
  r.preperation = v.preperation;
  
  r.preperationTime = [NSNumber numberWithInteger: v.preperationTime];
  r.servings = [NSNumber numberWithInteger: v.servings];
  r.photo = UIImagePNGRepresentation(v.photo);
  if([NSString isEmpty:v.category] == NO) {
    [categoryRepository setCategory: v.category forRecipe:r];
  }
  
  for(Ingredient *ig in r.ingredients) {
    [r.managedObjectContext deleteObject:ig];
  }
  
  for(IngredientViewModel *iv in v.ingredients) {
    if([NSString isEmpty:iv.name]) continue;
    [r addIngredientWithName:iv.name quantity:iv.quantity];
  }
}

- (RecipeViewModel *) viewModelFromRecipe: (Recipe *) r {
  RecipeViewModel *v = [[[RecipeViewModel alloc] init] autorelease];
  v.name = r.name;
  v.category = r.category.name;
  v.preperation = r.preperation;
  v.recipeId = r.objectID;
  
  v.preperationTime = [r.preperationTime integerValue];
  v.servings = [r.servings integerValue];

  v.photo = [UIImage imageWithData:r.photo];
  v.photoThumbnail = [v.photo imageByScalingAndCroppingForSize: CGSizeMake(60, 60)];
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
