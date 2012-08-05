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

@implementation AppDelegate
@synthesize window = _window;
@synthesize navController=_navController;

- (void)dealloc {
  [_window release];
  [_navController release];
  [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  NSString *importFile = [launchOptions valueForKey: @"URL"];
  if(importFile) {
    // todo: import recipe
  }
  
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  self.window.backgroundColor = [UIColor whiteColor];
  
  RecipeListViewController *recipeListController = [ControllerFactory buildViewControllerForRecipeList];
  self.navController = [UINavigationBarSkinned navigationControllerWithRoot: recipeListController];
  
  _window.rootViewController = self.navController;
  [_window makeKeyAndVisible];
  return YES;
}

- (BOOL) application: (UIApplication *) application handleOpenURL:(NSURL *) url {
  // todo: import file
  return YES;
}

@end
