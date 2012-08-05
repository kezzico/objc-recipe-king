//
//  RecipeViewModel.h
//  RecipeKing
//
//  Created by Lee Irvine on 2/5/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@interface EditRecipeViewModel : NSObject
@property (nonatomic, retain) NSManagedObjectID *recipeId;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *category;
@property (nonatomic, retain) NSString *cookTemperature;
@property (nonatomic, retain) NSString *preperation;

@property (nonatomic) NSInteger preperationTime;
@property (nonatomic) NSInteger cookTime;
@property (nonatomic) NSInteger sitTime;
@property (nonatomic) NSInteger servings;

@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) NSMutableArray *ingredients;

@end
