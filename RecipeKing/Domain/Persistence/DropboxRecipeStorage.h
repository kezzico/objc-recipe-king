//
//  DropboxRecipeStorage.h
//  RecipeKing
//
//  Created by Lee Irvine on 9/13/13.
//  Copyright (c) 2013 Lee Irvine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RecipeStorage.h"
@class DBDatastore;
@interface DropboxRecipeStorage : NSObject <RecipeStorage>
@property (nonatomic, strong) DBDatastore *datastore;
@end
