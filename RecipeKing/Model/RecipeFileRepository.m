//
//  RecipeSerializer.m
//  RecipeKing
//
//  Created by Lee Irvine on 9/9/12.
//  Copyright (c) 2012 leescode. All rights reserved.
//

#import "RecipeFileRepository.h"
#import "Recipe.h"
#import "Ingredient.h"
#import "NSArray-Extensions.h"

@implementation RecipeFileRepository

- (void) save:(Recipe *) recipe {
  NSString *path = [self pathForRecipe: recipe];
  NSDictionary *recipeJson = [self convertRecipeToJson: recipe];
  NSData *data = [NSJSONSerialization dataWithJSONObject: recipeJson options:NSJSONWritingPrettyPrinted error:nil];
  [data writeToFile:path atomically:YES];
}

- (void) sync {
  
}

- (NSString *) pathForRecipe:(Recipe *) recipe {
  NSURL *documents = [[[NSFileManager defaultManager] URLsForDirectory: NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
  NSString *recipeFileName = recipe.name;
  return [[documents URLByAppendingPathComponent: recipeFileName] path];
}

- (NSDictionary *) convertRecipeToJson: (Recipe *) recipe {
  NSDictionary *output = @{
    @"name" : recipe.name,
    @"preptime": recipe.preparationTime,
    @"category": recipe.category,
    @"servings": recipe.servings,
    @"preparation": recipe.preparation,
    @"photo": recipe.photo,
    @"ingredients": [[recipe.ingredients allObjects] mapObjects:^(Ingredient *ingredient) {
      return @{
        @"name" : ingredient.name,
        @"quantity": ingredient.quantity,
        @"index": ingredient.index
      }; 
    }]
  };
  
  return output;
}

@end
