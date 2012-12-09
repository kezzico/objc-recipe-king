#import <UIKit/UIKit.h>
#import "PCategoryRepository.h"
#import "PRecipeRepository.h"
#import "ContentViewController.h"
@interface CategoryListController : ContentViewController <UITableViewDataSource, UITableViewDelegate>
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) NSArray *categories;
@property (retain, nonatomic) id<PCategoryRepository> repository;
@property (retain, nonatomic) id<PRecipeRepository> recipeRepository;
@property (retain, nonatomic) NSString *selectedCategory;
@property (copy, nonatomic) void(^onCategorySelected)(NSString *category);
@end
