//
//  CGHelper.m
//  RecipeKing
//
//  Created by Lee Irvine on 11/17/12.
//  Copyright (c) 2012 leescode. All rights reserved.
//

#import "CGHelper.h"

void clearRect(CGContextRef context, CGRect rect) {
  CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
  CGContextFillRect(context, rect);
}

void drawRectangle(CGContextRef context, CGRect rect, CGColorRef color) {
  CGContextSetFillColorWithColor(context, color);
  CGContextFillRect(context, rect);
}

void drawRoundRectangle(CGContextRef context, CGRect rect, CGFloat radius, CGColorRef color) {
  CGFloat minx = CGRectGetMinX(rect), midx = CGRectGetMidX(rect), maxx = CGRectGetMaxX(rect);
  CGFloat miny = CGRectGetMinY(rect), midy = CGRectGetMidY(rect), maxy = CGRectGetMaxY(rect);
  
  CGContextMoveToPoint(context, minx, midy);
  CGContextAddArcToPoint(context, minx, miny, midx, miny, radius);
  CGContextAddArcToPoint(context, maxx, miny, maxx, midy, radius);
  CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
  CGContextAddArcToPoint(context, minx, maxy, minx, midy, radius);
  CGContextClosePath(context);
  CGContextSetFillColorWithColor(context, color);
  CGContextFillPath(context);
}

void drawRoundedBottomRectangle(CGContextRef context, CGRect rect, CGFloat radius, CGColorRef color) {
  CGFloat minx = CGRectGetMinX(rect), midx = CGRectGetMidX(rect), maxx = CGRectGetMaxX(rect);
  CGFloat miny = CGRectGetMinY(rect), midy = CGRectGetMidY(rect), maxy = CGRectGetMaxY(rect);
  
  CGContextMoveToPoint(context, minx, miny);
  CGContextAddLineToPoint(context, maxx, miny);
  CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
  CGContextAddArcToPoint(context, minx, maxy, minx, midy, radius);
  CGContextClosePath(context);
  CGContextSetFillColorWithColor(context, color);
  CGContextFillPath(context);
  
}

void drawParallelogram(CGContextRef context, CGRect rect, CGFloat angle, CGColorRef color) {
  CGFloat deltay = tanf(rads(angle)) * (rect.size.width);
  CGFloat minx = CGRectGetMinX(rect);
  CGFloat maxx = CGRectGetMaxX(rect);
  CGFloat miny = CGRectGetMinY(rect);
  CGFloat maxy = CGRectGetMaxY(rect);
  
  if(angle > 0) {
    CGContextMoveToPoint(context, minx, miny + deltay);
    CGContextAddLineToPoint(context, maxx, miny);
    CGContextAddLineToPoint(context, maxx, maxy);
    CGContextAddLineToPoint(context, minx, maxy + deltay);
  } else {
    CGContextMoveToPoint(context, minx, miny);
    CGContextAddLineToPoint(context, maxx, miny - deltay);
    CGContextAddLineToPoint(context, maxx, maxy - deltay);
    CGContextAddLineToPoint(context, minx, maxy);
  }
  
  CGContextSetFillColorWithColor(context, color);
  CGContextFillPath(context);
}
