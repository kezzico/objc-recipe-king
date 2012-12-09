//
//  SharingController.m
//  RecipeKing
//
//  Created by Lee Irvine on 11/16/12.
//  Copyright (c) 2012 leescode. All rights reserved.
//

#import "SharingController.h"
#import "ActionSheet.h"
#import "RecipeSerializer.h"
#import "RecipeMapper.h"
#import "Recipe.h"
#import "NSString-Extensions.h"
#import "NavigationController.h"
#import "ContentViewController.h"
#import "FlurryManager.h"

@implementation SharingController

- (void) dealloc {
  [_actionSheet release];
  [_mailController release];
  [_mailButton release];
  [_messageButton release];
  [_shareButtons release];
  [_recipe release];
  [super dealloc];
}

- (void) didUnload {
  [self setShareButtons:nil];
  [self setActionSheet: nil];
  [self setMailButton:nil];
  [self setMessageButton:nil];
  [self setParentController:nil];
}

- (void) presentEmailForRecipe:(Recipe *) recipe {
  self.mailController = [[[MFMailComposeViewController alloc] init] autorelease];
  self.mailController.mailComposeDelegate = self;
  
  RecipeSerializer *serializer = [[[RecipeSerializer alloc] init] autorelease];
  RecipeMapper *mapper = [[[RecipeMapper alloc] init] autorelease];
  NSData *recipedata = [serializer serialize:recipe];
  NSString *message = [mapper recipeToText:recipe];
  NSString *filename = [NSString stringWithFormat:@"%@.recipeking",recipe.name];
  message = [message search:@"\n" replace:@"<br/>"];
  message = [message stringByAppendingFormat:_L(@"DownloadRecipeFromEmail"), @"https://itunes.apple.com/app/id493431587"];
  
  [self.mailController setSubject: recipe.name];
  [self.mailController setMessageBody:message isHTML:YES];
  [self.mailController addAttachmentData:recipedata mimeType:@"application/recipe-king" fileName:filename];
	[self.mailController setToRecipients:@[]];
	[self.mailController setCcRecipients:@[]];
	[self.mailController setBccRecipients:@[]];
  [self.parentController.navcontroller presentModalViewController:self.mailController animated:YES];
  
  [[FlurryManager shared] logEvent:@"shared recipe" withParameters:@{@"median" : @"email"}];
}

- (void) presentMessageForRecipe:(Recipe *) recipe {
  self.messageController = [[[MFMessageComposeViewController alloc] init] autorelease];
  self.messageController.messageComposeDelegate = self;
  
  RecipeMapper *mapper = [[[RecipeMapper alloc] init] autorelease];
  NSString *message = [NSString stringWithFormat:@"%@\n\n%@", recipe.name, [mapper recipeToText:recipe]];

  self.messageController.body = message;
  [self.parentController.navcontroller presentModalViewController:self.messageController animated:YES];
  
  [[FlurryManager shared] logEvent:@"shared recipe" withParameters:@{@"median" : @"sms"}];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
  [controller dismissModalViewControllerAnimated:YES];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
  [controller dismissModalViewControllerAnimated:YES];  
}

- (IBAction)shareTouched:(id)sender {
  [self.mailButton setEnabled: [MFMailComposeViewController canSendMail]];
  [self.messageButton setEnabled: [MFMessageComposeViewController canSendText]];

  UIView *presenterView = self.parentController.navcontroller.view;
  [self.actionSheet showContent: self.shareButtons inView: presenterView];
}

- (IBAction)mailTouched:(id)sender {
  [self.actionSheet dismiss];
  [self presentEmailForRecipe: self.recipe];
}

- (IBAction)messageTouched:(id)sender {
  [self.actionSheet dismiss];
  [self presentMessageForRecipe:self.recipe];
}

- (IBAction)copyTouched:(id)sender {
  [self.actionSheet dismiss];

  RecipeMapper *mapper = [[[RecipeMapper alloc] init] autorelease];
  NSString *recipeText = [NSString stringWithFormat:@"%@\n\n%@", self.recipe.name, [mapper recipeToText:self.recipe]];
  
  UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
  pasteboard.string = recipeText;
  
  [[FlurryManager shared] logEvent:@"shared recipe" withParameters:@{@"median" : @"copy"}];
}

@end
