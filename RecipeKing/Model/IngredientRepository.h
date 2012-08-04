//
//  IngredientRepository.h
//  RecipeKing
//
//  Created by Lee Irvine on 2/19/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PIngredientRepository.h"

@interface IngredientRepository : NSObject <PIngredientRepository> {
  NSString *_entityName;
}

@end
