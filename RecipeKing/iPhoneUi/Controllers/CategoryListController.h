#import <UIKit/UIKit.h>
#import "PCategoryRepository.h"

@interface CategoryListController : UITableViewController
@property (retain, nonatomic) NSArray *categories;
@property (retain, nonatomic) id<PCategoryRepository> repository;
@property (copy, nonatomic) void(^onCategorySelected)(NSString *category);
@end
