#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PCategoryRepository.h"

@class RecipeCategory;
@interface CategoryRepository : NSObject <PCategoryRepository>
@property (nonatomic, retain) NSManagedObjectContext *context;
- (RecipeCategory *) categoryForName: (NSString *) name;
- (RecipeCategory *) categoryForName: (NSString *) name inContext: (NSManagedObjectContext *) context;
@end
