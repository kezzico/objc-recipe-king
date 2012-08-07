//
//  RecipeViewController.h
//  RecipeKing
//
//  Created by Lee Irvine on 4/25/12.
//  Copyright (c) 2012 leescode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PRecipeRepository.h"

@class RecipeViewModel;
@class RecipeCategoryView;
@class PreperationCell;
@interface RecipeViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>
@property (retain, nonatomic) RecipeViewModel *viewModel;
@property (retain, nonatomic) IBOutlet UITableViewCell *titleCell;
@property (retain, nonatomic) IBOutlet UITableViewCell *ingredientsHeaderCell;
@property (retain, nonatomic) IBOutlet UITableViewCell *preperationHeaderCell;
@property (retain, nonatomic) IBOutlet RecipeCategoryView *categoryView;
@property (retain, nonatomic) IBOutlet UIView *servingsView;
@property (retain, nonatomic) IBOutlet UILabel *servingsLabel;
@property (retain, nonatomic) IBOutlet UILabel *recipeNameLabel;
@property (retain, nonatomic) IBOutlet UILabel *preperationTimeLabel;
@property (retain, nonatomic) IBOutlet UIButton *recipePhotoButton;
@property (retain, nonatomic) IBOutlet PreperationCell *preperationCell;
@property (retain, nonatomic) IBOutlet UIView *titleView;
@property (retain, nonatomic) id<PRecipeRepository> repository;
- (IBAction)photoTouched:(id)sender;
@end
