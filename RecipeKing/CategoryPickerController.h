//
//  CategoryPickerController.h
//  RecipeKing
//
//  Created by Lee Irvine on 3/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryPickerController : NSObject <UIPickerViewDataSource, UIPickerViewDelegate> {
  UITextField *_categoryInput;
}
@property (nonatomic, retain) NSArray *categories;
@property (nonatomic, retain) IBOutlet UIPickerView *categoryPicker;
- (void) setCategoryInput: (UITextField *) input;
- (void) categoriesDidChange;
@end
