//
//  RecipeRepository.h
//  RecipeKing
//
//  Created by Lee Irvine on 2/17/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PRecipeRepository.h"
@class RecipePersister;
@interface RecipeRepository : NSObject <PRecipeRepository>
@property (nonatomic, retain) NSMutableArray *trackedRecipes;
@property (nonatomic, retain) RecipePersister *persister;
@end
