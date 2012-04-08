//
//  RecipeRepository.h
//  RecipeKing
//
//  Created by Lee Irvine on 2/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PRecipeRepository.h"
@interface RecipeRepository : NSObject <PRecipeRepository> {
  NSManagedObjectContext *_context;
  NSString *_entityName;
}

@end
