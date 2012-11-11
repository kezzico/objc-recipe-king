#import "Recipe.h"
#import "RecipeListSearchController.h"
#import "RecipeListMapper.h"
#import "ListRecipe.h"
#import "ControllerFactory.h"
#import "Container.h"
#import "NSArray-Extensions.h"

@implementation RecipeListSearchController
@synthesize searchController=_searchController;
@synthesize recipes=_recipes;
@synthesize repository=_repository;
@synthesize recipeSelected;

- (void) dealloc {
  [recipeSelected release];
  [_recipes release];
  [_searchController release];
  [_repository release];
  [super dealloc];
}

- (void) awakeFromNib {
  self.repository = [[Container shared] resolve:@protocol(PRecipeRepository)];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self.recipes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *cellIdentifier = @"RecipeSearchCell";  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
  if (cell == nil) {
    cell = [[[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: cellIdentifier] autorelease];
  }
  
  ListRecipe *recipe = [self.recipes objectAtIndex: indexPath.row];
  cell.textLabel.text = recipe.name;
  return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  ListRecipe *recipe = [self.recipes objectAtIndex: indexPath.row];
  recipeSelected(recipe);
  [self.searchController setActive: NO animated:YES];
}

- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
  NSArray *recipes = [self.repository filter: searchText];
  self.recipes = [recipes mapObjects:^(Recipe *r) {
    ListRecipe *recipe = [[[ListRecipe alloc] init] autorelease];
    recipe.name = r.name;
    recipe.recipeId = r.objectID;
    return recipe;
  }];
}

@end
