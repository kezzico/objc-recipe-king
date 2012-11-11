//
//  RecipeListViewModel.m
//  RecipeKing
//
//  Created by Lee Irvine on 8/4/12.
//  Copyright (c) 2012 leescode. All rights reserved.
//

#import "RecipeListViewModel.h"

@implementation RecipeListViewModel

- (void) dealloc {
  [_recipesAndCategories release];
  [super dealloc];
}
@end
