//
//  CGHelper.h
//  RecipeKing
//
//  Created by Lee Irvine on 11/17/12.
//  Copyright (c) 2012 leescode. All rights reserved.
//

#import <Foundation/Foundation.h>

void clearRect(CGContextRef context, CGRect bounds);
void drawRectangle(CGContextRef context, CGRect bounds, CGColorRef color);
void drawRoundRectangle(CGContextRef context, CGRect rect, CGFloat radius, CGColorRef fillcolor);
void drawRoundedBottomRectangle(CGContextRef context, CGRect rect, CGFloat radius, CGColorRef color);
void drawParallelogram(CGContextRef context, CGRect rect, CGFloat angle, CGColorRef color);
