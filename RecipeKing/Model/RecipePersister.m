//
//  PersistentStore.m
//  RecipeKing
//
//  Created by Lee Irvine on 9/12/12.
//  Copyright (c) 2012 leescode. All rights reserved.
//
#import "NSArray-Extensions.h"
#import "RecipePersister.h"
#import "Ingredient.h"
#import "Recipe.h"

id valueOrNull(id value);
id valueOrNil(id value);
@implementation RecipePersister

- (NSString *) generateUid {
  CFUUIDRef uuidRef = CFUUIDCreate(NULL);
  CFStringRef uuidStringRef = CFUUIDCreateString(NULL, uuidRef);
  CFRelease(uuidRef);
  NSString *uid = [(NSString *)uuidStringRef autorelease];
  return [NSString stringWithFormat:@"%@.recipeking", uid];
}

- (NSString *) recipesDirectory {
  NSURL *documents = [[[NSFileManager defaultManager] URLsForDirectory: NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
  NSString *path = [NSString pathWithComponents:@[[documents path], @"cookbook", @"recipes"]];
  if ([[NSFileManager defaultManager] fileExistsAtPath:path] == NO) {
    [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error: nil];
  }
  return path;
}

- (void) saveRecipe:(Recipe *) recipe {
  if(recipe.recipeId == nil) {
    recipe.recipeId = [self generateUid];
  }
  
  NSDictionary *jrecipe = [self recipeToJson:recipe];
  NSData *data = [NSJSONSerialization dataWithJSONObject:jrecipe options:NSJSONWritingPrettyPrinted error:nil];
  NSString *path = [NSString pathWithComponents:@[self.recipesDirectory, recipe.recipeId]];
  [data writeToFile:path atomically:YES];
}

- (NSArray *) loadRecipes {
  NSArray *recipeFiles = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:self.recipesDirectory error:nil];
  return [recipeFiles mapObjects:^(NSString *recipeId) {
    NSString *path = [NSString pathWithComponents:@[self.recipesDirectory, recipeId]];
    NSData *data = [NSData dataWithContentsOfFile: path];
    if(data == nil) return (Recipe *)nil;
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error: nil];
    Recipe *recipe = [self jsonToRecipe: json];
    recipe.recipeId = recipeId;
    return recipe;
  }];
}


- (NSDictionary *) recipeToJson: (Recipe *) recipe {
  return @{
    @"name" : valueOrNull(recipe.name),
    @"preptime": valueOrNull(recipe.preparationTime),
    @"category": valueOrNull(recipe.category),
    @"servings": valueOrNull(recipe.servings),
    @"preparation": valueOrNull(recipe.preparation),
    @"photo": valueOrNull(recipe.photo),
    @"ingredients": valueOrNull([recipe.ingredients mapObjects:^(Ingredient *ingredient) {
      return @{
        @"name" : valueOrNull(ingredient.name),
        @"quantity": valueOrNull(ingredient.quantity)
      };
    }])
  };
}

- (Recipe *) jsonToRecipe: (NSDictionary *) jrecipe {
  if(jrecipe == nil) return nil;
  
  Recipe *recipe = [[[Recipe alloc] init] autorelease];
  recipe.name = valueOrNil(jrecipe[@"name"]);
  recipe.preparationTime = valueOrNil(jrecipe[@"preptime"]);
  recipe.category = valueOrNil(jrecipe[@"category"]);
  recipe.servings = valueOrNil(jrecipe[@"servings"]);
  recipe.preparation = valueOrNil(jrecipe[@"preparation"]);
  recipe.photo = valueOrNil(jrecipe[@"photo"]);
  
  recipe.ingredients = [valueOrNil(jrecipe[@"ingredients"]) mapObjects:^(NSDictionary *jingredient) {
    Ingredient *ingredient = [[[Ingredient alloc] init] autorelease];
    ingredient = valueOrNil(jingredient[@"name"]);
    ingredient = valueOrNil(jingredient[@"quantity"]);
    return ingredient;
  }];
  
  return recipe;
}

@end

id valueOrNil(id value) {
  if(value == [NSNull null]) return nil;
  return value;
}

id valueOrNull(id value) {
  if(value == nil) return [NSNull null];
  return value;
}

