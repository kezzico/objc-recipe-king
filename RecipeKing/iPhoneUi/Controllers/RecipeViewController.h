//
//  RecipeViewController.h
//  RecipeKing
//
//  Created by Lee Irvine on 4/25/12.
//  Copyright (c) 2012 leescode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PRecipeRepository.h"
#import "ContentViewController.h"
@class RecipeViewModel;
@class RecipeCategoryView;
@class PreperationCell;
@class SharingController;
@interface RecipeViewController : ContentViewController <UITableViewDelegate, UITableViewDataSource>
@property (retain, nonatomic) RecipeViewModel *viewModel;
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) IBOutlet UITableViewCell *titleCell;
@property (retain, nonatomic) IBOutlet UITableViewCell *ingredientsHeaderCell;
@property (retain, nonatomic) IBOutlet UITableViewCell *preparationHeaderCell;
@property (retain, nonatomic) IBOutlet RecipeCategoryView *categoryView;
@property (retain, nonatomic) IBOutlet UIView *servingsView;
@property (retain, nonatomic) IBOutlet UILabel *servingsLabel;
@property (retain, nonatomic) IBOutlet UILabel *recipeNameLabel;
@property (retain, nonatomic) IBOutlet UILabel *preparationTimeLabel;
@property (retain, nonatomic) IBOutlet UIButton *recipePhotoButton;
@property (retain, nonatomic) IBOutlet PreperationCell *preparationCell;
@property (retain, nonatomic) IBOutlet UIView *titleView;
@property (retain, nonatomic) IBOutlet SharingController *sharingController;
@property (retain, nonatomic) id<PRecipeRepository> repository;
@property (retain, nonatomic) IBOutlet UILabel *ingredientsLabel;
@property (retain, nonatomic) IBOutlet UILabel *preparationLabel;
@property (retain, nonatomic) IBOutlet UILabel *mailLabel;
@property (retain, nonatomic) IBOutlet UILabel *messageLabel;
@property (retain, nonatomic) IBOutlet UILabel *recipeCopyLabel;
- (IBAction)editRecipeTouched:(id)sender;
- (IBAction)photoTouched:(id)sender;
@end
