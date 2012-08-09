//
//  MigrationTests.m
//  RecipeKing
//
//  Created by Lee Irvine on 8/8/12.
//  Copyright (c) 2012 leescode. All rights reserved.
//

#import "ZMigrationTests.h"
#import "DatabaseMigrator.h"
#import "ManagedContextFactory.h"

@implementation ZMigrationTests

+ (void) setUp {
  [ManagedContextFactory resetStoreCoordinator];
}

- (void) _testMigratingDatabase {
  DatabaseMigrator *migrator = [[[DatabaseMigrator alloc] init] autorelease];
  BOOL shouldMigrate = [migrator shouldMigrateDatabase];

  STAssertTrue(shouldMigrate, @"should be true");
  
  [migrator migratev1RecipeTov2];
  [migrator deletev1Database];
}

@end
