//
//  IngredientViewModel.m
//  RecipeKing
//
//  Created by Lee Irvine on 2/5/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import "IngredientViewModel.h"

@implementation IngredientViewModel
@synthesize name;
@synthesize quantity;

- (void) dealloc {
  [name release];
  [quantity release];
  [super dealloc];
}

@end
