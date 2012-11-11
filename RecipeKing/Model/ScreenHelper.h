//
//  ScreenHelper.h
//  RecipeKing
//
//  Created by Lee Irvine on 9/20/12.
//  Copyright (c) 2012 leescode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScreenHelper : NSObject
+ (BOOL) isPortraitMode;
+ (BOOL) isWideScreen;
+ (CGSize) screenSize;
+ (CGFloat) screenWidth;
+ (CGFloat) widthForPortrait:(CGFloat) pwidth landscape:(CGFloat) lwidth wideLandscape:(CGFloat) wwidth;
+ (CGFloat) heightForPortrait:(CGFloat) pheight landscape:(CGFloat) lheight tallPortrait:(CGFloat) theight;
@end
