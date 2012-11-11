//
//  RecipeViewModel.m
//  RecipeKing
//
//  Created by Lee Irvine on 8/4/12.
//  Copyright (c) 2012 leescode. All rights reserved.
//

#import "RecipeViewModel.h"

@implementation RecipeViewModel

- (void) dealloc {
  [_name release];
  [_category release];
  [_cookTemperature release];
  [_preparation release];
  [_photo release];
  [_photoThumbnail release];
  [_ingredients release];
  [super dealloc];
}

@end
