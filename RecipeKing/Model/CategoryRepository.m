#import "CategoryRepository.h"
#import "ManagedContextFactory.h"
#import "Recipe.h"
#import "RecipeCategory.h"

static NSString *categoryEntityName = @"RecipeCategory";
@implementation CategoryRepository
@synthesize context;

- (void) dealloc {
  [context release];
  [super dealloc];
}

- (id) init {
  if((self = [super init])) {
    self.context = [ManagedContextFactory buildContext];
  }
  return self;
}

- (NSArray *) allCategories {
  NSError *error = nil;
  NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
  NSEntityDescription *entity = [NSEntityDescription entityForName: categoryEntityName inManagedObjectContext: self.context];
  [fetchRequest setEntity:entity];
    
  NSSortDescriptor *orderByName = [[[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES selector:@selector(caseInsensitiveCompare:)] autorelease];
  [fetchRequest setSortDescriptors: [NSArray arrayWithObject: orderByName]];
  
  NSArray *fetchedObjects = [self.context executeFetchRequest:fetchRequest error: &error];
  
  if(error) { 
    NSLog(@"%@", error);
    return nil;
  }
  
  NSMutableArray *output = [[[NSMutableArray alloc] init] autorelease];  
  for (RecipeCategory *c in fetchedObjects) {
    [output addObject: c.name];
  }
  
  return output;
}

- (void) add: (NSString *) name {
  if([self categoryForName: name] != nil) return;
  
  RecipeCategory *category = [NSEntityDescription
    insertNewObjectForEntityForName: categoryEntityName
    inManagedObjectContext: self.context];

  NSError *error = nil;
  category.name = name;
  [self.context save: &error];
  if(error) NSLog(@"%@", error);
}

- (void) remove: (NSString *) name {
  RecipeCategory *c = [self categoryForName: name];
  [self.context deleteObject: c];
  
  NSError *error = nil;  
  [self.context save: &error];
  if(error) NSLog(@"%@", error);
}

- (void) rename: (NSString *) oldname to: (NSString *) newname {
  RecipeCategory *c = [self categoryForName: oldname];
  if(c == nil) return;
  
  NSError *error = nil;
  c.name = newname;
  [self.context save: &error];
  if(error) NSLog(@"%@", error);

}

- (void) setCategory: (NSString *) name forRecipe: (Recipe *) recipe {
  NSManagedObjectContext *ctx = recipe.managedObjectContext;
  recipe.Category = [self categoryForName: name inContext: ctx];
}

- (RecipeCategory *) categoryForName: (NSString *) name {
  return [self categoryForName: name inContext: self.context];
}

- (RecipeCategory *) categoryForName: (NSString *) name inContext: (NSManagedObjectContext *) ctx {
  if(name == nil) return nil;
  
  NSError *error = nil;
  NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
  NSEntityDescription *entity = [NSEntityDescription entityForName: categoryEntityName inManagedObjectContext: ctx];
  NSPredicate *predicate = [NSPredicate predicateWithFormat: @"name matches[c] %@", name];
  
  [fetchRequest setEntity:entity];
  [fetchRequest setPredicate: predicate];
  
  NSArray *fetchedObjects = [ctx executeFetchRequest:fetchRequest error: &error];
  [fetchRequest release];
  
  if(error) {
    NSLog(@"%@", error);
    return nil;
  }
    
  if([fetchedObjects count] > 0) return [fetchedObjects objectAtIndex: 0];
  return nil;
}

@end
