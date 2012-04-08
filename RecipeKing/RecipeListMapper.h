//
//  RecipeListMapper.h
//  RecipeKing
//
//  Created by Lee Irvine on 2/19/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecipeListMapper : NSObject
- (NSArray *) recipeListToViewModel: (NSArray *) recipes;

@end
