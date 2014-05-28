//
//  AXSampleHeaderView.m
//  StretchableHeaderTabViewExample
//

#import "AXSampleHeaderView.h"

@implementation AXSampleHeaderView {
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

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

- (NSArray *)interactiveSubviewsInStretchableHeaderView:(AXStretchableHeaderView *)stretchableHeaderView
{
  return _interactiveSubviews;
}

@end
