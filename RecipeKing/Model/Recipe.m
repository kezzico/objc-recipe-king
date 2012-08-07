//
//  Recipe.m
//  RecipeKing
//
//  Created by Lee Irvine on 2/17/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import "Recipe.h"
#import "RecipeCategory.h"
#import "Ingredient.h"


@implementation Recipe
@dynamic name;
@dynamic category;
@dynamic photo;
@dynamic preperation;
@dynamic ingredients;
@dynamic preperationTime;
@dynamic servings;

- (void) removeAllIngredients {
  [self removeIngredients: self.ingredients];
}

- (Ingredient *) ingredientAtIndex:(NSInteger) index {
  for(Ingredient *igt in self.ingredients) {
    if([igt.index integerValue] == index) return igt;
  }
  return nil;
}

- (void) addIngredientWithName:(NSString *) name quantity:(NSString *) quantity {
  Ingredient *ingredient = [NSEntityDescription
    insertNewObjectForEntityForName:@"Ingredient"
    inManagedObjectContext:self.managedObjectContext];
  
  ingredient.index = [NSNumber numberWithInt: [self.ingredients count]];
  ingredient.name = name;
  ingredient.quantity = quantity;
  [self addIngredientsObject:ingredient];
}

@end
