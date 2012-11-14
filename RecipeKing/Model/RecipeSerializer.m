//
//  RecipeSerializer.m
//  RecipeKing
//
//  Created by Lee Irvine on 11/10/12.
//  Copyright (c) 2012 leescode. All rights reserved.
//

#import "RecipeSerializer.h"
#import "Recipe.h"
#import "Ingredient.h"
#import "RecipeCategory.h"
#import "Container.h"
#import "NSArray-Extensions.h"
#import "jsonHelper.h"
#import "NSString-Extensions.h"

typedef struct {
  char magic[4];
  char version[4];
  uint recipesize;
  uint photosize;
} recipeHeader;

@implementation RecipeSerializer

+ (RecipeSerializer *) serializer {
  return [[[RecipeSerializer alloc] init] autorelease];
}

- (void) dealloc {
  [_categoryRepository release];
  [_recipeRepository release];
  [super dealloc];
}

- (id) init {
  if(self = [super init]) {
    self.categoryRepository = [[Container shared] resolve:@protocol(PCategoryRepository)];
    self.recipeRepository = [[Container shared] resolve:@protocol(PRecipeRepository)];
  }
  return self;
}

- (NSData *) serialize: (Recipe *) recipe {
  NSData *recipedata = [self recipeToJson: recipe];
  recipeHeader header;
  memcpy(header.magic, "RCPK", 4);
  memcpy(header.version, "3.0\0", 4);
  header.recipesize = [recipedata length];
  header.photosize = [recipe.photo length];
  
  NSMutableData *serializedrecipe = [NSMutableData dataWithBytes:&header length:sizeof(header)];
  [serializedrecipe appendData: recipedata];
  if(recipe.photo) {
    [serializedrecipe appendData: recipe.photo];
  }
  
  return [NSData dataWithData: serializedrecipe];
}

- (NSData *) recipeToJson:(Recipe *) recipe {
  NSSortDescriptor *ingredientsort = [NSSortDescriptor sortDescriptorWithKey:@"index" ascending:YES];
  NSArray *ingredients = [recipe.ingredients sortedArrayUsingDescriptors:@[ingredientsort]];

  NSDictionary *d = @{
    @"name" : valueOrNull(recipe.name),
    @"category" : valueOrNull(recipe.category.name),
    @"preparation" : valueOrNull(recipe.preparation),
    @"preparationTime" : valueOrNull(recipe.preparationTime),
    @"servings" : valueOrNull(recipe.servings),
    @"ingredients" : [ingredients mapObjects: ^(Ingredient *ingr) {
      return @{
        @"name": valueOrNull(ingr.name),
        @"quantity" : valueOrNull(ingr.quantity)
      };
    }]
  };
  
  return [NSJSONSerialization dataWithJSONObject:d options:0 error:nil];
}

- (Recipe *) restore: (NSData *) data {
  recipeHeader header;
  uint headersize = sizeof(recipeHeader);
  [data getBytes: &header length: headersize];
  
  if(memcmp(header.magic, "RCPK", 4)) return nil;
  
  NSData *recipedata = [data subdataWithRange:NSMakeRange(headersize, header.recipesize)];
  Recipe *recipe = [self recipeFromJson: recipedata];
  
  if(header.photosize > 0) {
    recipe.photo = [data subdataWithRange:NSMakeRange(headersize + header.recipesize, header.photosize)];
  }
  
  return recipe;
}

- (Recipe *) recipeFromJson:(NSData *) data {
  NSDictionary *json = [NSJSONSerialization JSONObjectWithData: data options:0 error: nil];
  NSString *name = [json valueForKey:@"name"];
  
  if(json == nil || name == nil) return nil;

  Recipe *recipe = [_recipeRepository recipeWithName: name];
  
  NSString *category = valueOrNil([json valueForKey:@"category"]);
  [self.categoryRepository setCategory:category forRecipe:recipe];
  
  recipe.preparation = valueOrNil([json valueForKey:@"preparation"]);
  recipe.preparationTime = valueOrNil([json valueForKey:@"preparationTime"]);
  recipe.servings = valueOrNil([json valueForKey:@"servings"]);
  NSArray *ingredients = valueOrNil([json valueForKey:@"ingredients"]);

  for(Ingredient *ig in recipe.ingredients) {
    [recipe.managedObjectContext deleteObject:ig];
  }
  
  for(NSDictionary *ingr in ingredients) {
    NSString *ingredientName = valueOrNil([ingr valueForKey:@"name"]);
    NSString *quantity = valueOrNil([ingr valueForKey:@"quantity"]);
    if([NSString isEmpty: ingredientName]) continue;
    [recipe addIngredientWithName:ingredientName quantity: quantity];
  }
  
  return recipe;
}

@end
