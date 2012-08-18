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
@synthesize preparation;
@synthesize preparationTime;
@synthesize cookTime;
@synthesize sitTime;
@synthesize servings;
@synthesize photo;
@synthesize photoThumbnail;
@synthesize ingredients;

- (void) dealloc {
  [recipeId release];
  [name release];
  [category release];
  [cookTemperature release];
  [preparation release];
  [photo release];
  [photoThumbnail release];
  [ingredients release];
  [super dealloc];
}

@end
