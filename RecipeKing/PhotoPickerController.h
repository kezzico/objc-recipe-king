//
//  PhotoService.h
//  RecipeKing
//
//  Created by Lee Irvine on 1/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PhotoPickerDelegate <NSObject>
- (void) imageSelected: (UIImage *) image;
@end

@interface PhotoPicker : NSObject <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate> {
    UIActionSheet *imageOptions;
    UIViewController <PhotoPickerDelegate> *delegate;
    UIImage *recipeImage;
}

- (IBAction) imagePressed;
- (void) setup;
@property (nonatomic, retain) UIViewController <PhotoPickerDelegate> *delegate;


@end
