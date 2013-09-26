//
//  RootViewController.h
//  RecipeKing
//
//  Created by Lee Irvine on 9/15/13.
//  Copyright (c) 2013 Lee Irvine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSArray *recipes;
@end
