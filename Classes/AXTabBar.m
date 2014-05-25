//
//  AXTabBar.m
//  Pods
//

#import "AXTabBar.h"
#import "AXTabBarItemButton.h"

@interface AXTabBar ()
@property (readonly, nonatomic) UIScrollView *containerView;
@property (readonly, nonatomic) UIToolbar *toolbar;
@property (copy, nonatomic) NSArray *tabBarItemButtons;
@end

@implementation AXTabBar {
  NSArray *_items;
  CALayer *_indicatorLayer;
}

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    _toolbar = [[UIToolbar alloc] init];
    _toolbar.userInteractionEnabled = NO;
    [self addSubview:_toolbar];
    
    _containerView = [[UIScrollView alloc] init];
    _containerView.bounces = NO;
    _containerView.showsHorizontalScrollIndicator = NO;
    _containerView.decelerationRate = UIScrollViewDecelerationRateFast;
    [self addSubview:_containerView];
    
    _indicatorLayer = [CALayer layer];
    [self.layer addSublayer:_indicatorLayer];
  }
  return self;
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  [_toolbar setFrame:self.bounds];
  [_containerView setFrame:self.bounds];
  
  if (_tabBarItemButtons.count > 0) {
    CGSize buttonSize = (CGSize){CGRectGetWidth(self.bounds) / _tabBarItemButtons.count, CGRectGetHeight(self.bounds)};
    switch (_tabBarStyle) {
      case AXTabBarStyleDefault: {
        [_tabBarItemButtons enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
          [button setFrame:(CGRect){buttonSize.width * idx, 0.0, buttonSize}];
        }];
        [_containerView setContentSize:CGSizeZero];
        break;
      }
      case AXTabBarStyleVariableWidthButton: {
        __block CGFloat x = 8.0;
        [_tabBarItemButtons enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
          [button sizeToFit];
          CGFloat buttonWidth = CGRectGetWidth(button.bounds);
          [button setFrame:(CGRect){x, 0.0, buttonWidth, buttonSize.height}];
          x += buttonWidth;
        }];
        [_containerView setContentSize:(CGSize){x, 0.0}];
        break;
      }
    }
    [self layoutIndicatorLayerWithButton:[_tabBarItemButtons objectAtIndex:[_items indexOfObject:_selectedItem]]];
  }
}

- (void)sizeToFit
{
  [super sizeToFit];
  [self setBounds:(CGRect){
    CGPointZero,
    CGRectGetWidth([[UIApplication sharedApplication] statusBarFrame]),
    44.0
  }];
}

#pragma mark - Property

- (void)setItems:(NSArray *)items
{
  if ([_items isEqualToArray:items] == NO) {
    _items = [items copy];
    
    // TODO
    NSMutableArray *buttons = [NSMutableArray array];
    [items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
      if ([obj isKindOfClass:[UITabBarItem class]]) {
        UITabBarItem *item = obj;
        AXTabBarItemButton *button = [[AXTabBarItemButton alloc] init];
        [button setImage:item.image forState:UIControlStateNormal];
        [button setTitle:item.title forState:UIControlStateNormal];
        [button setBadgeValue:item.badgeValue];
        [button addTarget:self action:@selector(touchesButton:) forControlEvents:UIControlEventTouchDown];
        [button setTitleColor:self.tintColor forState:UIControlStateSelected];
        [button setTitleColor:self.tintColor forState:UIControlStateHighlighted];
        [_containerView addSubview:button];
        [buttons addObject:button];
      }
    }];
    [_indicatorLayer setBackgroundColor:[self.tintColor CGColor]];
    [self setNeedsLayout];
    self.tabBarItemButtons = [buttons copy];
    
    [self setSelectedItem:[items firstObject]];
  }
}

- (void)setSelectedItem:(UITabBarItem *)selectedItem
{
  if (_selectedItem != selectedItem) {
    
    NSUInteger beforeIndex = [_items indexOfObject:_selectedItem];
    NSUInteger afterIndex = [_items indexOfObject:selectedItem];
    if (beforeIndex != NSNotFound) {
      [_tabBarItemButtons[beforeIndex] setSelected:NO];
    }
    if (afterIndex != NSNotFound) {
      AXTabBarItemButton *button = _tabBarItemButtons[afterIndex];
      _selectedItem = selectedItem;
      [button setSelected:YES];
      
      [self layoutIndicatorLayerWithButton:button];
    }
  }
}

- (void)layoutIndicatorLayerWithButton:(UIButton *)button
{
  [CATransaction begin];
  [CATransaction setDisableActions:YES];
  [_indicatorLayer setFrame:(CGRect){
    CGRectGetMinX(button.frame), CGRectGetHeight(self.bounds) - 2.0,
    CGRectGetWidth(button.frame), 2.0
  }];
  [CATransaction commit];
}

- (void)setTabBarStyle:(AXTabBarStyle)tabBarStyle
{
  if (_tabBarStyle != tabBarStyle) {
    _tabBarStyle = tabBarStyle;
    [self setNeedsLayout];
  }
}

#pragma mark - Action

- (void)touchesButton:(UIButton *)sender
{
  [sender setHighlighted:YES];
  NSUInteger index = [_tabBarItemButtons indexOfObject:sender];
  if (index != NSNotFound) {
    UITabBarItem *selectedItem = _items[index];
    [self setSelectedItem:selectedItem];
    if ([_delegate respondsToSelector:@selector(tabBar:didSelectItem:)]) {
      [_delegate tabBar:self didSelectItem:selectedItem];
    }
  }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
  UITouch *touch = [touches anyObject];
  [_tabBarItemButtons enumerateObjectsUsingBlock:^(UIView *button, NSUInteger idx, BOOL *stop) {
    if (CGRectContainsPoint(button.bounds, [touch locationInView:button])) {
      UITabBarItem *selectedItem = _items[idx];
      [self setSelectedItem:selectedItem];
      if ([_delegate respondsToSelector:@selector(tabBar:didSelectItem:)]) {
        [_delegate tabBar:self didSelectItem:selectedItem];
      }
      return;
    }
  }];
  [self.nextResponder touchesBegan:touches withEvent:event];
}
@end
