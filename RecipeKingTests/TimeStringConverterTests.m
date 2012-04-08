//
//  TimeStringConverterTests.m
//  RecipeKing
//
//  Created by Lee Irvine on 3/25/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import "TimeStringConverterTests.h"
#import "TimeStringConverter.h"

@implementation TimeStringConverterTests

- (void) setUp {
  _converter = [[TimeStringConverter alloc] init];
}

- (void) tearDown {
  [_converter release];
}

- (void) testShouldExtractMinutes1 {
  NSString *time = @"0 hrs 36 mins";
  NSInteger result = [_converter getMinutesFromTimeString: time];
  STAssertTrue(result == 36, @"result does not match");
}

- (void) testShouldExtractMinutes2 {
  NSString *time = @"10 minutes";
  NSInteger result = [_converter getMinutesFromTimeString: time];
  STAssertTrue(result == 10, @"result does not match");
}

- (void) testShouldExtractMinutes3 {
  NSString *time = @"ten minutes";
  NSInteger result = [_converter getMinutesFromTimeString: time];
  STAssertTrue(result == 0, @"result does not match");
}

- (void) testShouldExtractHours1 {
  NSString *time = @"1 hrs 10 mins";
  NSInteger result = [_converter getHoursFromTimeString: time];
  STAssertTrue(result == 1, @"result does not match");
}

- (void) testShouldExtractHours2 {
  NSString *time = @"20 mins";
  NSInteger result = [_converter getHoursFromTimeString: time];
  STAssertTrue(result == 0, @"result does not match");
}

- (void) testShouldExtractHours3 {
  NSString *time = nil;
  NSInteger result = [_converter getHoursFromTimeString: time];
  STAssertTrue(result == 0, @"result does not match");
}

@end
