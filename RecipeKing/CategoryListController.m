#import "CategoryListController.h"
#import "CategoryRepository.h"
#import "EditCategoryController.h"

@interface CategoryListController()
- (void) showCategoryEditorWithValue: (NSString *) oldvalue;
- (void) refreshCategories;
@end

@implementation CategoryListController
@synthesize repository = _repository;
- (void) dealloc {
  [_categories release];
  [_repository release];
  [super dealloc];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self refreshCategories];  
  self.clearsSelectionOnViewWillAppear = YES;
  UIBarButtonItem *addButton = [[UIBarButtonItem alloc] 
                                initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self 
                                action:@selector(addCategoryTouched)];
  
  self.navigationItem.rightBarButtonItem = [addButton autorelease];
}

- (void) showCategoryEditorWithValue: (NSString *) oldvalue {
  EditCategoryController *editCategory = [[[EditCategoryController alloc] initWithNibName: @"EditCategoryController" bundle: nil] autorelease];  
  
  editCategory.categoryValue = oldvalue;  
  editCategory.onDoneTouched = ^(NSString *value) {
    if([oldvalue length]) {
      [_repository rename:oldvalue to:value];
    } else {
      [_repository add: value];      
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName: @"categoryListChanged" object: self];
    [self refreshCategories];
    [self.tableView reloadData];
  };
  
  [self presentModalViewController: editCategory animated: YES];
}

- (void) refreshCategories {
  [_categories autorelease];
  _categories = [[_repository list] retain];  
}

- (void) addCategoryTouched {
  [self showCategoryEditorWithValue: @""];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  NSString *oldValue = [_categories objectAtIndex: indexPath.row];
  [self showCategoryEditorWithValue: oldValue];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [_categories count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *cellIdentifier = @"CategoryListCell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  if(cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: cellIdentifier];
  }
  
  cell.textLabel.text = [_categories objectAtIndex: indexPath.row];
  return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {    
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    [_repository remove: [_categories objectAtIndex: indexPath.row]];
    [self refreshCategories];
    [tableView deleteRowsAtIndexPaths: [NSArray arrayWithObject: indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [[NSNotificationCenter defaultCenter] postNotificationName: @"categoryChange" object: self];
  }
}

- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
  return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
