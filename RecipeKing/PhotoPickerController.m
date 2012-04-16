//
//  PhotoService.m
//  RecipeKing
//
//  Created by Lee Irvine on 1/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PhotoPicker.h"
#import "UIImageExtras.h"

@interface PhotoPicker ()
- (void) setupImagePicker;
@end

@implementation PhotoPicker
@synthesize delegate;

- (void) setup {
    [self setupImagePicker];
}

- (void) setupImagePicker {
    imageOptions = [[UIActionSheet alloc] init];
    [imageOptions addButtonWithTitle: @"Take Photo"];
    [imageOptions addButtonWithTitle: @"Choose Photo"];
    [imageOptions addButtonWithTitle: @"Cancel"];
    imageOptions.cancelButtonIndex = 2;
    imageOptions.delegate = self;
}

- (void) actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger) buttonIndex {
    if(buttonIndex != 0 && buttonIndex != 1) return;
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    
    if(buttonIndex == 0) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else if(buttonIndex == 1) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [delegate presentModalViewController: imagePicker animated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *) imagePicker {
    [delegate dismissModalViewControllerAnimated:YES];
}

- (void) imagePickerController:(UIImagePickerController *) imagePicker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    UIImage *output = [image imageByScalingAndCroppingForSize: CGSizeMake(60, 60)];
    [delegate dismissModalViewControllerAnimated:YES];    
    [delegate imageSelected: output];
}

- (IBAction) imagePressed {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [imageOptions showInView: delegate.view];
    } else {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        [delegate presentModalViewController: imagePicker animated:YES];
    }
}

@end
