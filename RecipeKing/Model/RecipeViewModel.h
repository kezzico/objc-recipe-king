//
//  RecipeViewModel.h
//  RecipeKing
//
//  Created by Lee Irvine on 2/5/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@interface RecipeViewModel : NSObject

@property (nonatomic, retain) NSString *preperationTime;
@property (nonatomic, retain) NSString *sitTime;
@property (nonatomic, retain) NSManagedObjectID *recipeId;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *category;
@property (nonatomic, retain) NSString *cookTime;
@property (nonatomic, retain) NSString *cookTemperature;
@property (nonatomic, retain) NSString *preperation;
@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) UIImage *image_tn;
@property (nonatomic, retain) NSMutableArray *ingredients;
@property (nonatomic) NSInteger servings;
@end
