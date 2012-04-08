//
//  ExtraFieldsController.h
//  RecipeKing
//
//  Created by Lee Irvine on 4/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExtraFieldsController : UITableViewController

@property (nonatomic, retain) NSArray *fields;
@property (nonatomic, copy) void (^onFieldChosen)(NSObject *field);

@end
