//
//  RecipeRepository.m
//  RecipeKing
//
//  Created by Lee Irvine on 2/17/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import "RecipeRepository.h"
#import "NSString-Extensions.h"
#import "NSArray-Extensions.h"
#import "RecipePersister.h"
#import "Ingredient.h"
#import "Recipe.h"

@implementation RecipeRepository

- (id) init {
  if(self = [super init]) {
    self.persister = [[[RecipePersister alloc] init] autorelease];
  }
  
  return self;
}

- (NSArray *) recipes {
  return [self filter: nil];
}

- (NSArray *) filter: (NSString *) search {
  NSArray *output = [NSArray arrayWithArray: self.trackedRecipes];
  if([NSString isEmpty: search] == NO) {
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"name contains[c] %@", search];
    output = [output filteredArrayUsingPredicate:predicate];
  }
  NSSortDescriptor *orderByCategory = [[[NSSortDescriptor alloc] initWithKey:@"category.name" ascending:YES selector:@selector(caseInsensitiveCompare:)] autorelease];
  NSSortDescriptor *orderByName = [[[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES selector:@selector(caseInsensitiveCompare:)] autorelease];
  
  return [output sortedArrayUsingDescriptors:@[orderByCategory, orderByName]];
}

- (void) saveRecipe:(Recipe *) recipe {
  [self.trackedRecipes addObject: recipe];
  [self.persister saveRecipe: recipe];
}

- (void) deleteRecipe:(NSString *) recipeId {
  Recipe *recipe = [self recipeWithId: recipeId];
  [self.trackedRecipes removeObject: recipe];
}

- (Recipe *) recipeWithId: (NSString *) recipeId {
  NSPredicate *predicate = [NSPredicate predicateWithFormat: @"recipeId = %@", recipeId];
  Recipe *recipe = [[self.trackedRecipes filteredArrayUsingPredicate:predicate] firstObject];
  return recipe;
}

- (NSArray *) trackedRecipes {
  if(_trackedRecipes == nil /* or it's expired */) {
    [_trackedRecipes release];
    _trackedRecipes = [[[self.persister loadRecipes] mutableCopy] retain];
  }
  
  return _trackedRecipes;
}

@end
