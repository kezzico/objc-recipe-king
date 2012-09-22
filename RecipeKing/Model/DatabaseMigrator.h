//
//  DatabaseMigrator.h
//  RecipeKing
//
//  Created by Lee Irvine on 8/8/12.
//  Copyright (c) 2012 leescode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DatabaseMigrator : NSObject
- (BOOL) shouldMigrateV1Database;
- (BOOL) shouldMigrateV2Database;
- (void) migratev1RecipeTov3;
- (void) migratev2RecipeTov3;
- (void) deletev1Database;
- (void) deletev2Database;
@end
