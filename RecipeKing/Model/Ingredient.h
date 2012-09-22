//
//  Ingredient.h
//  RecipeKing
//
//  Created by Lee Irvine on 2/17/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ingredient : NSObject
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *quantity;
+ (Ingredient *) ingredientWithName:(NSString *) name quantity:(NSString *) quantity;
@end
