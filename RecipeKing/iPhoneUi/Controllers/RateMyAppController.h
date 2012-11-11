//
//  RateMyAppController.h
//  RecipeKing
//
//  Created by Lee Irvine on 8/8/12.
//  Copyright (c) 2012 leescode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PRecipeRepository.h"

@interface RateMyAppController : NSObject
@property (nonatomic, retain) id<PRecipeRepository> repository;
@end
