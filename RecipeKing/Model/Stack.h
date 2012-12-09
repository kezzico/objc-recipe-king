//
//  Stack.h
//  RecipeKing
//
//  Created by Lee Irvine on 11/17/12.
//  Copyright (c) 2012 leescode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Stack : NSObject {
  NSMutableArray *_stack;
}
- (NSInteger) count;
- (void) push: (id) object;
- (void) empty;
- (id) pop;
- (id) peek;
- (id) popToFirst;

@end