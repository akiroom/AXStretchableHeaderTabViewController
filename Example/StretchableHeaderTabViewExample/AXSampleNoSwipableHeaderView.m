//
//  AXSampleNoSwipableHeaderView.m
//  StretchableHeaderTabViewExample
//

#import "AXSampleNoSwipableHeaderView.h"

@implementation AXSampleNoSwipableHeaderView

- (id)initWithFrame:(CGRect)frame
{
  UINib *nib = [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
  self = [[nib instantiateWithOwner:self options:nil] firstObject];
  if (self) {
    // Nothing to do, if you want to make no swipable header.
  }
  return self;
}

@end
