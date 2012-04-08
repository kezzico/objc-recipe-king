//
//  ExtraFieldsController.m
//  RecipeKing
//
//  Created by Lee Irvine on 4/7/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import "ExtraFieldsController.h"

@implementation ExtraFieldsController
@synthesize fields=_fields;
@synthesize onFieldChosen;

- (id) init {
  return self = [super initWithStyle: UITableViewStylePlain];
}

- (void) dealloc {
  [onFieldChosen release];
  [_fields release];
  [super dealloc];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] 
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemCancel 
                                   target:self action:@selector(cancelTouched)];
  
  self.navigationItem.leftBarButtonItem = [cancelButton autorelease];
}

- (void) cancelTouched {
  [self.navigationController popViewControllerAnimated: YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [_fields count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *cellIdentifier = @"addFieldCell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  if(cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: cellIdentifier];
  }
  cell.textLabel.text = [_fields objectAtIndex: indexPath.row];
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  NSObject *selection = [_fields objectAtIndex: indexPath.row];
  onFieldChosen(selection);
  [self.navigationController popViewControllerAnimated: YES];
}

@end
