//
//  RecipeListMapper.m
//  RecipeKing
//
//  Created by Lee Irvine on 2/19/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import "RecipeListMapper.h"
#import "Recipe.h"
#import "ListRecipe.h"
#import "NSArray-Extensions.h"
#import "RecipeCategory.h"

@implementation RecipeListMapper

- (NSArray *) recipeListToViewModel: (NSArray *) recipes {
  NSMutableArray *output = [[[NSMutableArray alloc] init] autorelease];
  NSString *lastCategory = nil;
  
  for(Recipe *r in recipes) {
    NSString *categoryName = r.category.name;
    if(categoryName && categoryName != lastCategory) {
      lastCategory = r.category.name;
      [output addObject: lastCategory];
    }
    
    ListRecipe *rl = [[[ListRecipe alloc] init] autorelease];
    rl.name = r.name;
    rl.preparationTime = [r.preparationTime integerValue];
    
    [output addObject: rl];
  }
  
  return [NSArray arrayWithArray: output];
}

@end
