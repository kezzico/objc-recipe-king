//
//  AlertHandler.m
//  CheapoAir
//
//  Created by Lee Irvine on 5/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AlertHandler.h"


@implementation AlertHandler
@synthesize onOkTouched;

- (void) dealloc {
  [onOkTouched release];
  [super dealloc];
}

- (void) alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
  if(onOkTouched && buttonIndex == 1) onOkTouched();
}

+ (void) alertWithMessage: (NSString *) message {
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Recipe King" message: message delegate:nil cancelButtonTitle: @"Ok" otherButtonTitles: nil];
  [alert show];
  [alert release];
}

+ (void) alertWithMessage:(NSString *)message okTouched:(void (^)()) callback {
  static AlertHandler *delegate = nil;
  if(delegate == nil) delegate = [[AlertHandler alloc] init];
  
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Recipe King" message: message delegate:delegate cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];  
  delegate.onOkTouched = ^{
    callback();
    [alert autorelease];
  };
  
  [alert show];
}

+ (void) alertWithMessage:(NSString *)message okText:(NSString *) okText cancelText: (NSString *) cancelText okTouched:(void (^)()) callback {
  static AlertHandler *delegate = nil;
  if(delegate == nil) delegate = [[AlertHandler alloc] init];
  
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Recipe King" message: message delegate:delegate cancelButtonTitle:cancelText otherButtonTitles:okText, nil];
  delegate.onOkTouched = ^{
    callback();
    [alert autorelease];
  };
  
  [alert show];
}

@end