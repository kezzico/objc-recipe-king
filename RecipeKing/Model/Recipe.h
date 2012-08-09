//
//  Recipe.h
//  RecipeKing
//
//  Created by Lee Irvine on 2/17/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class RecipeCategory, Ingredient;

@interface Recipe : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) RecipeCategory *category;
@property (nonatomic, retain) NSData * photo;
@property (nonatomic, retain) NSString * preparation;
@property (nonatomic, retain) NSSet *ingredients;
@property (nonatomic, retain) NSNumber * preparationTime;
@property (nonatomic, retain) NSNumber * servings;
@end

@interface Recipe (CoreDataGeneratedAccessors)

- (void)addIngredientsObject:(Ingredient *)value;
- (void)addIngredientWithName:(NSString *) name quantity:(NSString *) quantity;
- (Ingredient *)ingredientAtIndex:(NSInteger) index;
- (void)removeIngredientsObject:(Ingredient *)value;
- (void)addIngredients:(NSSet *)values;
- (void)removeIngredients:(NSSet *)values;
@end
