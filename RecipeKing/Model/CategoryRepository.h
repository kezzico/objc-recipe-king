#import <Foundation/Foundation.h>
#import "PCategoryRepository.h"

@class RecipeCategory;
@interface CategoryRepository : NSObject <PCategoryRepository>
- (RecipeCategory *) categoryForName: (NSString *) name;
@end
