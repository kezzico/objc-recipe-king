//
//  RecipeRepository.m
//  RecipeKing
//
//  Created by Lee Irvine on 2/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ManagedContextFactory.h"
#import "RecipeRepository.h"
#import "Recipe.h"

@implementation RecipeRepository

- (id) init {
  if((self = [super init])) {
    _context = [[ManagedContextFactory buildContext] retain];
    _entityName = @"Recipe";
  }
  
  return self;
}

- (void) dealloc {
  [_context release];
  [super dealloc];
}

- (NSArray *) list {
  return [self filter: nil];
}

- (NSArray *) filter: (NSString *) search {
  NSError *error = nil;
  NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
  NSEntityDescription *entity = [NSEntityDescription entityForName:_entityName inManagedObjectContext: _context];
  [fetchRequest setEntity:entity];
  
  if([search length] > 0) {
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"name contains[c] %@", search];
    [fetchRequest setPredicate:predicate];
  }
  
  NSSortDescriptor *orderByCategory = [[NSSortDescriptor alloc] initWithKey:@"category.name" ascending:YES];
  NSSortDescriptor *orderByName = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
  [fetchRequest setSortDescriptors: [NSArray arrayWithObjects: orderByCategory, orderByName, nil]];
  [orderByCategory release];
  [orderByName release];
  
  NSArray *output = [_context executeFetchRequest:fetchRequest error: &error];
  [fetchRequest release];
  
  return output;
}

- (void) save: (Recipe *) recipe {
  NSError *error = nil;
  [_context save: &error];
  if(error) NSLog(@"%@", error);
}

- (void) remove: (NSManagedObjectID *) recipeId {
  NSError *error = nil;  
  [_context deleteObject: [_context objectWithID: recipeId]];
  [_context save: &error];
  if(error) NSLog(@"%@", error);
}

- (Recipe *) recipeWithId: (NSManagedObjectID *) recipeId {
  return (Recipe *)[_context objectWithID: recipeId];
}

- (Recipe *) newRecipe {
  Recipe *recipe = [NSEntityDescription
    insertNewObjectForEntityForName: _entityName
    inManagedObjectContext: _context];
  return recipe;
}

@end
