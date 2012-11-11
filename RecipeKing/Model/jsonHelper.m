//
//  jsonHelper.m
//  RecipeKing
//
//  Created by Lee Irvine on 11/10/12.
//  Copyright (c) 2012 leescode. All rights reserved.
//

#import "jsonHelper.h"

id valueOrNull(id o) {
  if(o == nil) return [NSNull null];
  return o;
}

id valueOrNil(id o) {
  if(o == [NSNull null]) return nil;
  return o;
}