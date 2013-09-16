//
//  Recipe.h
//  RecipeKing
//
//  Created by Lee Irvine on 2/17/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Recipe : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) NSData *photo;
@property (nonatomic, strong) NSString *preparation;
@property (nonatomic, strong) NSString *notes;
@property (nonatomic, strong) NSArray *ingredients;
@property (nonatomic, assign) NSInteger preparationTime;
@property (nonatomic, assign) NSInteger servings;
@property (nonatomic, strong) NSDate *lastEdit;

@end

