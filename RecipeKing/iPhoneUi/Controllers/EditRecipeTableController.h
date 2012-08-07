//
//  EditRecipeTable.h
//  RecipeKing
//
//  Created by Lee Irvine on 3/24/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import <Foundation/Foundation.h>
@class EditRecipeViewModel;
@interface EditRecipeTableController : NSObject <UITableViewDataSource, UITableViewDelegate>
- (void) setupSections;
- (IBAction)addIngredientTouched:(UIButton *)sender;
- (IBAction)addIngredientTouchedDown:(UIButton *)sender;
@property (retain, nonatomic) EditRecipeViewModel *viewModel;
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) IBOutlet UITableViewCell *recipeNameCell;
@property (retain, nonatomic) IBOutlet UITableViewCell *totalPrepTimeCell;
@property (retain, nonatomic) IBOutlet UITableViewCell *categoryCell;
@property (retain, nonatomic) IBOutlet UITableViewCell *preperationCell;
@property (retain, nonatomic) IBOutlet UITableViewCell *photoCell;
@property (retain, nonatomic) IBOutlet UITableViewCell *servingsCell;
@property (retain, nonatomic) IBOutlet UITableViewCell *addIngredientCell;

@property (retain, nonatomic) NSArray *sections;
@end
