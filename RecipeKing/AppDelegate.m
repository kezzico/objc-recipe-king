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
#import "DatabaseMigrator.h"
#import "Container.h"
#import "PCategoryRepository.h"
#import "NavigationController.h"
#import "FlurryManager.h"

@implementation AppDelegate
@synthesize window = _window;
@synthesize navController=_navController;

- (void)dealloc {
  [_window release];
  [_navController release];
  [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [FlurryManager startsession];
  [self migrateFromVersion1];
  [self addCategoriesOnFirstRun];
  
  NSURL *importFileUrl = (NSURL *)[launchOptions valueForKey:UIApplicationLaunchOptionsURLKey];
  if(importFileUrl) {
    [self importFile: importFileUrl];
  }
  
  self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
  self.window.backgroundColor = [UIColor clearColor];
  
  RecipeListViewController *recipeListController = [ControllerFactory buildViewControllerForRecipeList];
  self.navController = [NavigationController navWithRoot:recipeListController];
  
  _window.rootViewController = self.navController;
  [_window makeKeyAndVisible];

  return YES;
}

- (BOOL) application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
  [self importFile: url];
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

- (void) importFile:(NSURL *) fileUrl {
  if ([fileUrl isFileURL] == NO) return;
  [self moveFileToDocuments: fileUrl];
  [self cleanDocumentsFolder];
}

- (void) cleanDocumentsFolder {
  NSArray *urls = [[NSFileManager defaultManager] contentsOfDirectoryAtURL:[self documentsUrl] includingPropertiesForKeys:nil options:0 error:nil];
  urls = [urls filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"pathExtension != %@", @"recipeking"]];
  for(NSURL *url in urls) {
    [[NSFileManager defaultManager] removeItemAtURL:url error:nil];
  }
}

- (void) moveFileToDocuments:(NSURL *) fileUrl {
  NSURL *destination = [[self documentsUrl] URLByAppendingPathComponent: fileUrl.lastPathComponent];
  [[NSFileManager defaultManager] moveItemAtURL:fileUrl toURL:destination error:nil];
}

- (NSURL *) documentsUrl {
  return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
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
