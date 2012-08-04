//
//  Ingredient.h
//  RecipeKing
//
//  Created by Lee Irvine on 2/17/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Recipe;

@interface Ingredient : NSManagedObject

@property (nonatomic, retain) NSNumber * index;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * quantity;
@property (nonatomic, retain) Recipe *recipe;

@end
