//
//  DatabaseMigrator.m
//  RecipeKing
//
//  Created by Lee Irvine on 8/8/12.
//  Copyright (c) 2012 leescode. All rights reserved.
//

#import "DatabaseMigrator.h"
#import "NSString-Extensions.h"
#import "Ingredient.h"
#import "Recipe.h"

typedef const unsigned char uchar;
@implementation DatabaseMigrator

- (BOOL) shouldMigrateV1Database {
  return [[NSFileManager defaultManager] fileExistsAtPath: self.v1DatabasePath];
}

- (BOOL) shouldMigrateV2Database {
  return [[NSFileManager defaultManager] fileExistsAtPath: self.v2DatabasePath];
}

- (void) migratev1RecipeTov3 {
  sqlite3 *database;
  int status = sqlite3_open([self.v1DatabasePath UTF8String], &database);
  if(status != SQLITE_OK) return;

  NSArray *recipes = [self queryRecipesInDatabase:database];
  NSArray *ingredients = [self queryIngredientsInDatabase:database];
  sqlite3_close(database);
  
  [self saveRecipes: recipes withIngredients:ingredients];
}

- (void) migratev2RecipeTov3 {
  sqlite3 *database;
  int status = sqlite3_open([self.v1DatabasePath UTF8String], &database);
  if(status != SQLITE_OK) return;
  
  NSArray *recipes = [self queryRecipesInDatabase:database];
  NSArray *ingredients = [self queryIngredientsInDatabase:database];
  sqlite3_close(database);
  
  [self saveRecipes: recipes withIngredients:ingredients];
}


- (NSArray *) queryRecipesInDatabase:(sqlite3*) database {
  
  sqlite3_stmt *compiledStatement;
  int status = sqlite3_prepare_v2(database, "select * from zrecipe", -1, &compiledStatement, NULL);
  if(status != SQLITE_OK) return nil;
  
  NSMutableArray *output = [[[NSMutableArray alloc] init] autorelease];
  while(sqlite3_step(compiledStatement) == SQLITE_ROW) {

    uchar *key = sqlite3_column_text(compiledStatement, 0);
    uchar *cookTemp = sqlite3_column_text(compiledStatement, 4);
    uchar *cookTime = sqlite3_column_text(compiledStatement, 5);
    uchar *preparation = sqlite3_column_text(compiledStatement, 6);
    uchar *name = sqlite3_column_text(compiledStatement, 7);
    uchar *image = sqlite3_column_blob(compiledStatement, 8);
    int imageSize = sqlite3_column_bytes(compiledStatement, 8);

    NSMutableDictionary *recipe = [[[NSMutableDictionary alloc] init] autorelease];
    [recipe setValue: [self ucharToNumber: key] forKey:@"primarykey"];
    [recipe setValue: [self ucharToString: preparation] forKey:@"preparation"];
    [recipe setValue: [self ucharToString: name] forKey:@"name"];
    [recipe setValue: [self ucharToData: image size: imageSize] forKey:@"photo"];
    
    if(strlen((char *)cookTemp) > 0) {
      NSString *cookTempstr = [NSString stringWithUTF8String:(char *)cookTemp];
      NSString *preparation = [recipe valueForKey:@"preparation"];
      NSString *prepPlusCook = [NSString stringWithFormat:@"%@\n\nTemperature: %@", preparation, cookTempstr];
      [recipe setValue:prepPlusCook forKey:@"preparation"];
    }
    
    if(strlen((char*)cookTime) > 0) {
      [recipe setValue: [self timeStringToTime: cookTime] forKey:@"preptime"];
    }
    
    [output addObject: recipe];
  }
  sqlite3_finalize(compiledStatement);
  return [NSArray arrayWithArray: output];
}

- (NSArray *) queryIngredientsInDatabase:(sqlite3*) database {
  sqlite3_stmt *compiledStatement;
  int status = sqlite3_prepare_v2(database, "select * from zingredient", -1, &compiledStatement, NULL);
  if(status != SQLITE_OK) return nil;
  
  NSMutableArray *output = [[[NSMutableArray alloc] init] autorelease];
  while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
    NSMutableDictionary *ingredient = [[[NSMutableDictionary alloc] init] autorelease];
    uchar *recipeId = sqlite3_column_text(compiledStatement, 4);
    uchar *name = sqlite3_column_text(compiledStatement, 5);
    uchar *quantity = sqlite3_column_text(compiledStatement, 6);
    [ingredient setValue: [self ucharToNumber: recipeId] forKey:@"recipeId"];
    [ingredient setValue: [self ucharToString: name] forKey:@"name"];
    [ingredient setValue: [self ucharToString: quantity] forKey:@"quantity"];
    [output addObject: ingredient];
  }
  
  sqlite3_finalize(compiledStatement);
  return [NSArray arrayWithArray: output];
}

- (NSNumber *) timeStringToTime:(uchar *) c {
  NSString *s = [NSString stringWithUTF8String:(char *)c];
  NSInteger time = [[s search:@"[^0-9]" replace:@""] integerValue];
  NSInteger hours = time / 60;
  NSInteger minutes = time % 60;
  
  return [NSNumber numberWithInteger:hours * 100 + minutes];
}

- (NSNumber *) ucharToNumber:(uchar *) n {
  NSString *numberstr = [NSString stringWithUTF8String:(char *)n];
  NSInteger numberint = [numberstr integerValue];
  return [NSNumber numberWithInteger:numberint];
}

- (NSString *) ucharToString:(uchar *) n {
  return [NSString stringWithUTF8String:(char *)n];
}

- (NSData *) ucharToData:(uchar *) n size:(int) size {
  if(size == 0) return nil;
  return [NSData dataWithBytes:n length:size];
}

- (void) deletev1Database {
  [[NSFileManager defaultManager] removeItemAtPath:self.v1DatabasePath error:nil];
}

- (void) saveRecipes:(NSArray *) recipes withIngredients:(NSArray *) ingredients {
//  NSManagedObjectContext *context = [ManagedContextFactory buildContext];
//  for(NSDictionary *r in recipes) {
//    NSNumber *pk = [r valueForKey:@"primarykey"];
//    Recipe *recipe = [NSEntityDescription insertNewObjectForEntityForName:@"Recipe" inManagedObjectContext: context];
//    recipe.name = [r valueForKey:@"name"];
//    recipe.preparation = [r valueForKey:@"preparation"];
//    recipe.photo = [r valueForKey:@"photo"];
//    recipe.preparationTime = [r valueForKey:@"preptime"];
//    
//    for(NSDictionary *igt in ingredients) {
//      NSNumber *fk = [igt valueForKey:@"recipeId"];
//      if([fk isEqual:pk]) {
//        NSString *name = [igt valueForKey:@"name"];
//        NSString *quantity = [igt valueForKey:@"quantity"];
//        [recipe addIngredientWithName:name quantity:quantity];
//      }
//    }
//  }
//  
//  [context save:nil];
}

- (NSString *) v1DatabasePath {
  NSURL *docsDir = [[[NSFileManager defaultManager] URLsForDirectory: NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
  return [[docsDir URLByAppendingPathComponent: @"RecipeKing.sqlite"] path];
}

- (NSString *) v2DatabasePath {
  NSURL *libraryDir = [[[NSFileManager defaultManager] URLsForDirectory: NSLibraryDirectory inDomains:NSUserDomainMask] lastObject];
  return [[libraryDir URLByAppendingPathComponent: @"RecipeKing.sqlite"] path];
}

@end
