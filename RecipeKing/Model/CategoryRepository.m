#import "CategoryRepository.h"
#import "Recipe.h"
#import "RecipeCategory.h"

@implementation CategoryRepository

- (NSArray *) allCategories {
  return nil;
}

- (void) add:(NSString *) name {
  if([self categoryForName: name] != nil) return;
  RecipeCategory *category = [[[RecipeCategory alloc] init] autorelease];
}

- (void) remove: (NSString *) name {
  RecipeCategory *category = [self categoryForName: name];
}

- (void) setCategory: (NSString *) name forRecipe: (Recipe *) recipe {
  recipe.category = [self categoryForName:name];
}

- (RecipeCategory *) categoryForName: (NSString *) name {
  
  return nil;
}

@end
