//
//  RecipeCategoryView.m
//  RecipeKing
//
//  Created by Lee Irvine on 8/4/12.
//  Copyright (c) 2012 leescode. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "RecipeCategoryView.h"

@implementation RecipeCategoryView
@synthesize nameLabel;

- (id) initWithCoder:(NSCoder *)aDecoder {
  if(self = [super initWithCoder:aDecoder]) {
    self.layer.cornerRadius = 8.f;
    self.backgroundColor = [UIColor colorWithRed:1.0f green:0.54 blue:0 alpha:1.0f];
  }
  return self;
}

- (CGFloat) textWidth:(NSString *) text {
  CGSize maxSize = CGSizeMake(220, 0);
  UIFont *font = [UIFont systemFontOfSize:14];
  UILineBreakMode lbm = UILineBreakModeTailTruncation;
  
  return [text sizeWithFont:font constrainedToSize:maxSize lineBreakMode:lbm].width;
}

- (void) setCategory:(NSString *) category {
  CGRect frame = self.frame;
  frame.size.width = [self textWidth: category] + 20;
  self.frame = frame;
  
  self.nameLabel.text = category;
}

@end
