//
//  ScreenHelper.m
//  RecipeKing
//
//  Created by Lee Irvine on 9/20/12.
//  Copyright (c) 2012 leescode. All rights reserved.
//

#import "ScreenHelper.h"

@implementation ScreenHelper

+ (CGFloat) widthForPortrait:(CGFloat) pwidth landscape:(CGFloat) lwidth wideLandscape:(CGFloat) wwidth {
  if([ScreenHelper isWideScreen]) {
    return [ScreenHelper isPortraitMode] ? pwidth : wwidth;
  } else {
    return [ScreenHelper isPortraitMode] ? pwidth : lwidth;
  }
}

+ (CGFloat) heightForPortrait:(CGFloat) pheight landscape:(CGFloat) lheight tallPortrait:(CGFloat) theight {
  if([ScreenHelper isWideScreen]) {
    return [ScreenHelper isPortraitMode] ? theight : lheight;
  } else {
    return [ScreenHelper isPortraitMode] ? pheight : lheight;
  }
}

+ (CGFloat) screenWidth {
  return [ScreenHelper widthForPortrait:320 landscape:480 wideLandscape:568];
}

+ (CGSize) screenSize {
  if([ScreenHelper isWideScreen]) {
    return [ScreenHelper isPortraitMode] ? CGSizeMake(320, 568) : CGSizeMake(568, 320);
  } else {
    return [ScreenHelper isPortraitMode] ? CGSizeMake(320, 480) : CGSizeMake(480, 320);
  }
}

+ (BOOL) isPortraitMode {
  return UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation]);
}

+ (BOOL) isWideScreen {
  return [[UIScreen mainScreen] bounds].size.height > 480.f;
}

@end
