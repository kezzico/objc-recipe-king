//
//  ContentView.m
//  RecipeKing
//
//  Created by Lee Irvine on 11/17/12.
//  Copyright (c) 2012 leescode. All rights reserved.
//

#import "ContentViewController.h"

@implementation ContentViewController
- (void) dealloc {
  [_navcontroller release];
  [_leftButtonsPortrait release];
  [_leftButtonsLandscape release];
  [_rightButtonsPortrait release];
  [_rightButtonsLandscape release];
  [super dealloc];
}

- (void) viewDidUnload {
  self.leftButtonsPortrait = nil;
  self.leftButtonsLandscape = nil;
  self.rightButtonsPortrait = nil;
  self.rightButtonsLandscape = nil;
  [super viewDidUnload];
}

- (void) didShowKeyboardWithHeight:(CGFloat) height {
  
}

@end
