//
//  RecipeViewModel.h
//  RecipeKing
//
//  Created by Lee Irvine on 2/5/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EditRecipeViewModel : NSObject
@property (nonatomic, retain) NSString *recipeId;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *category;
@property (nonatomic, retain) NSString *preparation;
@property (nonatomic) NSInteger preparationTime;
@property (nonatomic) NSInteger servings;
@property (nonatomic, retain) UIImage *photo;
@property (nonatomic, retain) NSMutableArray *ingredients;

@end
