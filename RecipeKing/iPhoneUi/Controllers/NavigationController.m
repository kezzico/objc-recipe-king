//
//  NavigationControllerViewController.m
//  RecipeKing
//
//  Created by Lee Irvine on 11/17/12.
//  Copyright (c) 2012 leescode. All rights reserved.
//

#import "NavigationController.h"
#import "ScreenHelper.h"
#import "ContentViewController.h"
#import "NSArray-Extensions.h"
#import "Stack.h"

@implementation NavigationController
+ (NavigationController *) navWithRoot:(ContentViewController *) rootViewController {
  NavigationController *output = [[[NavigationController alloc] initWithNibName:@"NavigationController" bundle:nil] autorelease];
  output.controllerStack = [[[Stack alloc] init] autorelease];
  [output.controllerStack push: rootViewController];
  return output;
}

- (void)dealloc {
  [_controllerStack release];
  [_titleimage release];
  [_titlebar release];
  [_contentView release];
  [_titlebarLeft release];
  [_titlebarRight release];
  [_backButtonViewPortrait release];
  [_backButtonViewLandscape release];
  [_backButtonPortrait release];
  [_backButtonLandscape release];
  [super dealloc];
}

- (void)viewDidUnload {
  [self setTitleimage:nil];
  [self setTitlebar:nil];
  [self setContentView:nil];
  [self setTitlebarLeft:nil];
  [self setTitlebarRight:nil];
  [self setBackButtonViewPortrait:nil];
  [self setBackButtonViewLandscape:nil];
  [self setBackButtonLandscape:nil];
  [self setBackButtonPortrait:nil];
  [super viewDidUnload];
}

- (void) viewWillDisappear:(BOOL)animated {
  [[NSNotificationCenter defaultCenter] removeObserver:self];  
}

- (void) viewWillAppear:(BOOL)animated {
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didShowKeyboard:) name:UIKeyboardDidShowNotification object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willHideKeyboard:) name:UIKeyboardWillHideNotification object:nil];
  [self adjustForOrientation];
}

- (void) viewDidLoad {
  [self addController: [self.controllerStack pop]];
  [self adjustForOrientation];
  [self localizeText];
}

- (void) didShowKeyboard:(NSNotification *) notification {
  CGRect keyboardframe; [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardframe];
  UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
  _keyboardoffset = UIInterfaceOrientationIsPortrait(orientation) ? keyboardframe.size.height : keyboardframe.size.width;
  [self adjustHeightsForOrientation: orientation];
}

- (void) willHideKeyboard:(NSNotification *) notification {
  if(_rotating) return;
  _keyboardoffset = 0.f;
  UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
  [self adjustHeightsForOrientation: orientation];
}

- (void) localizeText {
  [self.backButtonLandscape setTitle:_L(@"Back") forState:UIControlStateNormal];
  [self.backButtonPortrait setTitle:_L(@"Back") forState:UIControlStateNormal];
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation) fromInterfaceOrientation {
  _rotating = NO;
  if([self.controller respondsToSelector:@selector(didRotateFromInterfaceOrientation:)]) {
    [self.controller didRotateFromInterfaceOrientation:fromInterfaceOrientation];
  }
}

- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation) toInterfaceOrientation duration:(NSTimeInterval) duration {
  _rotating = YES;
  [self adjustTitlebarImageForOrientation: toInterfaceOrientation];
  [UIView animateWithDuration:duration animations:^{
    [self adjustHeightsForOrientation: toInterfaceOrientation];
    [self adjustButtonsForOrientation: toInterfaceOrientation];
  }];
}

- (void) adjustForOrientation {
  UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
  [self adjustTitlebarImageForOrientation:orientation];
  [self adjustHeightsForOrientation:orientation];
  [self adjustButtonsForOrientation:orientation];
}

- (void) adjustTitlebarImageForOrientation:(UIInterfaceOrientation) orientation {
  if(UIInterfaceOrientationIsPortrait(orientation)) {
    self.titleimage.image = [UIImage imageNamed:@"navportrait"];
  } else if([ScreenHelper isWideScreen]) {
    self.titleimage.image = [UIImage imageNamed:@"navwide"];
  } else {
    self.titleimage.image = [UIImage imageNamed:@"navlandscape"];
  }
}

- (void) adjustHeightsForOrientation:(UIInterfaceOrientation) orientation {
  CGRect contentframe = self.contentView.frame;
  CGRect titlebarframe = self.titlebar.frame;
  CGSize screenSize = [ScreenHelper screenSizeForOrientation:orientation];
  CGFloat titlebarHeight = UIInterfaceOrientationIsPortrait(orientation) ? 44.f : 32.f;
  titlebarframe.size.height = titlebarHeight;
  
  contentframe.origin.x = 0.f;
  contentframe.origin.y = titlebarHeight;
  contentframe.size.width = screenSize.width;
  contentframe.size.height = screenSize.height - titlebarHeight - 20.f - _keyboardoffset;
  
  self.contentView.frame = contentframe;
  self.titlebar.frame = titlebarframe;
}

- (void) adjustButtonsForOrientation:(UIInterfaceOrientation) orientation {
  BOOL isPortrait = UIInterfaceOrientationIsPortrait(orientation);
  CGFloat titlebarHeight = isPortrait ? 44.f : 32.f;
  CGFloat buttonHeight = isPortrait ? 29.f : 24.f;
  CGRect leftframe = self.titlebarLeft.frame;
  CGRect rightframe = self.titlebarRight.frame;
  leftframe.size.height = buttonHeight;
  leftframe.origin.y = (titlebarHeight - buttonHeight) * 0.5f;
  rightframe.size.height = leftframe.size.height;
  rightframe.origin.y = leftframe.origin.y;
  self.titlebarLeft.frame = leftframe;
  self.titlebarRight.frame = rightframe;
  
  [self addButtonsForOrientation: orientation];
} 

- (void) addButtonsForOrientation:(UIInterfaceOrientation) orientation {
  BOOL isPortrait = UIInterfaceOrientationIsPortrait(orientation);
  UIView *leftButtons = isPortrait ? self.controller.leftButtonsPortrait : self.controller.leftButtonsLandscape;
  UIView *rightButtons = isPortrait ? self.controller.rightButtonsPortrait : self.controller.rightButtonsLandscape;

  [self clearButtons];
  
  if(rightButtons) {
    [self.titlebarRight addSubview: rightButtons];
  }
  
  if(leftButtons) {
    [self.titlebarLeft addSubview: leftButtons];
  } else if([self.controllerStack count] > 1 && _hideBackButton == NO) {
    UIView *backButtons = isPortrait ? self.backButtonViewPortrait : self.backButtonViewLandscape;
    [self.titlebarLeft addSubview: backButtons];
  }
}

- (void) clearButtons {
  for(UIView *view in self.titlebarRight.subviews) {
    [view removeFromSuperview];
  }
  
  for(UIView *view in self.titlebarLeft.subviews) {
    [view removeFromSuperview];
  }
  
}

- (ContentViewController *) controller {
  return [self.controllerStack peek];
}

- (void) pushViewController: (ContentViewController *) controller {
  ContentViewController *current = self.controller;
  
  [self addController:controller];
  
  controller.view.frame = self.rightOfScreenFrame;
  [UIView animateWithDuration:0.3f animations:^{
    current.view.frame = self.leftOfScreenFrame;
    controller.view.frame = self.onScreenFrame;
    self.titlebarRight.alpha = 0.f;
    self.titlebarLeft.alpha = 0.f;
  } completion:^(BOOL complete) {
    if(complete == NO) return;
    [current.view removeFromSuperview];
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    [self addButtonsForOrientation:orientation];
    self.titlebarRight.alpha = 1.f;
    self.titlebarLeft.alpha = 1.f;
  }];

}

- (void) popViewController {
  ContentViewController *current = [self.controllerStack pop];
  ContentViewController *popto = [self.controllerStack peek];
  
  [self.contentView addSubview: popto.view];
  popto.view.frame = self.leftOfScreenFrame;
  [UIView animateWithDuration:0.3f animations:^{
    popto.view.frame = self.onScreenFrame;
    current.view.frame = self.rightOfScreenFrame;
    self.titlebarRight.alpha = 0.f;
    self.titlebarLeft.alpha = 0.f;
    
  } completion:^(BOOL complete) {
    if(complete == NO) return;
    [current.view removeFromSuperview];
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    [self addButtonsForOrientation:orientation];
    self.titlebarRight.alpha = 1.f;
    self.titlebarLeft.alpha = 1.f;
  }];
  
}

- (IBAction)backTouched:(id)sender {
  [self popViewController];
}

- (void) addController: (ContentViewController *) controller {
  controller.navcontroller = self;
  [self.controllerStack push:controller];
  [self.contentView addSubview:controller.view];
}

- (CGRect) rightOfScreenFrame {
  CGRect frame = self.contentView.frame;
  frame.origin.y = 0;
  frame.origin.x += [ScreenHelper screenWidth];
  return frame;
}

- (CGRect) leftOfScreenFrame {
  CGRect frame = self.contentView.frame;
  frame.origin.y = 0;
  frame.origin.x -= [ScreenHelper screenWidth];
  return frame;
}

- (CGRect) onScreenFrame {
  CGRect frame = self.contentView.frame;
  frame.origin.y = 0.f;
  frame.origin.x = 0.f;
  return frame;
}

- (void) hideBackButton:(BOOL) hide {
  _hideBackButton = hide;
  UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
  [self addButtonsForOrientation:orientation];
}

@end
