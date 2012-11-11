//
//  Repository.h
//  RecipeKing
//
//  Created by Lee Irvine on 8/8/12.
//  Copyright (c) 2012 Fareportal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Repository : NSObject
@property (nonatomic, retain) NSManagedObjectContext *context;
- (NSManagedObject *) firstEntityNamed:(NSString *) entityName withAttribute:(NSString *) attribute equalTo:(NSObject *) value;
- (NSArray *) entitiesNamed:(NSString *) entityName sortWith:(NSArray *)sortDescriptors;
- (NSArray *) entitiesNamed:(NSString *)entityName matching:(NSPredicate *) predicate sortWith:(NSArray *)sortDescriptors;
- (NSManagedObject *) insertEntityWithName:(NSString *) name;
- (void) removeEntity:(NSManagedObject *) entity;
- (void) swapContext:(NSManagedObjectContext *) context andDo:(void(^)()) action;
- (void) save;
@end