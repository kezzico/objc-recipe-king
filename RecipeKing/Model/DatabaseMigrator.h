//
//  DatabaseMigrator.h
//  RecipeKing
//
//  Created by Lee Irvine on 8/8/12.
//  Copyright (c) 2012 leescode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <sqlite3.h>

@interface DatabaseMigrator : NSObject
- (BOOL) shouldMigrateDatabase;
- (void) migratev1RecipeTov2;
- (void) deletev1Database;
@end
