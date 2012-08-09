//
//  RecipeListViewController.h
//  RecipeKing
//
//  Created by Lee Irvine on 8/4/12.
//  Copyright (c) 2012 leescode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PRecipeRepository.h"

@class RecipeListSearchController;
@class RecipeListViewModel;
@class RateMyAppController;
@interface RecipeListViewController : UIViewController
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) IBOutlet RecipeListSearchController *recipeSearchController;
@property (nonatomic, retain) id<PRecipeRepository> repository;
@property (nonatomic, retain) RecipeListViewModel *viewModel;
@property (retain, nonatomic) IBOutlet RateMyAppController *rateMyAppController;
@end
