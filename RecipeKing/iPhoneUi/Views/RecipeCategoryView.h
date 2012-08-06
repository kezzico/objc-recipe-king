//
//  RecipeCategoryView.h
//  RecipeKing
//
//  Created by Lee Irvine on 8/4/12.
//  Copyright (c) 2012 leescode. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipeCategoryView : UIView
@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
- (void) setCategory:(NSString *) category;
@end
