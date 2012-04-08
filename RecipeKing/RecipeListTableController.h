//
//  RecipeListTable.h
//  RecipeKing
//
//  Created by Lee Irvine on 2/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RecipeListController;
@interface RecipeListTableController : NSObject <UITableViewDataSource, UITableViewDelegate>
@property (assign, nonatomic) IBOutlet RecipeListController *controller;
@end
