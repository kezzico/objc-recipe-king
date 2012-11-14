//
//  PCategoryRepository.h
//  RecipeKing
//
//  Created by Lee Irvine on 2/17/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Recipe;
@protocol PCategoryRepository <NSObject>
- (NSArray *) categories;
- (void) add: (NSString *) name;
- (void) remove: (NSString *) name;
- (void) setCategory: (NSString *) name forRecipe: (Recipe *) recipe;
- (void) addDefaultCategories;
@end
