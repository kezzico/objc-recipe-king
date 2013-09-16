//
//  Repository.m
//  RecipeKing
//
//  Created by Lee Irvine on 8/8/12.
//  Copyright (c) 2012 Fareportal. All rights reserved.
//

#import "Repository.h"
#import "NSArray-Extensions.h"
#import "ManagedContextFactory.h"

@implementation Repository

- (id) init {
  if(self = [super init]) {
    self.context = [ManagedContextFactory buildContext];
  }
  return self;
}

- (NSManagedObject *) firstEntityNamed:(NSString *) entityName withAttribute:(NSString *) attribute equalTo:(NSObject *) value {
  NSEntityDescription *entityDescription = [NSEntityDescription entityForName: entityName inManagedObjectContext: self.context];
  NSFetchRequest *request = [[NSFetchRequest alloc] init];
  [request setEntity:entityDescription];
  NSPredicate *predicate = [NSPredicate predicateWithFormat: @"%K = %@", attribute, value];
  [request setPredicate:predicate];
  
  NSError *error = nil;
  NSArray *output = [_context executeFetchRequest: request error: &error];
  if(error) {
    NSLog(@"failed retrieving entity named: %@ with code: %d", entityName, error.code);
  }
  
  return [output firstObject];
}

- (NSArray *) entitiesNamed:(NSString *) entityName sortWith:(NSArray *)sortDescriptors {
  NSEntityDescription *entityDescription = [NSEntityDescription entityForName:entityName inManagedObjectContext: self.context];
  NSFetchRequest *request = [[NSFetchRequest alloc] init];
  [request setEntity:entityDescription];
  
  if(sortDescriptors) {
    [request setSortDescriptors:sortDescriptors];
  }
  
  NSError *error = nil;
  NSArray *output = [_context executeFetchRequest: request error: &error];
  if(error) {
    NSLog(@"%@", error);
    return nil;
  }
  
  return output;
}

- (NSArray *) entitiesNamed:(NSString *)entityName matching:(NSPredicate *) predicate sortWith:(NSArray *)sortDescriptors {
  NSEntityDescription *entityDescription = [NSEntityDescription entityForName: entityName inManagedObjectContext: self.context];
  
  NSFetchRequest *request = [[NSFetchRequest alloc] init];
  [request setEntity:entityDescription];
  
  if(predicate) {
    [request setPredicate:predicate];
  }
  
  if(sortDescriptors) {
    [request setSortDescriptors:sortDescriptors];
  }
  
  NSError *error = nil;
  NSArray *output = [self.context executeFetchRequest:request error:&error];
  
  if(error) {
    NSLog(@"failed retrieving entities named: %@ with predicate: %@", entityName, predicate);
  }
  
  return output;
}

- (void) removeEntity:(NSManagedObject *) entity {
  if(entity == nil) return;
  [self.context deleteObject: entity];
  [self save];
}

- (void) save {
  NSError *error = nil;
  [self.context save: &error];
  if(error) NSLog(@"%@", error);
}

- (NSManagedObject *) insertEntityWithName:(NSString *) name {
  return [NSEntityDescription insertNewObjectForEntityForName:name inManagedObjectContext: self.context];
}

- (void) swapContext:(NSManagedObjectContext *) context andDo:(void(^)()) action {
  NSManagedObjectContext *ctx = self.context;
  self.context = context;
  action();
  self.context = ctx;
}

@end