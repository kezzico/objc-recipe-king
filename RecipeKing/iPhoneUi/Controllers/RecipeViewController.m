//
//  RecipeViewController.m
//  RecipeKing
//
//  Created by Lee Irvine on 4/25/12.
//  Copyright (c) 2012 leescode. All rights reserved.
//

#import "RecipeViewController.h"

@interface RecipeViewController ()

@end

@implementation RecipeViewController
@synthesize titleCell;
@synthesize imageCell;
@synthesize recipe=_recipe;

- (void)viewDidLoad {
  [super viewDidLoad];
  
  _cells = [[NSArray arrayWithObjects: titleCell, imageCell, nil] retain];
}

- (void)viewDidUnload {
  [self setTitleCell:nil];
  [self setImageCell:nil];
  [super viewDidUnload];
}

- (void)dealloc {
  [_recipe release];
  [_cells release];
  [titleCell release];
  [imageCell release];
  [super dealloc];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [_cells count];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [_cells objectAtIndex: indexPath.row];
  UIView *subview = [cell.contentView.subviews objectAtIndex: 0];
  return subview.frame.size.height;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  return [_cells objectAtIndex: indexPath.row];
}

@end
