//
//  RecipeViewModel.h
//  RecipeKing
//
//  Created by Lee Irvine on 8/4/12.
//  Copyright (c) 2012 leescode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface RecipeViewModel : NSObject
@property (nonatomic, retain) NSManagedObjectID *recipeId;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *category;
@property (nonatomic, retain) NSString *cookTemperature;
@property (nonatomic, retain) NSString *preparation;

@property (nonatomic) NSInteger preparationTime;
@property (nonatomic) NSInteger cookTime;
@property (nonatomic) NSInteger sitTime;
@property (nonatomic) NSInteger servings;

@property (nonatomic, retain) UIImage *photo;
@property (nonatomic, retain) UIImage *photoThumbnail;
@property (nonatomic, retain) NSArray *ingredients;

@end
