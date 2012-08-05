//
//  NSMutableArray-Extensions.m
//  CheapoAir
//
//  Created by Marc Magruder on 5/23/12.
//  Copyright (c) 2012 Fareportal. All rights reserved.
//

#import "NSArray-Extensions.h"

@implementation NSArray (Extensions)
- (NSArray *) mapObjects:(objectMapper) mapper {
  NSMutableArray *output = [self mapObjectsMutable:mapper];
  return [NSArray arrayWithArray:output];
}

- (NSMutableArray *) mapObjectsMutable:(objectMapper) mapper {
  NSMutableArray *output = [[[NSMutableArray alloc] initWithCapacity:[self count]] autorelease];
  for(id obj in self) {
    [output addObject: mapper(obj)];
  }
  
  return output;
}

- (NSArray *)shuffledArray {
  NSUInteger count = [self count];
  NSMutableArray *output = [NSMutableArray arrayWithArray: self];  
  for (NSUInteger i = 0; i < count; ++i) {
    int n = arc4random_uniform(count);
    [output exchangeObjectAtIndex:i withObjectAtIndex:n];
  }
  
  return [NSArray arrayWithArray: output];
}

- (id)firstObject {
  if ([self count] > 0) {
    return [self objectAtIndex:0];
  }
  return nil;
}
@end
