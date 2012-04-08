//
//  TimeStringConverter.m
//  RecipeKing
//
//  Created by Lee Irvine on 3/25/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import "TimeStringConverter.h"

@interface TimeStringConverter ()
- (NSArray *) numbersInString: (NSString *) str;
@end

@implementation TimeStringConverter

- (NSInteger) getHoursFromTimeString: (NSString *) time {
  if([time length] == 0) return 0;
  NSArray *results = [self numbersInString: time];
  if([results count] == 2) {
    NSTextCheckingResult *result = [results objectAtIndex: 0];
    return [[time substringWithRange: result.range] integerValue];
  }

  return 0;
}

- (NSInteger) getMinutesFromTimeString: (NSString *) time {
  if([time length] == 0) return 0;  
  NSArray *results = [self numbersInString: time];
  NSInteger numResults = [results count];
  NSTextCheckingResult *result = nil;
  
  if(numResults == 2) result = [results objectAtIndex: 1];    
  else if(numResults == 1) result = [results objectAtIndex: 0];
  else return 0;
  
  return [[time substringWithRange: result.range] integerValue];
}

- (NSArray *) numbersInString: (NSString *) str {
  NSString *pattern = @"\\b[0-9]+\\b";
  NSError *error = nil;
  NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error: &error];
  if(error) {
    NSLog(@"%@", error);
    return nil;
  }
  
  NSArray *matches = [regex matchesInString: str options: 0 range: NSMakeRange(0, [str length])];
  return matches;
}

- (NSString *) stringWithHours: (NSInteger) h minutes: (NSInteger) m {
  return [NSString stringWithFormat: @"%d hrs %d mins", h, m];
}

@end
