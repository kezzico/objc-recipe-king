//
//  LocalizationController.m
//  RecipeKing
//
//  Created by Lee Irvine on 11/23/12.
//  Copyright (c) 2012 leescode. All rights reserved.
//

#import "EditRecipeLocalizationController.h"

@implementation EditRecipeLocalizationController

- (void)dealloc {
  [_recipeNameField release];
  [_preparationTimeLabel release];
  [_categoryLabel release];
  [_preparationLabel release];
  [_photoLabel release];
  [_servingsLabel release];
  [_addIngredientButtonLabel release];
  [_cancelButtonLandscape release];
  [_doneButtonLandscape release];
  [_doneButtonPortrait release];
  [_cancelButtonPortrait release];
  [super dealloc];
}

- (void) didUnload {
  self.recipeNameField = nil;
  self.preparationTimeLabel = nil;
  self.categoryLabel = nil;
  self.preparationLabel = nil;
  self.photoLabel = nil;
  self.servingsLabel = nil;
  self.addIngredientButtonLabel = nil;
  self.cancelButtonLandscape = nil;
  self.cancelButtonPortrait = nil;
  self.doneButtonPortrait = nil;
  self.doneButtonLandscape = nil;
}

- (void) didLoad {
  self.recipeNameField.placeholder = _L(@"RecipeName");
  self.preparationTimeLabel.text = _L(@"PreparationTime");
  self.categoryLabel.text = _L(@"Category");
  self.preparationLabel.text = _L(@"Preparation");
  self.photoLabel.text = _L(@"Photo");
  self.servingsLabel.text= _L(@"Servings");
  self.addIngredientButtonLabel.text = _L(@"AddIngredient");
  
  [self.doneButtonLandscape setTitle:_L(@"Done") forState:UIControlStateNormal];
  [self.doneButtonPortrait setTitle:_L(@"Done") forState:UIControlStateNormal];
  [self.cancelButtonLandscape setTitle:_L(@"Cancel") forState:UIControlStateNormal];
  [self.cancelButtonPortrait setTitle:_L(@"Cancel") forState:UIControlStateNormal];
  
}

@end
