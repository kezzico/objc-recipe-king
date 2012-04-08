//
//  RecipeCell.m
//  RecipeKing
//
//  Created by Lee Irvine on 2/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CategoryCell.h"

@implementation CategoryCell
@synthesize cv;
@synthesize categoryLabel;

- (id)initWithReuseIdentifier:(NSString *) reuseIdentifier {
  if((self = [super initWithStyle: UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier])) {
    [[NSBundle mainBundle] loadNibNamed: @"CategoryCell" owner: self options: nil];
    [self.contentView addSubview: cv];
  }
  return self;
}

- (void)dealloc {
  [cv release];
  [categoryLabel release];
  [super dealloc];
}
@end
