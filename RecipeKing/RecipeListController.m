//
//  RecipeListController.m
//  RecipeKing
//
//  Created by Lee Irvine on 2/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RecipeListController.h"
#import "RecipeListMapper.h"
#import "RecipeListTableController.h"
#import "RecipeSearchTableController.h"
#import "EditRecipeController.h" 
#import "UINavigationBarSkinned.h"
#import "ListRecipe.h"

@interface RecipeListController()
- (void) refreshRecipes;
- (NSIndexSet *) findAndRemoveEmptyCategories;
@end

@implementation RecipeListController
@synthesize repository=_repository;
@synthesize recipeListTable=_recipeListTable;
@synthesize recipeSearchTable = _recipeSearchTable;
@synthesize recipesAndCategories=_recipesAndCategories;

- (void)dealloc {
  [_repository release];
  [_mapper release];
  [_recipeListTable release];
  [_recipeSearchTable release];
  [super dealloc];
}

- (void)viewDidUnload {
  [self setRecipeListTable:nil];
  [self setRecipeSearchTable:nil];
  [super viewDidUnload];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  _mapper = [[RecipeListMapper alloc] init];
  [self refreshRecipes];
  
  UIBarButtonItem *addButton = [[UIBarButtonItem alloc] 
    initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self 
                                action:@selector(addRecipeTouched)];
  
  self.navigationItem.rightBarButtonItem = [addButton autorelease];
}

- (void) recipeTouched: (ListRecipe *) recipe {
  
}

- (void) addRecipeTouched {
  EditRecipeController *vc = [[EditRecipeController alloc] initWithNibName: @"EditRecipeController" bundle:nil];
  UINavigationController *nc = [UINavigationBarSkinned navigationControllerWithRoot: [vc autorelease]];
  [self.navigationController presentModalViewController: nc animated: YES];  
}

- (void) deleteRecipe: (ListRecipe *) recipe {
  [_repository remove: recipe.recipeId];
  [_recipesAndCategories removeObject: recipe];
}

- (BOOL) rowIsRecipeCell: (NSInteger) row {
  return [[_recipesAndCategories objectAtIndex: row] class] == [ListRecipe class];
}

- (void) refreshRecipes {
  NSArray *recipes = [_mapper recipeListToViewModel: [_repository list]];
  _recipesAndCategories = [[NSMutableArray alloc] initWithArray: recipes];
}

- (NSIndexSet *) findAndRemoveEmptyCategories {
  NSMutableIndexSet *output = [[[NSMutableIndexSet alloc] init] autorelease];
  
  for(int i=0;i<[_recipesAndCategories count];i++) {
    if([self rowIsRecipeCell: i] == false) {
      // last row is category
      if([_recipesAndCategories count] == i + 1) {
        [output addIndex: i];
        continue;
      }
      // next row is category
      if([self rowIsRecipeCell: i + 1] == false) {
        [output addIndex: i];
        continue;
      }
    }
  }
  
  [_recipesAndCategories removeObjectsAtIndexes: output];
  return output;
}

- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
  _recipeSearchTable.recipes = [_mapper recipeListToViewModel: [_repository filter: searchText]];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
