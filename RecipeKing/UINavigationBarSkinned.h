//
//  UINavigationBarSkinned.h
//  RecipeKing
//
//  Created by Lee Irvine on 2/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBarSkinned : UINavigationBar {
  UIImage *_backgroundImageLandscape;
  UIImage *_backgroundImagePortrait;
}

+ (UINavigationController *) navigationControllerWithRoot: (UIViewController *) rootViewController;

@end
