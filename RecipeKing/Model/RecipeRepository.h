//
//  RecipeRepository.h
//  RecipeKing
//
//  Created by Lee Irvine on 2/17/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PRecipeRepository.h"
@interface RecipeRepository : NSObject <PRecipeRepository>
@property (nonatomic, retain) NSManagedObjectContext *context;

@end
