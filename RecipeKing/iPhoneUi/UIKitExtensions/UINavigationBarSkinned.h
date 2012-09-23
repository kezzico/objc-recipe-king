//
//  UINavigationBarSkinned.h
//  RecipeKing
//
//  Created by Lee Irvine on 2/21/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBarSkinned : UINavigationBar
@property (nonatomic, retain) UIImage *backgroundImageLandscape;
@property (nonatomic, retain) UIImage *backgroundImageLandscapeWide;
@property (nonatomic, retain) UIImage *backgroundImagePortrait;

+ (UINavigationController *) navigationControllerWithRoot: (UIViewController *) rootViewController;

@end
