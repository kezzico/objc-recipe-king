//
//  EditPreperationController.h
//  RecipeKing
//
//  Created by Lee Irvine on 4/7/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditPreperationController : UIViewController

- (void) setPreperationText: (NSString *) value;
@property (copy, nonatomic) void (^onDoneTouched)( NSString *value);
@end
