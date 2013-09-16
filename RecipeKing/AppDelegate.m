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
// [UIApplication sharedApplication].idleTimerDisabled = YES;
#import "AppDelegate.h"


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
    NSError *error = nil;
    NSInteger r = arc4random() % 100;
    self.store = [DBDatastore openDefaultStoreForAccount:account error:&error];
    DBTable *table = [self.store getTable:@"recipes"];
    
    [table insert:@{@"name": [NSString stringWithFormat:@"Brownies - %d", r]}];
    
    [self.store addObserver:self block:^{
      NSLog(@"stuff happened? %d", self.store.status);
      if((self.store.status & DBDatastoreIncoming) != 0 || (self.store.status & DBDatastoreOutgoing) != 0) {
        NSError *error = nil;
        [self.store sync:&error];
        if(error != nil) {
          NSLog(@"error! %@", error);
          return;
        }
      }
      
      NSArray *tables = [self.store getTables:nil];
      for(DBTable *table in tables) {
        NSLog(@"table: %@", table.tableId);
        NSArray *recipes = [table query:nil error:nil];
        for(DBRecord *record in recipes) {
          NSLog(@"%@", [record.fields valueForKey:@"name"]);
        }
      }
      
      
    }];
    
  } else {
    [[DBAccountManager sharedManager] linkFromController:self.controller];
  }
  
}

@end
