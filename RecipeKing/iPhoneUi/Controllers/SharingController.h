//
//  SharingController.h
//  RecipeKing
//
//  Created by Lee Irvine on 11/16/12.
//  Copyright (c) 2012 leescode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <MessageUI/MFMessageComposeViewController.h>

@class ActionSheet;
@class Recipe;
@class ContentViewController;
@interface SharingController : NSObject <MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, assign) IBOutlet ContentViewController *parentController;
@property (nonatomic, retain) MFMailComposeViewController *mailController;
@property (nonatomic, retain) MFMessageComposeViewController *messageController;

@property (retain, nonatomic) IBOutlet UIView *shareButtons;
@property (retain, nonatomic) IBOutlet UIButton *mailButton;
@property (retain, nonatomic) IBOutlet UIButton *messageButton;
@property (retain, nonatomic) IBOutlet ActionSheet *actionSheet;
@property (retain, nonatomic) Recipe *recipe;
- (IBAction)shareTouched:(id)sender;
- (IBAction)mailTouched:(id)sender;
- (IBAction)messageTouched:(id)sender;
- (IBAction)copyTouched:(id)sender;
- (void) didUnload;
@end
