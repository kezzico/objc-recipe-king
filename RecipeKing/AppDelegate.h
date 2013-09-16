//
//  AppDelegate.h
//  RecipeKing
//
//  Created by Lee Irvine on 9/11/13.
//  Copyright (c) 2013 Lee Irvine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Dropbox/Dropbox.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) DBDatastore *store;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIViewController *controller;
@end
