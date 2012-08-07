//
//  RecipeListViewController.m
//  RecipeKing
//
//  Created by Lee Irvine on 8/4/12.
//  Copyright (c) 2012 leescode. All rights reserved.
//

#import "RecipeListViewController.h"
#import "RecipeListMapper.h"
#import "EditRecipeViewController.h"
#import "RecipeListViewModel.h"
#import "UINavigationBarSkinned.h"
#import "RecipeViewController.h"
#import "RecipeMapper.h"
#import "ListRecipe.h"
#import "Container.h"
#import "ControllerFactory.h"
#import "RecipeCell.h"
#import "NSString-Extensions.h"
#import "CategoryCell.h"
#import "RecipeListSearchController.h"

@implementation RecipeListViewController
@synthesize tableView=_tableView;
@synthesize recipeSearchController=_recipeSearchController;
@synthesize viewModel=_viewModel;

- (void) dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
  [_tableView release];
  [_recipeSearchController release];
  [_viewModel release];
  [super dealloc];
}

- (void)viewDidUnload {
  [self setTableView:nil];
  [self setRecipeSearchController:nil];
  [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recipeChanged:)
     name:@"recipeChanged" object:nil];
  self.repository = [[Container shared] resolve:@protocol(PRecipeRepository)];
  [self createAddRecipeButton];
  [self refreshRecipes];
  [self setupSearchBar];
}

- (void) createAddRecipeButton {
  UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
    target:self action:@selector(addRecipeTouched)];
  
  self.navigationItem.rightBarButtonItem = [addButton autorelease];
}

- (void) addRecipeTouched {
  EditRecipeViewController *vc = [ControllerFactory buildEditViewControllerForNewRecipe];
  UINavigationController *nc = [UINavigationBarSkinned navigationControllerWithRoot: [vc autorelease]];
  [self presentViewController: nc animated: YES completion:nil];
}

- (void) recipeChanged:(NSNotification *) notification {
  [self refreshRecipes];
}

- (void) refreshRecipes {
  RecipeListMapper *mapper = [[[RecipeListMapper alloc] init] autorelease];
  NSArray *recipes = [mapper recipeListToViewModel: [_repository allRecipes]];
  _viewModel.recipesAndCategories = [NSMutableArray arrayWithArray:recipes];
  [self.tableView reloadData];
}

- (void) setupSearchBar {
  self.recipeSearchController.recipeSelected = ^(ListRecipe *recipe) {
    [self presentRecipe:recipe];
  };
}

- (void) presentRecipe:(ListRecipe *) recipe {
  Recipe *r = [self.repository recipeWithId:recipe.recipeId];
  RecipeViewController *vc = [ControllerFactory buildViewControllerForRecipe: r];
  [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark table view delegate
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *) indexPath {
  if([self isRowRecipeCell: indexPath.row]) return 48.0f;
  return 24.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self.viewModel.recipesAndCategories count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  if([self isRowRecipeCell: indexPath.row]) return [self tableView: tableView recipeCellAtRow: indexPath.row];
  return [self tableView: tableView categoryCellAtRow: indexPath.row];
}

- (BOOL) isRowRecipeCell: (NSInteger) row {
  return [[self.viewModel.recipesAndCategories objectAtIndex: row] class] == [ListRecipe class];
}

- (UITableViewCell *) tableView: (UITableView *) tableView recipeCellAtRow: (NSInteger) row {
  static NSString *cellIdentifier = @"RecipeListRecipeCell";
  RecipeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  if (cell == nil) {
    cell = [[[RecipeCell alloc] initWithReuseIdentifier:cellIdentifier] autorelease];
  }
  
  ListRecipe *recipe = [self.viewModel.recipesAndCategories objectAtIndex: row];
  cell.recipeNameLabel.text = recipe.name;
  cell.preperationTimeLabel.text = [NSString stringFromTime: recipe.preperationTime];
  cell.selectionStyle = UITableViewCellSelectionStyleNone;
  
  return cell;
}

- (UITableViewCell *) tableView: (UITableView *) tableView categoryCellAtRow: (NSInteger) row {
  static NSString *CellIdentifier = @"RecipeListCategoryCell";
  CategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[[CategoryCell alloc] initWithReuseIdentifier: CellIdentifier] autorelease];
  }
  
  NSString *category = [self.viewModel.recipesAndCategories objectAtIndex: row];
  cell.categoryLabel.text = category;
  
  return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  if([self isRowRecipeCell: indexPath.row]) {
    ListRecipe *recipe = [_viewModel.recipesAndCategories objectAtIndex: indexPath.row];
    [self presentRecipe:recipe];
  }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    NSArray *rowsToDelete = [self removeRecipeAtIndex: indexPath];
    [tableView deleteRowsAtIndexPaths: rowsToDelete withRowAnimation:UITableViewRowAnimationFade];
  }
}

- (NSArray *) removeRecipeAtIndex: (NSIndexPath *) indexPath {
  ListRecipe *recipe = [self.viewModel.recipesAndCategories objectAtIndex: indexPath.row];
  [_repository remove: recipe.recipeId];
  [_viewModel.recipesAndCategories removeObject: recipe];
  
  NSMutableArray *rowsToRemove = [NSMutableArray arrayWithObject: indexPath];
  for(int i=0;i<[_viewModel.recipesAndCategories count];i++) {
    if([self isRowRecipeCell: i] == NO && [self isCategoryAtIndexEmpty: i]) {
      [rowsToRemove addObject: [NSIndexPath indexPathForRow:i inSection:0]];
      [self.viewModel.recipesAndCategories removeObjectAtIndex:i];
    }
  }
  return rowsToRemove;
}

- (BOOL) isCategoryAtIndexEmpty: (NSInteger) index {
  NSInteger size = [_viewModel.recipesAndCategories count];
  return index + 1 == size || [self isRowRecipeCell: index + 1] == NO;
}

@end
