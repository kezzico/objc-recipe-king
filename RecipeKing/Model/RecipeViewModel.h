//
//  RecipeViewModel.h
//  RecipeKing
//
//  Created by Lee Irvine on 8/4/12.
//  Copyright (c) 2012 leescode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecipeViewModel : NSObject
@property (nonatomic, retain) NSString *recipeId;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *category;
@property (nonatomic, retain) NSString *cookTemperature;
@property (nonatomic, retain) NSString *preparation;

@property (nonatomic) NSInteger preparationTime;
@property (nonatomic) NSInteger cookTime;
@property (nonatomic) NSInteger sitTime;
@property (nonatomic) NSInteger servings;
@property (nonatomic) CGFloat widestQuantity;

@property (nonatomic, retain) UIImage *photo;
@property (nonatomic, retain) UIImage *photoThumbnail;
@property (nonatomic, retain) NSArray *ingredients;

@end
