//
//  ActionSheet.m
//  RecipeKing
//
//  Created by Lee Irvine on 11/14/12.
//  Copyright (c) 2012 leescode. All rights reserved.
//

#import "ActionSheet.h"

@implementation ActionSheet

- (void) dealloc {
  if(_visible == YES) [self release];
  [_content release];
  [_contentView release];
  [_sheetView release];
  [_shadowView release];
  [_view release];
  [super dealloc];
}

- (id) init {
  if(self = [super init]) {
    [[NSBundle mainBundle] loadNibNamed:@"ActionSheet" owner:self options:nil];
    _sheetHeight = self.sheetView.frame.size.height;
  }
  return self;
}

- (void) showContent:(UIView *) content inView:(UIView *) view {
  if(_visible == YES) return;
  [self retain];
  _visible = YES;
  
  [self.contentView addSubview: content];
  self.view.frame = CGRectMake(0, 0, view.bounds.size.width, view.bounds.size.height);
  [self sizeToContentHeight: content.frame.size.height];
  [view addSubview:self.view];
  
  [self moveToDimissedPosition];
  [UIView animateWithDuration:0.4f animations:^{
    [self moveToVisiblePosition];
  }];
}

- (void) sizeToContentHeight: (CGFloat) height {
  CGRect sheetViewFrame = self.sheetView.frame;
  CGRect contentFrame = self.contentView.frame;
  
  contentFrame.size.height = height;
  sheetViewFrame.size.height = height + _sheetHeight;
  
  self.contentView.frame = contentFrame;
  self.sheetView.frame = sheetViewFrame;
}

- (void) dismiss {
  if(_visible == NO) return;
  _visible = NO;

  [UIView animateWithDuration:0.4f animations:^{
    [self moveToDimissedPosition];
  } completion:^(BOOL complete) {
    if(complete == NO) return;
    [self clearContent];
    [self.view removeFromSuperview];
    [self autorelease];
  }];
  
}

- (void) clearContent {
  [self sizeToContentHeight: 0];
  for(UIView *view in self.contentView.subviews) {
    [view removeFromSuperview];
  }
}

- (IBAction) cancelTouched:(id)sender {
  [self dismiss];
}

- (void) moveToDimissedPosition {
  self.shadowView.alpha = 0.f;
  
  CGRect sheetFrame = self.sheetView.frame;
  sheetFrame.origin.y = _view.frame.size.height + sheetFrame.size.height;
  self.sheetView.frame = sheetFrame;
}

- (void) moveToVisiblePosition {
  self.shadowView.alpha = 1.f;

  CGRect sheetFrame = self.sheetView.frame;
  sheetFrame.origin.y = _view.frame.size.height - sheetFrame.size.height;
  self.sheetView.frame = sheetFrame;
}

@end
