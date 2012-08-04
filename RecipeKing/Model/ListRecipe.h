//
//  ListRecipe.h
//  RecipeKing
//
//  Created by Lee Irvine on 2/19/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface ListRecipe : NSObject

@property (nonatomic, retain) NSManagedObjectID *recipeId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *cookTime;

@end
