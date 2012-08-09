//
//  ListRecipe.m
//  RecipeKing
//
//  Created by Lee Irvine on 2/19/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import "ListRecipe.h"

@implementation ListRecipe
@synthesize recipeId;
@synthesize name;
@synthesize preparationTime;

- (void) dealloc {
  [recipeId release];
  [name release];
  [super dealloc];
}

- (NSString *) description {
  return self.name;
}

@end
