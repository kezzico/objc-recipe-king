#import "CategoryRepository.h"
#import "ManagedContextFactory.h"
#import "NSArray-Extensions.h"
#import "Recipe.h"
#import "RecipeCategory.h"

@implementation CategoryRepository

- (NSArray *) categories {
  NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES selector:@selector(caseInsensitiveCompare:)];
  NSArray *categories = [self entitiesNamed:@"RecipeCategory" sortWith:@[sortByName]];
  return [categories mapObjects:^(RecipeCategory *category) {
    return category.name;
  }];
}

- (void) add: (NSString *) name {
  [self categoryWithName: name];
  [self save];
}

- (void) remove: (NSString *) name {
  RecipeCategory *c = [self categoryWithName: name];
  [self removeEntity: c];
}

- (void) setCategory: (NSString *) name forRecipe: (Recipe *) recipe {
  [self swapContext:recipe.managedObjectContext andDo:^{
    recipe.Category = [self categoryWithName: name];
  }];
}

- (RecipeCategory *) categoryWithName:(NSString *) name {
  if(name == nil) return nil;
  
  RecipeCategory *category = (RecipeCategory *)[self firstEntityNamed:@"RecipeCategory" withAttribute:@"name" equalTo:name];
  if(category == nil) {
    category = (RecipeCategory *)[self insertEntityWithName:@"RecipeCategory"];
    category.name = name;
  }
  
  return category;
}

@end
