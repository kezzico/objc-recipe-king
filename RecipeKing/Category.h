//
//  Category.h
//  RecipeKing
//
//  Created by Lee Irvine on 2/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Recipe;

@interface Category : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *recipes;
@end

@interface Category (CoreDataGeneratedAccessors)

- (void)addRecipesObject:(Recipe *)value;
- (void)removeRecipesObject:(Recipe *)value;
- (void)addRecipes:(NSSet *)values;
- (void)removeRecipes:(NSSet *)values;
@end
