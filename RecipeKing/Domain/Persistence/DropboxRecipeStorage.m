//
//  DropboxRecipeStorage.m
//  RecipeKing
//
//  Created by Lee Irvine on 9/13/13.
//  Copyright (c) 2013 Lee Irvine. All rights reserved.
//

#import "DropboxRecipeStorage.h"
#import <Dropbox/Dropbox.h>

#define APP_KEY @"t0qt7vgqkd2lpty"
#define APP_SECRET @"wvj9x76ponpbyui"

@implementation DropboxRecipeStorage

+ (DropboxRecipeStorage *) buildFromController: (UIViewController *) controller {
  DropboxRecipeStorage *storage = [[DropboxRecipeStorage alloc] init];
  DBAccountManager *accountManager = [[DBAccountManager alloc] initWithAppKey:APP_KEY secret:APP_SECRET];
  [DBAccountManager setSharedManager:accountManager];
  
  DBAccount *account = [[DBAccountManager sharedManager] linkedAccount];
  
  if(account) {
    storage.datastore = [DBDatastore openDefaultStoreForAccount:account error:nil];
    [storage setupDropboxObserver: storage];
  }
  
  return storage;
}

- (void) setupDropboxObserver:(DropboxRecipeStorage *) storage {
  __weak DBDatastore *datastore = storage.datastore;
  
  [datastore addObserver:storage block:^{
    [storage didChangeStatus: storage.datastore.status];
  }];
  
}

- (void) didChangeStatus:(NSInteger) status {
  
}

//
//- (void) doDropbox {
//  if (account) {
//    
//    DBTable *table = [self.store getTable:@"recipes"];
//    
//    [table insert:@{@"name": [NSString stringWithFormat:@"Brownies - %d", r]}];
//    
//    [self.store addObserver:self block:^{
//      NSLog(@"stuff happened? %d", self.store.status);
//      if((self.store.status & DBDatastoreIncoming) != 0 || (self.store.status & DBDatastoreOutgoing) != 0) {
//        NSError *error = nil;
//        [self.store sync:&error];
//        if(error != nil) {
//          NSLog(@"error! %@", error);
//          return;
//        }
//      }
//      
//      NSArray *tables = [self.store getTables:nil];
//      for(DBTable *table in tables) {
//        NSLog(@"table: %@", table.tableId);
//        NSArray *recipes = [table query:nil error:nil];
//        for(DBRecord *record in recipes) {
//          NSLog(@"%@", [record.fields valueForKey:@"name"]);
//        }
//      }
//      
//      
//    }];
//    
//  } else {
//    [[DBAccountManager sharedManager] linkFromController:self.controller];
//  }
//  
//}


//Storage
//- save recipe
//
//Object For Remote Storage - RecipeRemoteStorage
//
//
//Object For Local Storage - RecipeLocalStorage
//
//
//Both local and remote storage will:
//- notify mediator about changes not made while calling add/delete recipe directly
//- be notified about changes and react
//- list all recipes within
//- save recipe to storage (new or existing)
//- delete recipe from storage
//
//RecipeMediator
//- local storage
//- remote storage
//
//Controller that switches remote storage on and off
//- settings controller
//- didTouchEnableDropbox
//call ____ and add a remote storage object to RecipeStorage
//


@end