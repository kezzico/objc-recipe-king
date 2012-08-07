#import "CategoryListController.h"
#import "CategoryRepository.h"
#import "EditCategoryViewController.h"
#import "ControllerFactory.h"
#import "Container.h"

@implementation CategoryListController
@synthesize repository=_repository;
@synthesize categories=_categories;
@synthesize onCategorySelected;
- (void) dealloc {
  [_categories release];
  [_repository release];
  [onCategorySelected release];
  [super dealloc];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.navigationItem setHidesBackButton:YES animated:NO];
  self.repository = [[Container shared] resolve:@protocol(PCategoryRepository)];
  [self refreshCategories];
  [self createAddCategoryButton];
}

- (void) createAddCategoryButton {
  UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
    initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self
    action:@selector(addCategoryTouched)];
  
  self.navigationItem.rightBarButtonItem = [addButton autorelease];
  
}

- (void) addCategoryTouched {
  EditCategoryViewController *vc = [ControllerFactory buildEditCategoryViewController];
  [self presentViewController: vc animated: YES completion:nil];
  
  vc.existingCategories = _categories;
  vc.onDoneTouched = ^(NSString *value) {
    [_repository add: value];
    [self refreshCategories];
  };
}

- (void) refreshCategories {
  self.categories = [_repository allCategories];
  [self.tableView reloadData];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  NSInteger r = indexPath.row;
  NSString *value = r == [_categories count] ? nil : [_categories objectAtIndex: r];
  [self.navigationController popViewControllerAnimated:YES];
  onCategorySelected(value);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self.categories count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *cellIdentifier = @"CategoryListCell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  if(cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: cellIdentifier];
  }
  
  NSInteger r = indexPath.row;
  cell.textLabel.text = r == [_categories count] ? @"None" : [_categories objectAtIndex: r];
  return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {    
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    [_repository remove: [_categories objectAtIndex: indexPath.row]];
    self.categories = [_repository allCategories];
    [tableView deleteRowsAtIndexPaths: [NSArray arrayWithObject: indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [[NSNotificationCenter defaultCenter] postNotificationName: @"categoryChange" object: self];
  }
}

- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
  return indexPath.row != [_categories count];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
