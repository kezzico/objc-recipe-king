//
//  SharedContext.m
//  RecipeKing
//
//  Created by Lee Irvine on 2/17/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//
#import "ManagedContextFactory.h"

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

+ (void) resetStoreCoordinator {
  [contextfactory deleteStoreCoordinator];
  [contextfactory setupObjectModel];
  [contextfactory setupStoreCoordinator];
}

- (void) setupObjectModel {
  NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"RecipeKing" withExtension:@"momd"];
  _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
}

- (NSURL *) storeUrl {
  NSURL *libraryUrl = [[[NSFileManager defaultManager] URLsForDirectory: NSLibraryDirectory inDomains:NSUserDomainMask] lastObject];
  return [libraryUrl URLByAppendingPathComponent: @"RecipeKing.sqlite"];
}

- (void) deleteStoreCoordinator {
  [[NSFileManager defaultManager] removeItemAtURL: [self storeUrl] error: nil];
}

- (void) setupStoreCoordinator {
  NSError *error = nil;
  NSDictionary *options = @{NSMigratePersistentStoresAutomaticallyOption:@YES,NSInferMappingModelAutomaticallyOption:@YES};
  _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: _managedObjectModel];
  [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL: [self storeUrl] options:options error:&error];
  if(error) NSLog(@"%@", error);
}

- (NSManagedObjectContext *) createObjectContext {
  NSManagedObjectContext *output = [[[NSManagedObjectContext alloc] init] autorelease];
  [output setPersistentStoreCoordinator:_persistentStoreCoordinator];
  return output;
}

+ (NSManagedObjectContext *) buildContext {
  return [contextfactory createObjectContext];
}

+ (void) deleteStoreCoordinator {
  [contextfactory deleteStoreCoordinator];
}

@end
