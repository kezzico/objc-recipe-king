//
//  IngredientCell.h
//  RecipeKing
//
//  Created by Lee Irvine on 8/4/12.
//  Copyright (c) 2012 leescode. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IngredientCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *nameLabel;
@property (retain, nonatomic) IBOutlet UILabel *quantityLabel;
@property (retain, nonatomic) IBOutlet UIView *view;
- (id) initWithReuseIdentifier:(NSString *)reuseIdentifier;
- (void) setQuantityWidth: (CGFloat) width;
+ (CGFloat) height;
@end
