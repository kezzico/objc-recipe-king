//
//  FlurryManager.h
//  RecipeKing
//
//  Created by Lee Irvine on 12/7/12.
//  Copyright (c) 2012 leescode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlurryManager : NSObject
+ (FlurryManager *) shared;
+ (void) startsession;
- (void) logEvent: (NSString *) event;
- (void) logEvent: (NSString *) event withParameters: (NSDictionary *) params;
- (void) logError:(NSString *) error message:(NSString *) message exception:(NSException *) exception;
@end
