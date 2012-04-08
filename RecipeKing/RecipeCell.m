//
//  RecipeCell.m
//  RecipeKing
//
//  Created by Lee Irvine on 2/15/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import "RecipeCell.h"

@implementation RecipeCell
@synthesize recipeImage;
@synthesize recipeNameLabel;
@synthesize cookTimeBox;
@synthesize cookTimeLabel;
@synthesize cv;

- (id)initWithReuseIdentifier:(NSString *) reuseIdentifier {
  if((self = [super initWithStyle: UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier])) {
    [[NSBundle mainBundle] loadNibNamed: @"RecipeCell" owner: self options: nil];
    [self.contentView addSubview: cv];
  }
  return self;
}

- (void)dealloc {
  [cookTimeLabel release];
  [cookTimeBox release];
  [recipeNameLabel release];
  [recipeImage release];
  [cv release];
  [super dealloc];
}
@end
