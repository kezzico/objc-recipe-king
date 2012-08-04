#import "CategoryRepository.h"
#import "ManagedContextFactory.h"
#import "Recipe.h"
#import "Category.h"

@implementation CategoryRepository

- (id) init {
  if((self = [super init])) {
    _context = [[ManagedContextFactory buildContext] retain];
    _entityName = @"Category";
  }
  
  return self;
}

- (void) dealloc {
  [_context release];
  [super dealloc];
}

- (NSArray *) list {
  NSError *error = nil;
  NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
  NSEntityDescription *entity = [NSEntityDescription entityForName: _entityName inManagedObjectContext: _context];
  [fetchRequest setEntity:entity];
    
  NSSortDescriptor *orderByName = [[[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES] autorelease];
  [fetchRequest setSortDescriptors: [NSArray arrayWithObject: orderByName]];
  
  NSArray *fetchedObjects = [_context executeFetchRequest:fetchRequest error: &error];
  
  if(error) { 
    NSLog(@"%@", error);
    return nil;
  }
  
  NSMutableArray *output = [[[NSMutableArray alloc] init] autorelease];  
  for (Category *c in fetchedObjects) {
    [output addObject: c.name];
  }
  
  return output;
}

- (void) add: (NSString *) name {
  if([self categoryForName: name] != nil) return;
  
  Category *category = [NSEntityDescription
    insertNewObjectForEntityForName: _entityName
    inManagedObjectContext: _context];

  NSError *error = nil;
  category.name = name;
  [_context save: &error];
  if(error) NSLog(@"%@", error);
}

- (void) remove: (NSString *) name {
  Category *c = [self categoryForName: name];
  [_context deleteObject: c];
  
  NSError *error = nil;  
  [_context save: &error];
  if(error) NSLog(@"%@", error);
}

- (void) rename: (NSString *) oldname to: (NSString *) newname {
  Category *c = [self categoryForName: oldname];
  if(c == nil) return;
  
  NSError *error = nil;
  c.name = newname;
  [_context save: &error];
  if(error) NSLog(@"%@", error);

}

- (void) setCategory: (NSString *) name forRecipe: (Recipe *) recipe {
  NSManagedObjectContext *context = recipe.managedObjectContext;
  recipe.Category = [self categoryForName: name inContext: context];
}

- (Category *) categoryForName: (NSString *) name {
  return [self categoryForName: name inContext: _context];
}

- (Category *) categoryForName: (NSString *) name inContext: (NSManagedObjectContext *) context {
  NSError *error = nil;
  NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
  NSEntityDescription *entity = [NSEntityDescription entityForName: _entityName inManagedObjectContext: context];
  NSPredicate *predicate = [NSPredicate predicateWithFormat: @"name matches[c] %@", name];
  
  [fetchRequest setEntity:entity];
  [fetchRequest setPredicate: predicate];
  
  NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error: &error];
  [fetchRequest release];
  
  if(error) {
    NSLog(@"%@", error);
    return nil;
  }
    
  if([fetchedObjects count] > 0) return [fetchedObjects objectAtIndex: 0];
  return nil;
}

@end
