#import <UIKit/UIKit.h>
#import "PCategoryRepository.h"
#import "PRecipeRepository.h"

@interface CategoryListController : UITableViewController
@property (retain, nonatomic) NSArray *categories;
@property (retain, nonatomic) id<PCategoryRepository> repository;
@property (retain, nonatomic) id<PRecipeRepository> recipeRepository;
@property (copy, nonatomic) void(^onCategorySelected)(NSString *category);
@end
