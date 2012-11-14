//
//  RecipeRepository.m
//  RecipeKing
//
//  Created by Lee Irvine on 2/17/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import "ManagedContextFactory.h"
#import "RecipeRepository.h"
#import "Recipe.h"
#import "NSString-Extensions.h"
#import "NSArray-Extensions.h"
#import "RecipeSerializer.h"

@implementation RecipeRepository

- (NSArray *) recipeNames {
  NSArray *recipes = [self entitiesNamed:@"Recipe" sortWith:nil];
  return [recipes mapObjects:^(Recipe *recipe) {
    return recipe.name;
  }];
}

- (NSArray *) recipesGroupedByCategory {
  NSArray *sortDescriptors = @[
    [NSSortDescriptor sortDescriptorWithKey:@"category.name" ascending:YES selector:@selector(caseInsensitiveCompare:)],
    [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES selector:@selector(caseInsensitiveCompare:)]
  ];
  
  return [self entitiesNamed:@"Recipe" matching:nil sortWith: sortDescriptors];
}

- (NSArray *) filter: (NSString *) filter {
  NSArray *sortDescriptors = @[
    [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES selector:@selector(caseInsensitiveCompare:)]
  ];
  
  NSPredicate *predicate = nil;
  if([NSString isEmpty: filter] == NO) {
    predicate = [NSPredicate predicateWithFormat: @"name contains[c] %@ or category.name contains[c] %@", filter, filter];
  }
  
  return [self entitiesNamed:@"Recipe" matching:predicate sortWith: sortDescriptors];
}

- (Recipe *) recipeWithName:(NSString *) name {
  if(name == nil) return nil;
  Recipe *recipe = (Recipe *)[self firstEntityNamed:@"Recipe" withAttribute:@"name" equalTo:name];
  if(recipe == nil) {
    recipe = (Recipe *)[self insertEntityWithName:@"Recipe"];
    recipe.name = name;
  }
  
  return recipe;
}

- (void) remove: (Recipe *) recipe {
  NSURL *recipeUrl = [self urlForRecipeName:recipe.name];
  [[NSFileManager defaultManager] removeItemAtURL:recipeUrl error:nil];
  [self removeEntity: recipe];
}

- (void) sync {
  NSArray *allRecipes = [self entitiesNamed:@"Recipe" matching:nil sortWith:nil];

  // find all recipe files without a matching recipe and persist them locally
  for (NSURL *recipePath in [self allRecipeUrlsInDocumentsDirectory]) {
    NSString *recipeName = [[recipePath lastPathComponent] stringByDeletingPathExtension];
    if([self recipeWithNameExists: recipeName] == YES) continue;
    Recipe *recipe = [self recipeWithName:recipeName];
    [self loadRecipeFromFile:recipe];
  }
  
  // sync all local and remote changes
  for(Recipe *recipe in allRecipes) {
    if(recipe.lastEdit == nil || [self wasRecipeModifiedLocally: recipe]) {
      recipe.lastEdit = [NSDate date];
      [self saveRecipeToFile: recipe];
    } else if([self wasRecipeModifiedRemotely: recipe]) {
      [self loadRecipeFromFile: recipe];
      recipe.lastEdit = [NSDate date];
    } else if([self wasRecipeRemovedRemotely: recipe]) {
      [self removeEntity: recipe];
    }
  }
  
  [self save];
  [[NSNotificationCenter defaultCenter] postNotificationName:@"recipes synced" object:nil userInfo: nil];
}

- (NSArray *) allRecipeUrlsInDocumentsDirectory {
  NSURL *documentsDirectory = [[[NSFileManager defaultManager] URLsForDirectory: NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
  NSArray *urls = [[NSFileManager defaultManager] contentsOfDirectoryAtURL:documentsDirectory includingPropertiesForKeys:nil options:0 error:nil];
  urls = [urls filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"pathExtension = %@", @"recipeking"]];

  return urls;
}

- (BOOL) recipeWithNameExists: (NSString *) name {
  return [self firstEntityNamed:@"Recipe" withAttribute:@"name" equalTo: name] != nil;
}

- (void) saveRecipeToFile:(Recipe *) recipe {
  RecipeSerializer *serializer = [RecipeSerializer serializer];
  NSData *recipeJson = [serializer serialize: recipe];
  NSURL *recipeUrl = [self urlForRecipeName: recipe.name];
  [recipeJson writeToURL:recipeUrl atomically:YES];
}

- (BOOL) wasRecipeModifiedRemotely: (Recipe *) recipe {
  NSURL *recipeUrl = [self urlForRecipeName: recipe.name];
  NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfItemAtPath: [recipeUrl path] error:nil];
  NSDate *localLastEdit = recipe.lastEdit;
  NSDate *remoteLastEdit = [attributes fileModificationDate];

  return [remoteLastEdit compare: localLastEdit] == NSOrderedDescending;
}

- (BOOL) wasRecipeModifiedLocally: (Recipe *) recipe {
  if([self.context.updatedObjects containsObject: recipe]) return YES;
  if([self.context.insertedObjects containsObject: recipe]) return YES;
  return NO;
}

- (BOOL) wasRecipeRemovedRemotely: (Recipe *) recipe {
  NSString *path = [[self urlForRecipeName:recipe.name] path];
  return [[NSFileManager defaultManager] fileExistsAtPath: path] == NO;
}

- (void) loadRecipeFromFile: (Recipe *) recipe {
  NSURL *recipeUrl = [self urlForRecipeName:recipe.name];
  NSData *json = [NSData dataWithContentsOfURL:recipeUrl];

  RecipeSerializer *serializer = [RecipeSerializer serializer];
  [serializer restore:json];
}

- (NSURL *) urlForRecipeName:(NSString *) name {
  NSURL *docs = [[[NSFileManager defaultManager] URLsForDirectory: NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
  NSURL *recipeUrl = [docs URLByAppendingPathComponent: [name stringByAppendingString:@".recipeking"]];
  return recipeUrl;
}

@end
