#import "UINavigationBarSkinned.h"

@implementation UINavigationBarSkinned

+ (UINavigationController *) navigationControllerWithRoot: (UIViewController *) rootViewController {
  UINib *nib = [UINib nibWithNibName:@"UINavigationControllerSkinned" bundle:nil];
  UINavigationController *output = [[nib instantiateWithOwner:nil options:nil] objectAtIndex:0];
  [output setViewControllers: [NSArray arrayWithObject: rootViewController] animated: NO];
  return output;
}

- (id) initWithCoder:(NSCoder *) aDecoder {
  if((self = [super initWithCoder: aDecoder])) {
    _backgroundImageLandscape = [[UIImage imageNamed: @"navlandscape.png"] retain];
    _backgroundImagePortrait = [[UIImage imageNamed: @"navportrait.png"] retain];
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth
    | UIViewAutoresizingFlexibleBottomMargin
    | UIViewAutoresizingFlexibleRightMargin;
    
    self.tintColor = [UIColor colorWithRed:0.57f green:0.4f blue:0.24f alpha:1.f];
  }
  return self;
}

- (void) dealloc {
  [_backgroundImagePortrait release];
  [_backgroundImageLandscape release];
  [super dealloc];
}

- (void) drawRect:(CGRect)rect {
  BOOL isPortrait = UIDeviceOrientationIsPortrait([[UIDevice currentDevice] orientation]);
  if(isPortrait) {
    [_backgroundImagePortrait drawInRect: self.bounds];
  } else {
    [_backgroundImageLandscape drawInRect: self.bounds];
  }
}

@end
