//
//  AlertHandler.h
//  CheapoAir
//
//  Created by Lee Irvine on 5/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlertHandler : NSObject <UIAlertViewDelegate>
@property (nonatomic, retain) void(^onOkTouched)();
+ (void) alertWithMessage: (NSString *) message;
+ (void) alertWithMessage:(NSString *)message okTouched:(void (^)()) callback;
+ (void) alertWithMessage:(NSString *)message okText:(NSString *) okText cancelText: (NSString *) cancelText okTouched:(void (^)()) callback;
@end