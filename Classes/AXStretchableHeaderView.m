//
//  AXStretchableHeaderView.m
//  Pods
//

#import "AXStretchableHeaderView.h"

@implementation AXStretchableHeaderView

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    self.clipsToBounds = YES;
    
    _minimumOfHeight = 64.0;
    _maximumOfHeight = 128.0;
  }
  return self;
}

- (NSArray *)interactiveSubviews
{
  return @[];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
  UIView *targetView = [super hitTest:point withEvent:event];
  if (targetView == self) {
    return nil;
  }
  
  if ([[self interactiveSubviews] indexOfObject:targetView] == NSNotFound) {
    return nil;
  } else {
    return targetView;
  }
}

@end
