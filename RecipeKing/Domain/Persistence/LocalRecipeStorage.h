//
//  RecipeRepository.h
//  RecipeKing
//
//  Created by Lee Irvine on 9/13/13.
//  Copyright (c) 2013 Lee Irvine. All rights reserved.
//

#import "Repository.h"
#import "RecipeStorage.h"

@class DBDatastore;
@interface LocalRecipeStorage : Repository <RecipeStorage>

@end
