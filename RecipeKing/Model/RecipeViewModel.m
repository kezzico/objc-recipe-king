//
//  RecipeViewModel.m
//  RecipeKing
//
//  Created by Lee Irvine on 8/4/12.
//  Copyright (c) 2012 leescode. All rights reserved.
//

#import "RecipeViewModel.h"

@implementation RecipeViewModel
@synthesize recipeId;
@synthesize name;
@synthesize category;
@synthesize cookTemperature;
@synthesize preperation;
@synthesize preperationTime;
@synthesize cookTime;
@synthesize sitTime;
@synthesize servings;
@synthesize image;
@synthesize ingredients;

- (void) dealloc {
  [recipeId release];
  [name release];
  [category release];
  [cookTemperature release];
  [preperation release];
  [image release];
  [ingredients release];
  [super dealloc];
}
@end
