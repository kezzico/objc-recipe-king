//
//  UIView+Extensions.m
//  RecipeKing
//
//  Created by Lee Irvine on 4/15/12.
//  Copyright (c) 2012 leescode. All rights reserved.
//

#import "UIView+Extensions.h"

@implementation UIView (Extensions)

- (UIView *)findFirstResponder
{
  if (self.isFirstResponder) {        
    return self;     
  }
  
  for (UIView *subView in self.subviews) {
    UIView *firstResponder = [subView findFirstResponder];
    
    if (firstResponder != nil) {
      return firstResponder;
    }
  }
  
  return nil;
}
@end