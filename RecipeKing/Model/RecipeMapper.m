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
#import "jsonHelper.h"

@implementation RecipeMapper

+ (RecipeMapper *) mapper {
  return [[[RecipeMapper alloc] init] autorelease];
}

- (void) dealloc {
  [_categoryRepository release];
  [_recipeRepository release];
  [super dealloc];
}

- (id) init {
  if(self = [super init]) {
    self.categoryRepository = [[Container shared] resolve:@protocol(PCategoryRepository)];
    self.recipeRepository = [[Container shared] resolve:@protocol(PRecipeRepository)];
  }
  return self;
}

- (EditRecipeViewModel *) editViewModelFromRecipe: (Recipe *) r {
  EditRecipeViewModel *v = [[[EditRecipeViewModel alloc] init] autorelease];
  v.name = r.name;
  v.oldName = r.name;
  
  v.category = [r.category name];
  v.photo = [UIImage imageWithData: r.photo];
  v.preparation = r.preparation;
  
  v.servings = [r.servings integerValue];
  v.preparationTime = [r.preparationTime integerValue];
  
  NSMutableArray *recipeNames = [[[self.recipeRepository recipeNames] mutableCopy] autorelease];
  [recipeNames removeObject:r.name];
  v.unavailableRecipeNames = [NSArray arrayWithArray: recipeNames];
  
  NSArray *ingredients = [self sortIngredientsToArray: r.ingredients];
  for(Ingredient *ingredient in ingredients) {
    IngredientViewModel *iv = [[[IngredientViewModel alloc] init] autorelease];
    iv.name = ingredient.name;
    iv.quantity = ingredient.quantity;
    [v.ingredients addObject:iv];
  }
  
  return v;
}

- (EditRecipeViewModel *) editRecipeViewModel {
  EditRecipeViewModel *v = [[[EditRecipeViewModel alloc] init] autorelease];
  v.unavailableRecipeNames = [self.recipeRepository recipeNames];
  return v;
}

- (NSArray *) sortIngredientsToArray:(NSSet *) ingredients {
  NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"index" ascending:YES];
  NSArray *sortDescriptors = [NSArray arrayWithObject: sortDescriptor];
  return [ingredients sortedArrayUsingDescriptors: sortDescriptors];
}

- (Recipe *) recipeFromEditViewModel: (EditRecipeViewModel *) v {
  Recipe *r = [self.recipeRepository recipeWithName:v.oldName == nil ? v.name : v.oldName];
  
  r.name = v.name;
  r.preparation = v.preparation;
  
  r.preparationTime = [NSNumber numberWithInteger: v.preparationTime];
  r.servings = [NSNumber numberWithInteger: v.servings];
  r.photo = UIImagePNGRepresentation(v.photo);
  [self.categoryRepository setCategory: v.category forRecipe:r];
  
  for(Ingredient *ig in r.ingredients) {
    [r.managedObjectContext deleteObject:ig];
  }
  
  for(IngredientViewModel *iv in v.ingredients) {
    if([NSString isEmpty:iv.name]) continue;
    [r addIngredientWithName:iv.name quantity:iv.quantity];
  }
  
  return r;
}

- (RecipeViewModel *) viewModelFromRecipe: (Recipe *) r {
  RecipeViewModel *v = [[[RecipeViewModel alloc] init] autorelease];
  v.name = r.name;
  v.category = r.category.name;
  v.preparation = r.preparation;
  
  v.preparationTime = [r.preparationTime integerValue];
  v.servings = [r.servings integerValue];
  v.photo = [UIImage imageWithData:r.photo];
  v.photoThumbnail = [v.photo imageByScalingAndCroppingForSize: CGSizeMake(60, 60)];
  v.widestQuantity = [self findWidestQuantity: r.ingredients];
  
  NSArray *ingredients = [self sortIngredientsToArray: r.ingredients];
  v.ingredients = [ingredients mapObjectsMutable:^(Ingredient *ingredient) {
    IngredientViewModel *iv = [[[IngredientViewModel alloc] init] autorelease];
    iv.name = ingredient.name;
    iv.quantity = ingredient.quantity;
    return iv;
  }];
  
  return v;
}

- (NSString *) recipeToText: (Recipe *) recipe {
  NSMutableString *recipeText = [NSMutableString string];
  
  if([recipe.ingredients count] > 0) {
    [recipeText appendFormat: @"%@\n", _L(@"SharedIngredients")];
    for(Ingredient *ingr in recipe.ingredients) {
      NSString *comma = [NSString isEmpty:ingr.quantity] == NO ? @", " : @"";
      NSString *qty = [NSString isEmpty:ingr.quantity] == NO ? ingr.quantity : @"";
      [recipeText appendFormat:@" - %@%@%@\n", qty, comma, ingr.name];
    }
  }
  
  if([NSString isEmpty: recipe.preparation] == NO) {
    if([NSString isEmpty: recipeText] == NO) [recipeText appendString:@"\n"];
    [recipeText appendString: _L(@"SharedPreparation")];
    
    if([recipe.preparationTime intValue] > 0) {
      [recipeText appendFormat:@" - %@", [NSString stringFromTime: [recipe.preparationTime intValue]]];
    }
    
    [recipeText appendFormat:@"\n%@", recipe.preparation];
  }
  
  return [NSString stringWithString: recipeText];
}

- (CGFloat) findWidestQuantity:(NSSet *) ingredients {
  CGFloat longest = 0.f;
  CGSize maxSize = CGSizeMake(200, 20);
  UIFont *font = [UIFont systemFontOfSize:13];
  UILineBreakMode lbm = UILineBreakModeClip;
  
  for(Ingredient *ig in ingredients) {
    CGFloat size = [[ig.quantity trim] sizeWithFont:font constrainedToSize:maxSize lineBreakMode:lbm].width;
    if(size > longest) longest = size;
  }
  return longest + 10.f;
}

@end
