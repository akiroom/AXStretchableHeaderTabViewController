//
//  AXSampleHeaderView.m
//  StretchableHeaderTabViewExample
//

#import "AXSampleSwipableHeaderView.h"

@implementation AXSampleSwipableHeaderView {
  NSArray *_interactiveSubviews;
}

- (id)initWithFrame:(CGRect)frame
{
  UINib *nib = [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
  self = [[nib instantiateWithOwner:self options:nil] firstObject];
  if (self) {
    self.delegate = self;
    _interactiveSubviews = @[self.backButton];
  }
  return self;
}

- (NSArray *)interactiveSubviewsInStretchableHeaderView:(AXStretchableHeaderView *)stretchableHeaderView
{
  return _interactiveSubviews;
}

@end
