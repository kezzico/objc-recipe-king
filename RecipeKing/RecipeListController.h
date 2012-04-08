//
//  RecipeListController.h
//  RecipeKing
//
//  Created by Lee Irvine on 2/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PRecipeRepository.h"
@class RecipeListMapper;
@class RecipeListTableController;
@class RecipeSearchTableController;
@class ListRecipe;
@interface RecipeListController : UIViewController <UISearchBarDelegate> {
  RecipeListMapper *_mapper;
}

@property (nonatomic, retain) NSMutableArray *recipesAndCategories;
@property (nonatomic, retain) IBOutlet NSObject<PRecipeRepository> *repository;
@property (nonatomic, retain) IBOutlet RecipeListTableController *recipeListTable;
@property (nonatomic, retain) IBOutlet RecipeSearchTableController *recipeSearchTable;
- (void) deleteRecipe: (ListRecipe *) recipe;
- (NSIndexSet *) findAndRemoveEmptyCategories;
- (BOOL) rowIsRecipeCell: (NSInteger) row;
- (void) recipeTouched: (ListRecipe *) recipe;
@end
