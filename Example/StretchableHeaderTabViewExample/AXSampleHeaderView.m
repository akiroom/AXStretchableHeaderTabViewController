//
//  AXSampleHeaderView.m
//  StretchableHeaderTabViewExample
//

#import "AXSampleHeaderView.h"

@interface AXSampleHeaderView ()

@end

@implementation AXSampleHeaderView

- (id)initWithFrame:(CGRect)frame
{
  UINib *nib = [UINib nibWithNibName:NSStringFromClass([AXSampleHeaderView class]) bundle:nil];
  self = [[nib instantiateWithOwner:self options:nil] firstObject];
  if (self) {
    
  }
  return self;
}
//- (id)initWithFrame:(CGRect)frame
//{
//  UINib *nib = [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
//  self = [nib instantiateWithOwner:nil options:nil][0];
//  [self setFrame:frame];
//  return self;
//}

- (NSArray *)interactiveSubviews
{
  return @[_backButton];
}

@end
