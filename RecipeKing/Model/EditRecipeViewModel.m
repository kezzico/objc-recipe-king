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

- (void) dealloc {
  [_name release];
  [_category release];
  [_preparation release];
  [_photo release];
  [_ingredients release];
  [super dealloc];
}

- (id) init {
  if(self = [super init]) {
    self.ingredients = [NSMutableArray array];
  }
  return self;
}

@end
