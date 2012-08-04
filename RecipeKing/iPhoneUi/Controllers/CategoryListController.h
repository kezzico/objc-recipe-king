#import <UIKit/UIKit.h>

@protocol PCategoryRepository;
@interface CategoryListController : UITableViewController {
  NSArray *_categories;
}

@property (retain, nonatomic) IBOutlet NSObject<PCategoryRepository> *repository;

@end
