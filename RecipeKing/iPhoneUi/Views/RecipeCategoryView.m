//
//  RecipeCategoryView.m
//  RecipeKing
//
//  Created by Lee Irvine on 8/4/12.
//  Copyright (c) 2012 leescode. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "RecipeCategoryView.h"

@implementation RecipeCategoryView
@synthesize nameLabel;

- (id) initWithCoder:(NSCoder *)aDecoder {
  if(self = [super initWithCoder:aDecoder]) {
    self.layer.cornerRadius = 8.f;
    self.backgroundColor = [UIColor colorWithRed:1.0f green:0.54 blue:0 alpha:1.0f];
  }
  return self;
}

@end
