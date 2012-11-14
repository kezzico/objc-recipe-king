//
//  Container.m
//  CheapoAir
//
//  Created by Lee Irvine on 5/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <objc/runtime.h>
#import "Container.h"
#import "RecipeRepository.h"
#import "CategoryRepository.h"

static Container *sharedContainer = nil;

@implementation Container

+ (void) initialize {
  sharedContainer = [[Container alloc] init];
  [sharedContainer bootstrap];
}

+ (Container *) shared {
  return sharedContainer;
}

- (void) bootstrap {
  [sharedContainer registerProtocol:@protocol(PRecipeRepository) toClass:[RecipeRepository class]];
  [sharedContainer registerProtocol:@protocol(PCategoryRepository) toClass:[CategoryRepository class]];
}


- (void) dealloc {
  [_components release];
  [super dealloc];
}

- (id) init {
  if(self = [super init]) {
    _components = [[NSMutableDictionary alloc] init];
  }
  return self;
}

- (void) registerProtocol: (Protocol *) proto toClass: (Class) class {
  Dependency *dependency = [[[Dependency alloc] init] autorelease];
  dependency->class = class;
  NSString *key = NSStringFromProtocol(proto);
  [_components setValue: dependency forKey: key];
}

- (void) registerProtocol:(Protocol *)proto toInstance:(id)obj {
  Dependency *dependency = [[[Dependency alloc] init] autorelease];
  dependency->class = [obj class];
  dependency->instance = [obj retain];
  
  NSString *key = NSStringFromProtocol(proto);
  [_components setValue: dependency forKey: key];  
}

- (id) resolve: (Protocol *) proto {
  NSString *key = NSStringFromProtocol(proto);
  Dependency *dependency = [_components valueForKey: key];

  if(dependency == nil) {
    NSLog(@"failed to resolve dependency for %@", key);
    return nil;
  }
  
  if(dependency->instance == nil) {
    dependency->instance = [[dependency->class alloc] init];
  }
  
  return dependency->instance;
}

@end

@implementation Dependency
- (void) dealloc {
  [instance release];
  [super dealloc];
}
@end
