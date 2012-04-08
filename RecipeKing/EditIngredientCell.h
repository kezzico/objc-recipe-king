//
//  IngredientCellCell.h
//  RecipeKing
//
//  Created by Lee Irvine on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IngredientViewModel;
@interface EditIngredientCell : UITableViewCell

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier;
- (IBAction)nameChanged;
- (IBAction)quantityChanged;

@property (nonatomic, retain) IBOutlet UIView *view;
@property (nonatomic, retain) IBOutlet UITextField *quantityField;
@property (nonatomic, retain) IBOutlet UITextField *nameField;
@property (nonatomic, retain) IngredientViewModel *viewModel;
@end
