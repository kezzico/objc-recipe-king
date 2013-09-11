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
#import <Dropbox/Dropbox.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  self.controller = [[UIViewController alloc] initWithNibName:@"root" bundle:nil];
  self.window.rootViewController = self.controller;
  self.window.backgroundColor = [UIColor whiteColor];
  [self.window makeKeyAndVisible];
  [self doDropbox];
  return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url
  sourceApplication:(NSString *)source annotation:(id)annotation {
  DBAccount *account = [[DBAccountManager sharedManager] handleOpenURL:url];
  if (account) {
    NSLog(@"App linked successfully!");
    return YES;
  }
  return NO;
}

- (void) doDropbox {
  DBAccountManager* accountMgr = [[DBAccountManager alloc] initWithAppKey:@"t0qt7vgqkd2lpty" secret:@"wvj9x76ponpbyui"];
  [DBAccountManager setSharedManager:accountMgr];

  DBAccount *account = [[DBAccountManager sharedManager] linkedAccount];
  if (account) {
    NSLog(@"App already linked");
  } else {
    [[DBAccountManager sharedManager] linkFromController:self.controller];
  }
  
}

@end
