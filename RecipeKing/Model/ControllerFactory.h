//
//  ControllerFactory.h
//  RecipeKing
//
//  Created by Lee Irvine on 8/4/12.
//  Copyright (c) 2012 leescode. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RecipeViewController;
@class RecipeListViewController;
@class EditRecipeViewController;
@class CategoryListController;
@class EditCategoryViewController;
@class ImageViewController;
@class Recipe;

@interface ControllerFactory : NSObject
+ (RecipeViewController *) buildViewControllerForRecipe: (Recipe *) recipe;
+ (EditRecipeViewController *) buildEditViewControllerForRecipe:(Recipe *) recipe;
+ (EditRecipeViewController *) buildEditViewControllerForNewRecipe;
+ (RecipeListViewController *) buildViewControllerForRecipeList;
+ (CategoryListController *) buildCategoryListViewController;
+ (EditCategoryViewController *) buildEditCategoryViewController;
+ (ImageViewController *) imageViewControllerWithImage: (UIImage *) image;
@end
