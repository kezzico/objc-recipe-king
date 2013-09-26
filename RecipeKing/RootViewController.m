//
//  RootViewController.m
//  RecipeKing
//
//  Created by Lee Irvine on 9/15/13.
//  Copyright (c) 2013 Lee Irvine. All rights reserved.
//

#import "RootViewController.h"
#import "UIColor+Extensions.h"
@implementation RootViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"Recipe King";
  self.navigationController.navigationBar.barTintColor = [UIColor colorWithHex:@"84410aff"];
  self.recipes = @[
    @"Pasta",
    @"Brownies",
    @"Cake",
    @"Cookies",
    @"Pizza",
    @"Cinnamon Rolls"
  ];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self.recipes count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
  cell.textLabel.text = self.recipes[indexPath.row];
  
  return cell;
}

@end
