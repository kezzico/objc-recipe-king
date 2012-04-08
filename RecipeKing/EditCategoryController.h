//
//  EditCategoryController.h
//  RecipeKing
//
//  Created by Lee Irvine on 3/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UINavigationBarSkinned;
@interface EditCategoryController : UIViewController <UINavigationBarDelegate>
- (IBAction)categoryChanged;
- (IBAction)doneTouched;
- (IBAction)cancelTouched;

@property (retain, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (retain, nonatomic) IBOutlet UINavigationBarSkinned *navigationBar;
@property (retain, nonatomic) IBOutlet UITextField *categoryInput;
@property (retain, nonatomic) NSString *categoryValue;
@property (copy, nonatomic) void (^onDoneTouched)( NSString *value);
@end
