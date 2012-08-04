//
//  RecipeViewController.h
//  RecipeKing
//
//  Created by Lee Irvine on 4/25/12.
//  Copyright (c) 2012 leescode. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Recipe;
@interface RecipeViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource> {
  NSArray *_cells;
}
@property (retain, nonatomic) Recipe *recipe;
@property (retain, nonatomic) IBOutlet UITableViewCell *titleCell;
@property (retain, nonatomic) IBOutlet UITableViewCell *imageCell;
@end
