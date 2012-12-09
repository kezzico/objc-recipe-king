//
//  RecipeImageViewController.h
//  RecipeKing
//
//  Created by Lee Irvine on 8/6/12.
//  Copyright (c) 2012 leescode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentViewController.h"
@interface ImageViewController : ContentViewController
@property (nonatomic, retain) UIImage *image;
- (UIImageView *) imageView;
@end
