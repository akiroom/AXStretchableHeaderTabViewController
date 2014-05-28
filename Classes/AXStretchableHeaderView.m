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
  _minimumOfHeight = 64.0;
  _maximumOfHeight = 128.0;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
  UIView *targetView = [super hitTest:point withEvent:event];
  if (targetView == self) {
    return nil;
  }
  
  if ([[[self headerDelegate] interactiveSubviewsInStretchableHeaderView:self] indexOfObject:targetView] == NSNotFound) {
    return nil;
  } else {
    return targetView;
  }
}

- (void)layoutSubviews
{
  [super layoutSubviews];
}

@end
