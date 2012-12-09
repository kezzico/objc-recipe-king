//
//  PhotoPicker.h
//  RecipeKing
//
//  Created by Lee Irvine on 8/6/12.
//  Copyright (c) 2012 leescode. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PhotoPicker;
@interface PhotoPicker : NSObject <UINavigationControllerDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate> {
  NSInteger takePhotoIndex, choosePhotoIndex, removePhotoIndex;
}
@property (retain, nonatomic) UIActionSheet *photoSourceOptions;
@property (retain, nonatomic) UIViewController *controller;
@property (nonatomic) BOOL showRemovePhotoOption;
@property (copy, nonatomic) void(^onImageChosen)(UIImage *photo);
- (void) showPicker;
@end
