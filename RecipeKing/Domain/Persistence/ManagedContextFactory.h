//
//  SharedContext.h
//  RecipeKing
//
//  Created by Lee Irvine on 2/17/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface ManagedContextFactory : NSObject {
  NSManagedObjectModel *_managedObjectModel;
  NSPersistentStoreCoordinator *_persistentStoreCoordinator;
}
+ (void) resetStoreCoordinator;
+ (NSManagedObjectContext *) buildContext;

@end
