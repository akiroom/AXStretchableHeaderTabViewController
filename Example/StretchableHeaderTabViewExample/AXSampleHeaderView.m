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
  UINib *nib = [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
  self = [nib instantiateWithOwner:nil options:nil][0];
  return self;
}

@end
