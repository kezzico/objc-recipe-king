//
//  CategoryCell.h
//  RecipeKing
//
//  Created by Lee Irvine on 2/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UIView *cv;
@property (retain, nonatomic) IBOutlet UILabel *categoryLabel;
- (id)initWithReuseIdentifier:(NSString *) reuseIdentifier;
@end
