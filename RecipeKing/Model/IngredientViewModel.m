//
//  IngredientViewModel.m
//  RecipeKing
//
//  Created by Lee Irvine on 2/5/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import "IngredientViewModel.h"

@implementation IngredientViewModel

- (void) dealloc {
  [_name release];
  [_quantity release];
  [super dealloc];
}

@end
