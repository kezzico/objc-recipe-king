#import <Foundation/Foundation.h>

@class RecipeListController;
@interface RecipeSearchTableController :  NSObject <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) NSArray *recipes;
@property (assign, nonatomic) IBOutlet RecipeListController *controller;
@end
