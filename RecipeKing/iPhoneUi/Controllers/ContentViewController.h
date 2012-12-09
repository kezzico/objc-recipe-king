//
//  ContentView.h
//  RecipeKing
//
//  Created by Lee Irvine on 11/17/12.
//  Copyright (c) 2012 leescode. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NavigationController;
@interface ContentViewController : UIViewController
@property (nonatomic, retain) NavigationController *navcontroller;
@property (nonatomic, retain) IBOutlet UIView *leftButtonsPortrait;
@property (nonatomic, retain) IBOutlet UIView *leftButtonsLandscape;
@property (nonatomic, retain) IBOutlet UIView *rightButtonsPortrait;
@property (nonatomic, retain) IBOutlet UIView *rightButtonsLandscape;
@end
