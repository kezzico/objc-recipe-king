//
//  UIColor+Extensions.m
//  RecipeKing
//
//  Created by Lee Irvine on 9/15/13.
//  Copyright (c) 2013 Lee Irvine. All rights reserved.
//

#import "UIColor+Extensions.h"

@implementation UIColor (Extensions)
+ (UIColor *) colorWithHex:(NSString *) hex {
  NSString * pattern = @"[A-Za-z0-9]{2}";
  NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
  NSArray *colors =  [regex matchesInString: hex options:0 range: NSMakeRange(0, [hex length])];

  if([colors count] == 3) {
    CGFloat red = [UIColor colorFromMatch: colors[0] hex:hex];
    CGFloat green = [UIColor colorFromMatch: colors[1] hex:hex];
    CGFloat blue = [UIColor colorFromMatch: colors[2] hex:hex];
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.f];
  }

  if([colors count] == 4) {
    CGFloat red = [UIColor colorFromMatch: colors[0] hex:hex];
    CGFloat green = [UIColor colorFromMatch: colors[1] hex:hex];
    CGFloat blue = [UIColor colorFromMatch: colors[2] hex:hex];
    CGFloat alpha = [UIColor colorFromMatch: colors[3] hex:hex];
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
  }
  

  return [UIColor blackColor];
}

+ (CGFloat) colorFromMatch:(NSTextCheckingResult *) match hex:(NSString *) hex {
    NSString *color = [hex substringWithRange: [match rangeAtIndex:0]];
  NSScanner *scanner = [NSScanner scannerWithString:color];
  
  NSUInteger intValue = 0;
  [scanner scanHexInt:&intValue];
  
  CGFloat floatValue = ((float)intValue) / 256.f;
  
  NSLog(@"%@ %@ %d %f", hex, color, intValue, floatValue);
  return floatValue;
}

@end
