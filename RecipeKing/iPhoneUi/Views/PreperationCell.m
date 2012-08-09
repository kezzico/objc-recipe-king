//
//  PreperationCell.m
//  RecipeKing
//
//  Created by Lee Irvine on 8/5/12.
//  Copyright (c) 2012 leescode. All rights reserved.
//

#import "PreperationCell.h"

@implementation PreperationCell
@synthesize preparationLabel;

- (void)dealloc {
  [preparationLabel release];
  [super dealloc];
}

+ (CGFloat) heightWithText: (NSString *) text {
  CGSize size = [self labelSize:text];
  return size.height + 20;
}

+ (CGSize) labelSize: (NSString *) text {
  UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
  CGFloat width = UIDeviceOrientationIsPortrait(orientation) ? 300 : 460;
  
  CGSize maxSize = CGSizeMake(width, INFINITY);
  UIFont *font = [UIFont systemFontOfSize:13];
  UILineBreakMode lbm = UILineBreakModeWordWrap;
  
  return [text sizeWithFont:font constrainedToSize:maxSize lineBreakMode:lbm];
}

- (void) setPreparation: (NSString *) text {
  self.preparationLabel.text = text;
  
  CGRect frame = self.preparationLabel.frame;
  frame.size = [PreperationCell labelSize:text];
  self.preparationLabel.frame = frame;
}

@end
