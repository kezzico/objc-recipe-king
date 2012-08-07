//
//  RecipeImageViewController.m
//  RecipeKing
//
//  Created by Lee Irvine on 8/6/12.
//  Copyright (c) 2012 leescode. All rights reserved.
//

#import "ImageViewController.h"

@implementation ImageViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.contentMode = UIViewContentModeScaleAspectFill;
}

- (UIImageView *) imageView {
  return (UIImageView *)self.view;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
