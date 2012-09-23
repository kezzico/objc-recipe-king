//
//  IngredientCell.m
//  RecipeKing
//
//  Created by Lee Irvine on 8/4/12.
//  Copyright (c) 2012 leescode. All rights reserved.
//

#import "IngredientCell.h"
#import "ScreenHelper.h"

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

- (void) setQuantityWidth: (CGFloat) width {
  CGRect qframe = self.quantityLabel.frame;
  CGRect nframe = self.nameLabel.frame;
  
  qframe.size.width = width;
  nframe.size.width = self.frame.size.width - (20.f + width);
  nframe.origin.x = 10.f + width;
  
  self.quantityLabel.frame = qframe;
  self.nameLabel.frame = nframe;
}

+ (CGFloat) height {
  return 20.f;
}

@end
