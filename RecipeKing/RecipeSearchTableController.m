#import "RecipeSearchTableController.h"
#import "RecipeListController.h"
#import "ListRecipe.h"

@implementation RecipeSearchTableController
@synthesize recipes = _recipes;
@synthesize controller=_controller;

- (void) dealloc {
  [_recipes release];
  [super dealloc];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [_recipes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *cellIdentifier = @"RecipeSearchCell";  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
  if (cell == nil) {
    cell = [[[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: cellIdentifier] autorelease];
  }
  
  ListRecipe *recipe = [_recipes objectAtIndex: indexPath.row];
  cell.textLabel.text = recipe.name;
  return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  ListRecipe *recipe = [_recipes objectAtIndex: indexPath.row];
  [_controller recipeTouched: recipe];
}

@end
