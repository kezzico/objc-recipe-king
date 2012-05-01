//
//  TouchableTableView.m
//  RecipeKing
//
//  Created by Lee Irvine on 4/15/12.
//  Copyright (c) 2012 leescode. All rights reserved.
//

#import "TouchableTableView.h"

@implementation TouchableTableView
@synthesize touchDelegate=_touchDelegate;
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  if([_touchDelegate respondsToSelector:@selector(touchesBegan:withEvent:)]) {
    [_touchDelegate touchesBegan: touches withEvent: event];
  }
}

@end
