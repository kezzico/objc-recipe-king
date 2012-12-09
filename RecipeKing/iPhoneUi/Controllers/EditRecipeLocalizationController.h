//
//  LocalizationController.h
//  RecipeKing
//
//  Created by Lee Irvine on 11/23/12.
//  Copyright (c) 2012 leescode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EditRecipeLocalizationController : NSObject
@property (retain, nonatomic) IBOutlet UITextField *recipeNameField;
@property (retain, nonatomic) IBOutlet UILabel *preparationTimeLabel;
@property (retain, nonatomic) IBOutlet UILabel *categoryLabel;
@property (retain, nonatomic) IBOutlet UILabel *preparationLabel;
@property (retain, nonatomic) IBOutlet UILabel *photoLabel;
@property (retain, nonatomic) IBOutlet UILabel *servingsLabel;
@property (retain, nonatomic) IBOutlet UILabel *addIngredientButtonLabel;
@property (retain, nonatomic) IBOutlet UIButton *cancelButtonLandscape;
@property (retain, nonatomic) IBOutlet UIButton *cancelButtonPortrait;
@property (retain, nonatomic) IBOutlet UIButton *doneButtonLandscape;
@property (retain, nonatomic) IBOutlet UIButton *doneButtonPortrait;
- (void) didLoad;
- (void) didUnload;

@end
