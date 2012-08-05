//
//  IngredientCell.m
//  RecipeKing
//
//  Created by Lee Irvine on 8/4/12.
//  Copyright (c) 2012 leescode. All rights reserved.
//

#import "IngredientCell.h"

@implementation IngredientCell
@synthesize nameLabel;
@synthesize quantityLabel;
@synthesize view;

- (void)dealloc {
  [nameLabel release];
  [quantityLabel release];
  [view release];
  [super dealloc];
}
- (id) initWithReuseIdentifier:(NSString *)reuseIdentifier {
  if(self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier ]) {
    [[NSBundle mainBundle] loadNibNamed:@"IngredientCell" owner:self options:nil];
    [self.contentView addSubview:self.view];
  }
  return self;
}

+ (CGFloat) height {
  return 20.f;
}

@end
