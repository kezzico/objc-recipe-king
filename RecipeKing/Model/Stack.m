//
//  Stack.m
//  Recipe King
//
//  Created by Lee Irvine on 4/28/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import "Stack.h"
#import "NSArray-Extensions.h"

@implementation Stack

- (id) init {
  if(self = [super init]) {
    _stack = [[NSMutableArray alloc] init];
  }
  return self;
}

- (void) dealloc {
  [_stack release];
  [super dealloc];
}
- (NSInteger) count {
  return [_stack count];
}
- (void) push: (id) object {
  [_stack addObject: object];
}
- (id) pop {
  id output = [[_stack lastObject] retain];
  if(output) {
    [_stack removeLastObject];
  }
  
  return [output autorelease];
}
- (id) peek {
  return [_stack lastObject];
}
- (void) empty {
  [_stack removeAllObjects];
}
- (id) popToFirst {
  id first = [_stack firstObject];
  [_stack removeAllObjects];
  
  if(first) {
    [_stack addObject: first];
  }
  
  return first;
}

@end