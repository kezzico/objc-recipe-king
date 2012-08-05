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

static NSString *recipeEntityName = @"Recipe";
@implementation RecipeRepository
@synthesize context;

- (void) dealloc {
  [context release];
  [super dealloc];
}

- (id) init {
  if((self = [super init])) {
    self.context = [ManagedContextFactory buildContext];
  }
  return self;
}

- (NSArray *) allRecipes {
  return [self filter: nil];
}

- (NSArray *) filter: (NSString *) search {
  NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
  NSEntityDescription *entity = [NSEntityDescription entityForName:recipeEntityName inManagedObjectContext: self.context];
  [fetchRequest setEntity:entity];
  
  if([NSString isEmpty: search] == NO) {
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"name contains[c] %@", search];
    [fetchRequest setPredicate:predicate];
  }
  
  NSSortDescriptor *orderByCategory = [[[NSSortDescriptor alloc] initWithKey:@"category.name" ascending:YES selector:@selector(caseInsensitiveCompare:)] autorelease];
  NSSortDescriptor *orderByName = [[[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES selector:@selector(caseInsensitiveCompare:)] autorelease];
  [fetchRequest setSortDescriptors: [NSArray arrayWithObjects: orderByCategory, orderByName, nil]];
  NSArray *output = [self.context executeFetchRequest:fetchRequest error: nil];
  
  return output;
}

- (void) save {
  NSError *error = nil;
  [self.context save: &error];
  if(error) NSLog(@"%@", error);
}

- (void) remove: (NSManagedObjectID *) recipeId {
  NSError *error = nil;  
  [self.context deleteObject: [self.context objectWithID: recipeId]];
  [self.context save: &error];
  if(error) NSLog(@"%@", error);
}

- (Recipe *) recipeWithId: (NSManagedObjectID *) recipeId {
  return (Recipe *)[self.context objectWithID: recipeId];
}

- (Recipe *) newRecipe {
  Recipe *recipe = [NSEntityDescription
    insertNewObjectForEntityForName: recipeEntityName
    inManagedObjectContext: self.context];
  return recipe;
}

@end
