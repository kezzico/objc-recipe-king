//
//  ActionSheet.h
//  RecipeKing
//
//  Created by Lee Irvine on 11/14/12.
//  Copyright (c) 2012 leescode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActionSheet : NSObject {
  BOOL _visible;
  CGFloat _sheetHeight;
}
@property (retain, nonatomic) IBOutlet UIView *view;
@property (retain, nonatomic) IBOutlet UIView *contentView;
@property (retain, nonatomic) IBOutlet UIView *sheetView;
@property (retain, nonatomic) IBOutlet UIView *shadowView;
@property (retain, nonatomic) UIView *content;
- (void) showContent:(UIView *) content inView:(UIView *) view;
- (void) dismiss;
@end
