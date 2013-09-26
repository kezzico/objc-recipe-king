//
//  AppDelegate.m
//  RecipeKing
//
//  Created by Lee Irvine on 9/11/13.
//  Copyright (c) 2013 Lee Irvine. All rights reserved.
//

// $ [sudo] gem install cocoapods
// $ pod setup
// https://www.dropbox.com/developers/datastore/tutorial/ios

#import "AppDelegate.h"
#import "RootViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  self.controller = [[RootViewController alloc] initWithNibName:@"root" bundle:nil];
  UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController: self.controller];
  
  self.window.rootViewController = nav;
  self.window.backgroundColor = [UIColor whiteColor];
  [self.window makeKeyAndVisible];

  return YES;
}

@end
