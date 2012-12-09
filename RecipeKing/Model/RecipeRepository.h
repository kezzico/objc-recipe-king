//
//  RecipeRepository.h
//  RecipeKing
//
//  Created by Lee Irvine on 2/17/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import "PRecipeRepository.h"
#import "Repository.h"
#import "DirectoryWatcher.h"

@interface RecipeRepository : Repository <PRecipeRepository, DirectoryWatcherDelegate>
@property (nonatomic, retain) DirectoryWatcher *directoryWatcher;
- (NSURL *) urlForRecipeName:(NSString *) name;
@end
