//
//  Recipe.h
//  RecipeKing
//
//  Created by Lee Irvine on 2/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Category, Ingredient;

@interface Recipe : NSManagedObject

@property (nonatomic, retain) NSString * cookTemperature;
@property (nonatomic, retain) NSString * cookTime;
@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) NSString * instructions;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Category *category;
@property (nonatomic, retain) NSSet *ingredients;
@end

@interface Recipe (CoreDataGeneratedAccessors)

- (void)addIngredientsObject:(Ingredient *)value;
- (void)removeIngredientsObject:(Ingredient *)value;
- (void)addIngredients:(NSSet *)values;
- (void)removeIngredients:(NSSet *)values;
@end
