//
//  NavigationControllerViewController.h
//  RecipeKing
//
//  Created by Lee Irvine on 11/17/12.
//  Copyright (c) 2012 leescode. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ContentViewController;
@class Stack;
@interface NavigationController : UIViewController {
  BOOL _hideBackButton;
  BOOL _rotating;
  CGFloat _keyboardoffset;
}
+ (NavigationController *) navWithRoot:(ContentViewController *) rootViewController;
- (void) pushViewController: (ContentViewController *) controller;
- (void) popViewController;
- (IBAction)backTouched:(id)sender;
@property (retain, nonatomic) IBOutlet UIImageView *titleimage;
@property (retain, nonatomic) IBOutlet UIView *titlebar;
@property (retain, nonatomic) IBOutlet UIView *contentView;
@property (retain, nonatomic) IBOutlet UIView *titlebarLeft;
@property (retain, nonatomic) IBOutlet UIView *titlebarRight;
@property (retain, nonatomic) Stack *controllerStack;
@property (retain, nonatomic) IBOutlet UIView *backButtonViewPortrait;
@property (retain, nonatomic) IBOutlet UIView *backButtonViewLandscape;
@property (retain, nonatomic) IBOutlet UIButton *backButtonPortrait;
@property (retain, nonatomic) IBOutlet UIButton *backButtonLandscape;
- (void) hideBackButton:(BOOL) hide;
@end
