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
  NSString *message = @"Thank you for using Recipe King. Please leave a positive rating if you have found it useful. It won't take more than a minute. Thanks for your support!";
  NSString *okText = @"Rate It!";
  NSString *cancelText = @"No, Thanks";
  
  [AlertHandler alertWithMessage:message okText:okText cancelText:cancelText okTouched:^{
    NSURL *appUrl = [NSURL URLWithString:@"http://itunes.apple.com/us/app/recipe-king/id493431587?ls=1&mt=8"];
    [[UIApplication sharedApplication] openURL: appUrl];
  }];
}

- (BOOL) didAskForRating {
  return [[NSUserDefaults standardUserDefaults] boolForKey:@"didAskForRating"];
}

- (void) setDidAskForRating:(BOOL) value {
  [[NSUserDefaults standardUserDefaults] setBool:value forKey:@"didAskForRating"];
}

@end
