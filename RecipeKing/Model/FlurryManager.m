//
//  FlurryManager.m
//  RecipeKing
//
//  Created by Lee Irvine on 12/7/12.
//  Copyright (c) 2012 leescode. All rights reserved.
//

#import "FlurryManager.h"
#import "Flurry.h"

static FlurryManager *manager;
@implementation FlurryManager

+ (FlurryManager *) shared {
  return manager;
}

- (id) init {
  if(self = [super init]) {
    [Flurry startSession: @"NBVQ7BC4X6S4MNW3SQY5"];
  }
  return self;
}

+ (void) startsession {
//#ifndef DEBUG
  manager = [[FlurryManager alloc] init];
//#endif
}

- (void) logEvent: (NSString *) event {
  [Flurry logEvent:event];
}

- (void) logEvent: (NSString *) event withParameters: (NSDictionary *) params {
  [Flurry logEvent:event withParameters: params];
}

- (void) logError:(NSString *) error message:(NSString *) message exception:(NSException *) exception {
  [Flurry logError:error message:message exception:exception];
}

@end