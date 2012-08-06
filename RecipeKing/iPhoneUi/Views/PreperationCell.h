//
//  PreperationCell.h
//  RecipeKing
//
//  Created by Lee Irvine on 8/5/12.
//  Copyright (c) 2012 leescode. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PreperationCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *preperationLabel;
+ (CGFloat) heightWithText: (NSString *) text;
- (void) setPreperation: (NSString *) text;
@end
