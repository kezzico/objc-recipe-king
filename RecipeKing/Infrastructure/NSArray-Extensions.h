//
//  NSMutableArray-Extensions.h
//  CheapoAir
//
//  Created by Lee Irvine on 5/23/12.
//  Copyright (c) 2012 Fareportal. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef id (^objectMapper)(id obj);
@interface NSArray (Extensions)
- (NSArray *) mapObjects:(objectMapper) rule;
- (NSMutableArray *) mapObjectsMutable:(objectMapper) mapper;
- (NSArray *)shuffledArray;
- (id)firstObject;
@end
