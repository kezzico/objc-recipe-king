//
//  TimeStringConverter.h
//  RecipeKing
//
//  Created by Lee Irvine on 3/25/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeStringConverter : NSObject

- (NSInteger) getHoursFromTimeString: (NSString *) time;
- (NSInteger) getMinutesFromTimeString: (NSString *) time;
- (NSString *) stringWithHours: (NSInteger) h minutes: (NSInteger) m;

@end
