//
//  UIToolbarSkinned.m
//  RecipeKing
//
//  Created by Lee Irvine on 2/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UIToolbarSkinned.h"

@implementation UIToolbarSkinned

- (void)drawRect:(CGRect)rect {  
  BOOL isPortrait = UIDeviceOrientationIsPortrait([[UIDevice currentDevice] orientation]);
  NSString *imagePath = isPortrait ? @"toolbarportrait.png" : @"toolbarlandscape";
  UIImage *image = [UIImage imageNamed: imagePath];  
  [image drawInRect: self.bounds];  
  
}
@end
