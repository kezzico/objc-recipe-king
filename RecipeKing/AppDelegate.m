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
  
  self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
  self.window.backgroundColor = [UIColor whiteColor];
  
  RecipeListViewController *recipeListController = [ControllerFactory buildViewControllerForRecipeList];
  self.navController = [UINavigationBarSkinned navigationControllerWithRoot: recipeListController];
  
  _window.rootViewController = self.navController;
  [_window makeKeyAndVisible];
  return YES;
}

- (void) migrateFromVersion1 {
  DatabaseMigrator *migrator = [[[DatabaseMigrator alloc] init] autorelease];
  if([migrator shouldMigrateDatabase]) {
    [migrator migratev1RecipeTov2];
    [migrator deletev1Database];
  }
}

- (void) syncRecipes {
  id<PRecipeRepository> repository = [[Container shared] resolve:@protocol(PRecipeRepository)];
  [repository sync];
}

- (void) applicationDidBecomeActive:(UIApplication *)application {
  [self syncRecipes];
}

- (void) addCategoriesOnFirstRun {
  if([[NSUserDefaults standardUserDefaults] boolForKey:@"isNotFirstRun"] == NO) {
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isNotFirstRun"];
    id<PCategoryRepository> repository = [[Container shared] resolve:@protocol(PCategoryRepository)];
    [repository addDefaultCategories];
  }
}

@end
