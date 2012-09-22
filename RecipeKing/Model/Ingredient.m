//
//  Ingredient.m
//  RecipeKing
//
//  Created by Lee Irvine on 2/17/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import "Ingredient.h"
#import "Recipe.h"

@implementation Ingredient

+ (Ingredient *) ingredientWithName:(NSString *) name quantity:(NSString *) quantity {
  Ingredient *ingredient = [[[Ingredient alloc] init] autorelease];
  ingredient.name = name;
  ingredient.quantity = quantity;
  return ingredient;
}

@end
