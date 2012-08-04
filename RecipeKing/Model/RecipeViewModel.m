//
//  RecipeViewModel.m
//  RecipeKing
//
//  Created by Lee Irvine on 2/5/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import "RecipeViewModel.h"
#import "IngredientViewModel.h"

@implementation RecipeViewModel
@synthesize recipeId;
@synthesize name;
@synthesize category;
@synthesize cookTime;
@synthesize cookTemperature;
@synthesize preperation;
@synthesize image;
@synthesize image_tn;
@synthesize ingredients;
@synthesize preperationTime;
@synthesize sitTime;
@synthesize servings;

- (id) init {
  if(self = [super init]) {
    self.ingredients = [[[NSMutableArray alloc] init] autorelease];
  }
  return self;
}

- (void) dealloc {
  [recipeId release];
  [name release];
  [category release];
  [sitTime release];
  [preperationTime release];
  [cookTime release];
  [cookTemperature release];
  [preperation release];
  [image release];
  [image_tn release];
  [ingredients release];
  [super dealloc];
}

@end
