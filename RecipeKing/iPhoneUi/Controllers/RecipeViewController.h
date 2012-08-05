//
//  RecipeViewController.h
//  RecipeKing
//
//  Created by Lee Irvine on 4/25/12.
//  Copyright (c) 2012 leescode. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RecipeViewModel;
@class RecipeCategoryView;
@interface RecipeViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>
@property (retain, nonatomic) RecipeViewModel *viewModel;
@property (retain, nonatomic) IBOutlet UITableViewCell *titleCell;
@property (retain, nonatomic) IBOutlet UITableViewCell *ingredientsHeaderCell;
@property (retain, nonatomic) IBOutlet UITableViewCell *preperationHeaderCell;
@property (retain, nonatomic) IBOutlet RecipeCategoryView *categoryView;
@property (retain, nonatomic) IBOutlet UILabel *recipeNameLabel;
@property (retain, nonatomic) IBOutlet UILabel *preperationTimeLabel;
@property (retain, nonatomic) IBOutlet UITableViewCell *preperationCell;
@end
