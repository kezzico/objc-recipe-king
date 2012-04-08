//
//  ListRecipe.m
//  RecipeKing
//
//  Created by Lee Irvine on 2/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ListRecipe.h"

@implementation ListRecipe
@synthesize recipeId;
@synthesize name;
@synthesize cookTime;

- (void) dealloc {
  [recipeId release];
  [name release];
  [cookTime release];
  [super dealloc];
}

@end
