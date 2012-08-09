//
//  RecipeViewModel.m
//  RecipeKing
//
//  Created by Lee Irvine on 2/5/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import "EditRecipeViewModel.h"
#import "IngredientViewModel.h"

@implementation EditRecipeViewModel
@synthesize recipeId;
@synthesize name;
@synthesize category;
@synthesize preparation;
@synthesize photo;
@synthesize ingredients;
@synthesize preparationTime;
@synthesize servings;

- (void) dealloc {
  [recipeId release];
  [name release];
  [category release];
  [preparation release];
  [photo release];
  [ingredients release];
  [super dealloc];
}

- (id) init {
  if(self = [super init]) {
    self.ingredients = [[[NSMutableArray alloc] init] autorelease];
  }
  return self;
}

@end
