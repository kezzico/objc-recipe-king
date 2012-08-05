#import <Foundation/Foundation.h>
#import "PRecipeRepository.h"

@class RecipeListController;
@class ListRecipe;
@interface RecipeListSearchController : NSObject <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
@property (nonatomic, retain) NSArray *recipes;
@property (nonatomic, retain) id<PRecipeRepository> repository;
@property (nonatomic, copy) void(^recipeSelected)(ListRecipe *recipe);
@property (retain, nonatomic) IBOutlet UISearchDisplayController *searchController;
@end
