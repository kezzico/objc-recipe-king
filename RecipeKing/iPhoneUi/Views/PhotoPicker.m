//
//  PhotoPicker.m
//  RecipeKing
//
//  Created by Lee Irvine on 8/6/12.
//  Copyright (c) 2012 leescode. All rights reserved.
//

#import "PhotoPicker.h"

@implementation PhotoPicker
@synthesize photoSourceOptions=_photoSourceOptions;
@synthesize controller=_controller;
@synthesize showRemovePhotoOption=_showRemovePhotoOption;
@synthesize onImageChosen;

- (void) dealloc {
  [_controller release];
  [_photoSourceOptions release];
  [onImageChosen release];
  [super dealloc];
}

- (void) setupPhotoSourceOptions {
  self.photoSourceOptions = [[[UIActionSheet alloc] init] autorelease];
  
  NSInteger cancelIndex = 1;
  
  takePhotoIndex = 0;
  choosePhotoIndex = 1;
  removePhotoIndex = 2;
  
  if([self isCameraAvailable] == YES) {
    [_photoSourceOptions addButtonWithTitle: @"Take Photo"];
    cancelIndex++;
  } else {
    takePhotoIndex = -1;
    choosePhotoIndex--;
    removePhotoIndex--;
  }
  
  [_photoSourceOptions addButtonWithTitle: @"Choose Photo"];
  
  if(self.showRemovePhotoOption == YES) {
    [_photoSourceOptions addButtonWithTitle: @"Remove Photo"];
    cancelIndex++;
  } else {
    removePhotoIndex = -1;
  }
  
  [_photoSourceOptions addButtonWithTitle: @"Cancel"];
  _photoSourceOptions.cancelButtonIndex = cancelIndex;
  _photoSourceOptions.delegate = self;
}

- (void) showPicker {
  [self setupPhotoSourceOptions];
  if([self isCameraAvailable] == NO && self.showRemovePhotoOption == NO) {
    [self showSavedPhotoLibrary];
  } else {
    [_photoSourceOptions showInView: self.controller.view];
  }
}

- (BOOL) isCameraAvailable {
  return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (void) showSavedPhotoLibrary {
  UIImagePickerController *imagePicker = [[[UIImagePickerController alloc] init] autorelease];
  imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
  imagePicker.delegate = self;
  [self.controller presentViewController: imagePicker animated:YES completion:^{}];
}

- (void) showCamera {
  UIImagePickerController *imagePicker = [[[UIImagePickerController alloc] init] autorelease];
  imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
  imagePicker.delegate = self;
  [self.controller presentViewController: imagePicker animated:YES completion:^{}];
}

- (void) actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger) buttonIndex {
  if(buttonIndex == takePhotoIndex) [self showCamera];
  if(buttonIndex == choosePhotoIndex) [self showSavedPhotoLibrary];
  if(buttonIndex == removePhotoIndex) onImageChosen(nil);
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *) imagePicker {
  [self.controller dismissModalViewControllerAnimated:YES];
}

- (void) imagePickerController:(UIImagePickerController *) imagePicker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
  onImageChosen(image);
  [self.controller dismissModalViewControllerAnimated: YES];
}

@end
