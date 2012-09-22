//
//  Recipe.h
//  RecipeKing
//
//  Created by Lee Irvine on 2/17/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RecipeCategory, Ingredient;

@interface Recipe : NSObject

@property (nonatomic, retain) NSString *recipeId;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) RecipeCategory *category;
@property (nonatomic, retain) NSData *photo;
@property (nonatomic, retain) NSString *preparation;
@property (nonatomic, retain) NSArray *ingredients;
@property (nonatomic, retain) NSNumber *preparationTime;
@property (nonatomic, retain) NSNumber *servings;
@end