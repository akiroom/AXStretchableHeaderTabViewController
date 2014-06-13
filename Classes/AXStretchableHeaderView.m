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
    [self configureAXStretchableHeaderView];
  }
  return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
  if (self = [super initWithCoder:aDecoder]) {
    [self configureAXStretchableHeaderView];
  }
  return self;
}

- (void)awakeFromNib
{
  [super awakeFromNib];
  
}

- (void)configureAXStretchableHeaderView
{
  self.clipsToBounds = YES;
  _bounces = YES;
  _minimumOfHeight = 44.0;
  _maximumOfHeight = 128.0;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
  UIView *targetView = [super hitTest:point withEvent:event];
  if (!targetView) {
    return nil;
  }
  
  NSArray *interactiveSubviews;
  if ([self.delegate respondsToSelector:@selector(interactiveSubviewsInStretchableHeaderView:)]) {
    interactiveSubviews = [self.delegate interactiveSubviewsInStretchableHeaderView:self];
  } else {
    return targetView;
  }
  
  if ([interactiveSubviews containsObject:self]) {
    return targetView;
  }
  
  // Recursive search interactive view in children.
  __block BOOL isFound = NO;
  UIView *checkView = targetView;
  while (checkView != self) {
    [interactiveSubviews enumerateObjectsUsingBlock:^(UIView *interactiveSubview, NSUInteger idx, BOOL *stop) {
      if (checkView == interactiveSubview) {
        isFound = YES;
        *stop = YES;
      }
    }];
    if (isFound) {
      return targetView;
    }
    checkView = [checkView superview];
  }

  return nil;
}

- (void)layoutSubviews
{
  [super layoutSubviews];
}

@end
