//
//  RecipeCell.h
//  RecipeKing
//
//  Created by Lee Irvine on 2/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipeCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UIImageView *recipeImage;
@property (retain, nonatomic) IBOutlet UILabel *recipeNameLabel;
@property (retain, nonatomic) IBOutlet UIImageView *cookTimeBox;
@property (retain, nonatomic) IBOutlet UILabel *cookTimeLabel;
@property (retain, nonatomic) IBOutlet UIView *cv;

- (id)initWithReuseIdentifier:(NSString *) reuseIdentifier;
@end
