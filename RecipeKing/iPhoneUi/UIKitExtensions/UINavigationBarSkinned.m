#import "UINavigationBarSkinned.h"
#import "ScreenHelper.h"

@implementation UINavigationBarSkinned

+ (UINavigationController *) navigationControllerWithRoot: (UIViewController *) rootViewController {
  UINib *nib = [UINib nibWithNibName:@"UINavigationControllerSkinned" bundle:nil];
  UINavigationController *output = [[nib instantiateWithOwner:nil options:nil] objectAtIndex:0];
  [output setViewControllers: [NSArray arrayWithObject: rootViewController] animated: NO];
  return output;
}

- (void) dealloc {
  [_backgroundImagePortrait release];
  [_backgroundImageLandscape release];
  [_backgroundImageLandscapeWide release];
  [super dealloc];
}

- (id) initWithCoder:(NSCoder *) aDecoder {
  if((self = [super initWithCoder: aDecoder])) {
    self.backgroundImageLandscapeWide = [UIImage imageNamed: @"navlandscapewide"];
    self.backgroundImageLandscape = [UIImage imageNamed: @"navlandscape"];
    self.backgroundImagePortrait = [UIImage imageNamed: @"navportrait"];
    
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth
    | UIViewAutoresizingFlexibleBottomMargin
    | UIViewAutoresizingFlexibleRightMargin;
    
    self.tintColor = [UIColor colorWithRed:0.57f green:0.4f blue:0.24f alpha:1.f];
  }
  return self;
}

- (void) drawRect:(CGRect)rect {
  if([ScreenHelper isPortraitMode]) {
    [self.backgroundImagePortrait drawInRect: self.bounds];
  } else if([ScreenHelper isWideScreen]) {
    [self.backgroundImageLandscapeWide drawInRect: self.bounds];
  } else {
    [self.backgroundImageLandscape drawInRect: self.bounds];
  }
}

@end
