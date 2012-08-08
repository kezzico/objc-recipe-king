//
//  RecipeImageViewController.m
//  RecipeKing
//
//  Created by Lee Irvine on 8/6/12.
//  Copyright (c) 2012 leescode. All rights reserved.
//

#import "ImageViewController.h"

@implementation ImageViewController
@synthesize image=_image;
- (void) dealloc {
  [_image release];
  [super dealloc];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.imageView.image = self.image;
  self.view.contentMode = UIViewContentModeScaleAspectFit;
}

- (UIImageView *) imageView {
  return (UIImageView *)self.view;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
