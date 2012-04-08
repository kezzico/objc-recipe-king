//
//  SharedContext.m
//  RecipeKing
//
//  Created by Lee Irvine on 2/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ManagedContextFactory.h"

@interface ManagedContextFactory ()
- (void) setupObjectModel;
- (void) setupStoreCoordinator;
- (NSManagedObjectContext *) createObjectContext;
@end

static ManagedContextFactory *contextfactory;

@implementation ManagedContextFactory

+ (void) initialize {
  contextfactory = [[ManagedContextFactory alloc] init];
}

- (id) init {
  if((self = [super init])) {
    [self setupObjectModel];
    [self setupStoreCoordinator];
  }
  
  return self;
}

+ (NSManagedObjectContext *) buildContext {
  return [contextfactory createObjectContext];
}

- (void) setupObjectModel {
  NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"RecipeKing" withExtension:@"momd"];
  _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
}

- (void) setupStoreCoordinator {
  NSError *error = nil;
  NSURL *docsDir = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
  NSURL *storeURL = [docsDir URLByAppendingPathComponent: @"RecipeKing.sqlite"];
  _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: _managedObjectModel];
  [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];
}

- (NSManagedObjectContext *) createObjectContext {
  NSManagedObjectContext *output = [[NSManagedObjectContext alloc] init];
  [output setPersistentStoreCoordinator:_persistentStoreCoordinator];
  return output;
}

@end
