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

- (void) copyDatabaseToDocuments {
  NSError *error = nil;
  NSURL *initialStoreURL = [[NSBundle mainBundle] URLForResource:@"RecipeKing" withExtension:@"sqlite"];
  [self deleteStoreCoordinator];
  [[NSFileManager defaultManager] copyItemAtURL:initialStoreURL toURL: [self storeUrl] error:&error];
  if(error) NSLog(@"%@", error);
}

- (void) deleteStoreCoordinator {
  [[NSFileManager defaultManager] removeItemAtURL: [self storeUrl] error: nil];
}

- (void) setupStoreCoordinator {
  NSError *error = nil;
  _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: _managedObjectModel];
  [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL: [self storeUrl] options:nil error:&error];
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

+ (void) createStoreCoordinator {
  [contextfactory setupStoreCoordinator];
}

+ (NSString *) storePath {
  return [[contextfactory storeUrl] path];
}

@end
