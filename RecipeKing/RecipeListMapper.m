//
//  RecipeListMapper.m
//  RecipeKing
//
//  Created by Lee Irvine on 2/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RecipeListMapper.h"
#import "Recipe.h"
#import "ListRecipe.h"

@implementation RecipeListMapper

- (NSArray *) recipeListToViewModel: (NSArray *) recipes {
  NSMutableArray *output = [[NSMutableArray alloc] initWithCapacity: [recipes count] + 5];
  NSString *lastCategory = nil;
  for(Recipe *r in recipes) {
    if(lastCategory != [r.category name]) {
      lastCategory = [r.category name];
      [output addObject: lastCategory];
    }
    
    ListRecipe *rl = [[ListRecipe alloc] init];
    [output addObject: rl];
    
    rl.name = r.name;
    rl.cookTime = r.cookTime;
    rl.recipeId = r.objectID;
  }
  
  return [output autorelease];
}

@end
