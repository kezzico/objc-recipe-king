//
//  RateMyAppController.m
//  RecipeKing
//
//  Created by Lee Irvine on 8/8/12.
//  Copyright (c) 2012 leescode. All rights reserved.
//

#import "RateMyAppController.h"
#import "AlertHandler.h"
#import "Container.h"
#import "FlurryManager.h"

@implementation RateMyAppController
@synthesize repository=_repository;

- (void) dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
  [_repository release];
  [super dealloc];
}

- (void) awakeFromNib {
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recipeChanged:) name:@"recipeChanged" object:nil];
  self.repository = [[Container shared] resolve:@protocol(PRecipeRepository)];
}

- (void) recipeChanged: (NSNotification *) notification {
  if(self.didAskForRating == YES) return;

  NSInteger numRecipes = [[_repository recipesGroupedByCategory] count];
  if(numRecipes < 3) return;
  [self askForRating];
  
  self.didAskForRating = YES;
}

- (void) askForRating {
  NSString *message = _L(@"PleaseRateMessage");
  NSString *okText = _L(@"RateItButton");
  NSString *cancelText = _L(@"NoThanksButton");
  
  [AlertHandler alertWithMessage:message okText:okText cancelText:cancelText okTouched:^{
    NSURL *appUrl = [NSURL URLWithString: @"https://itunes.apple.com/app/id493431587"];
    [[UIApplication sharedApplication] openURL: appUrl];
    [[FlurryManager shared] logEvent:@"rate app touched"];
  }];
}

- (BOOL) didAskForRating {
  return [[NSUserDefaults standardUserDefaults] boolForKey:@"didAskForRating"];
}

- (void) setDidAskForRating:(BOOL) value {
  [[NSUserDefaults standardUserDefaults] setBool:value forKey:@"didAskForRating"];
}

@end
