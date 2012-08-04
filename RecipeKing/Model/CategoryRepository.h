#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PCategoryRepository.h"

@class Category;
@interface CategoryRepository : NSObject <PCategoryRepository> {
  NSManagedObjectContext *_context;
  NSString *_entityName;
}

- (Category *) categoryForName: (NSString *) name;
- (Category *) categoryForName: (NSString *) name inContext: (NSManagedObjectContext *) context;
@end
