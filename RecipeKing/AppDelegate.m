//
//  AppDelegate.m
//  RecipeKing
//
//  Created by Lee Irvine on 2/4/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import "AppDelegate.h"
#import "ControllerFactory.h"
#import "RecipeListViewController.h"
#import "RecipeRepository.h"
#import "UINavigationBarSkinned.h"
#import "DatabaseMigrator.h"
#import "Container.h"
#import "PCategoryRepository.h"

@implementation AppDelegate
@synthesize window = _window;
@synthesize navController=_navController;

- (void)dealloc {
  [_window release];
  [_navController release];
  [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [self migrateFromVersion1];
  [self addCategoriesOnFirstRun];
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  self.window.backgroundColor = [UIColor whiteColor];
  
  RecipeListViewController *recipeListController = [ControllerFactory buildViewControllerForRecipeList];
  self.navController = [UINavigationBarSkinned navigationControllerWithRoot: recipeListController];
  
  _window.rootViewController = self.navController;
  [_window makeKeyAndVisible];
  return YES;
}

- (void) migrateFromVersion1 {
  DatabaseMigrator *migrator = [[[DatabaseMigrator alloc] init] autorelease];
  if([migrator shouldMigrateV1Database]) {
    [migrator migratev1RecipeTov3];
    [migrator deletev1Database];
  }
  if([migrator shouldMigrateV2Database]) {
    [migrator migratev2RecipeTov3];
    [migrator deletev2Database];
  }
  
}

- (void) addCategoriesOnFirstRun {
  if([[NSUserDefaults standardUserDefaults] boolForKey:@"isNotFirstRun"] == NO) {
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isNotFirstRun"];
    id<PCategoryRepository> repository = [[Container shared] resolve:@protocol(PCategoryRepository)];
    [repository add:@"Appetizer"];
    [repository add:@"Bread"];
    [repository add:@"Breakfast"];
    [repository add:@"Dessert"];
    [repository add:@"Drinks"];
    [repository add:@"Salad"];
    [repository add:@"Seafood"];
    [repository add:@"Pasta"];    
  }
}

@end
