//
//  StorageMediator.h
//  RecipeKing
//
//  Created by Lee Irvine on 9/13/13.
//  Copyright (c) 2013 Lee Irvine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RecipeStorage.h"

@interface RecipeStorageMediator : NSObject
@property (nonatomic, strong) id<RecipeStorage> localStorage;
@property (nonatomic, strong) id<RecipeStorage> remoteStorage;
@end
