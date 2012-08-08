//
//  ControllerFactory.m
//  RecipeKing
//
//  Created by Lee Irvine on 8/4/12.
//  Copyright (c) 2012 leescode. All rights reserved.
//

#import "ControllerFactory.h"
#import "RecipeListViewController.h"
#import "RecipeViewController.h"
#import "RecipeMapper.h"
#import "Recipe.h"
#import "RecipeListViewModel.h"
#import "EditRecipeViewController.h"
#import "EditRecipeViewModel.h"
#import "CategoryListController.h"
#import "EditCategoryViewController.h"
#import "ImageViewController.h"

@implementation ControllerFactory
+ (RecipeViewController *) buildViewControllerForRecipe: (Recipe *) recipe {
  RecipeViewController *vc = [[[RecipeViewController alloc] initWithNibName:@"RecipeViewController" bundle:nil] autorelease];
  RecipeMapper *mapper = [[[RecipeMapper alloc] init] autorelease];
  vc.viewModel = [mapper viewModelFromRecipe:recipe];
  return vc;
}

+ (RecipeListViewController *) buildViewControllerForRecipeList {
  RecipeListViewController *recipeListController = nil;
  recipeListController = [[[RecipeListViewController alloc] initWithNibName: @"RecipeListViewController" bundle: nil] autorelease];
  recipeListController.viewModel = [[[RecipeListViewModel alloc] init] autorelease];
  return recipeListController;
}

+ (EditRecipeViewController *) buildEditViewControllerForNewRecipe {
  EditRecipeViewController *vc = [[EditRecipeViewController alloc] initWithNibName: @"EditRecipeViewController" bundle:nil];
  vc.viewModel = [[[EditRecipeViewModel alloc] init] autorelease];
  return vc;
}

+ (EditRecipeViewController *) buildEditViewControllerForRecipe:(Recipe *) recipe {
  EditRecipeViewController *vc = [[EditRecipeViewController alloc] initWithNibName: @"EditRecipeViewController" bundle:nil];
  RecipeMapper *mapper = [[[RecipeMapper alloc] init] autorelease];
  vc.viewModel = [mapper editViewModelFromRecipe:recipe];
  return vc;
}

+ (CategoryListController *) buildCategoryListViewController {
  CategoryListController *categoryList = [[[CategoryListController alloc]
    initWithNibName: @"CategoryListController" bundle: nil] autorelease];
  
  return categoryList;
}

+ (EditCategoryViewController *) buildEditCategoryViewController {
  return [[[EditCategoryViewController alloc] initWithNibName: @"EditCategoryViewController" bundle: nil] autorelease];
}

+ (ImageViewController *) imageViewControllerWithImage: (UIImage *) image {
  ImageViewController *vc = [[[ImageViewController alloc] initWithNibName:@"ImageViewController" bundle:nil] autorelease];
  vc.image = image;
  return vc;
}

@end
