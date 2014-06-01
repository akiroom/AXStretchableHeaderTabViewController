//
//  AXStretchableHeaderTabViewController.m
//  Pods
//

#import "AXStretchableHeaderTabViewController.h"

@interface AXStretchableHeaderTabViewController ()

@end

@implementation AXStretchableHeaderTabViewController {
  CGFloat _headerViewTopConstraintConstant;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  // MEMO:
  // An inherited class does not load xib file.
  // So, this code assigns class name of AXStretchableHeaderTabViewController clearly.
  self = [super initWithNibName:NSStringFromClass([AXStretchableHeaderTabViewController class]) bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
    _shouldBounceHeaderView = YES;

    _tabBar = [[AXTabBar alloc] init];
    [_tabBar setDelegate:self];
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  [_tabBar sizeToFit];
  [self.view addSubview:_tabBar];
}

- (void)dealloc
{
  [_viewControllers enumerateObjectsUsingBlock:^(UIViewController *viewController, NSUInteger idx, BOOL *stop) {
    [viewController.view removeObserver:self forKeyPath:@"contentOffset"];
    [viewController removeFromParentViewController];
  }];
}

- (void)viewDidLayoutSubviews
{
  [super viewDidLayoutSubviews];
  
  _headerView.topConstraint.constant = _headerViewTopConstraintConstant + _containerView.contentInset.top;
  [_headerView setFrame:(CGRect){
    0.0, 0.0,
    CGRectGetWidth(self.view.bounds), _headerView.maximumOfHeight + _containerView.contentInset.top
  }];
  
  [self layoutHeaderViewAndTabBar];
  [self layoutViewControllers];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Property

- (UIViewController *)selectedViewController
{
  return _viewControllers[_selectedIndex];
}

- (void)setSelectedViewController:(UIViewController *)selectedViewController
{
  NSInteger newIndex = [_viewControllers indexOfObject:selectedViewController];
  if (newIndex == NSNotFound) {
    return;
  }
  if (newIndex != _selectedIndex) {
    _selectedIndex = newIndex;
  }
}

- (void)setHeaderView:(AXStretchableHeaderView *)headerView
{
  if (_headerView != headerView) {
    [_headerView removeFromSuperview];
    _headerView = headerView;
    _headerViewTopConstraintConstant = _headerView.topConstraint.constant;
    [self.view addSubview:_headerView];
  }
}

- (void)setViewControllers:(NSArray *)viewControllers
{
  if ([_viewControllers isEqualToArray:viewControllers] == NO) {
    // Load nib file, if self.view is nil.
    [self view];
    
    // Remove views in old view controllers
    [_viewControllers enumerateObjectsUsingBlock:^(UIViewController *viewController, NSUInteger idx, BOOL *stop) {
      [viewController.view removeFromSuperview];
      [viewController.view removeObserver:self forKeyPath:@"contentOffset"];
      [viewController removeFromParentViewController];
    }];
    
    // Assign new view controllers
    _viewControllers = [viewControllers copy];
    
    // Add views in new view controllers
    NSMutableArray *tabItems = [NSMutableArray array];
    [_viewControllers enumerateObjectsUsingBlock:^(UIViewController *viewController, NSUInteger idx, BOOL *stop) {
      [_containerView addSubview:viewController.view];
      [viewController.view addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
      [self addChildViewController:viewController];
      [tabItems addObject:viewController.tabBarItem];
    }];
    [_tabBar setItems:tabItems];
    
    [self layoutViewControllers];
    
    // tab bar
    [_tabBar setSelectedItem:[_tabBar.items firstObject]];
    _selectedIndex = 0;
  }
}

#pragma mark - Layout

- (void)layoutHeaderViewAndTabBar
{
  // Get selected scroll view.
  UIScrollView *scrollView = (id)[self selectedViewController].view;
  
  if ([scrollView isKindOfClass:[UIScrollView class]]) {
    // Set header view frame
    CGFloat headerViewHeight = _headerView.maximumOfHeight - (scrollView.contentOffset.y + scrollView.contentInset.top);
    headerViewHeight = MAX(headerViewHeight, _headerView.minimumOfHeight);
    if (_headerView.bounces == NO) {
      headerViewHeight = MIN(headerViewHeight, _headerView.maximumOfHeight);
    }
    [_headerView setFrame:(CGRect){
      _headerView.frame.origin,
      CGRectGetWidth(_headerView.frame), headerViewHeight + _containerView.contentInset.top
    }];
    
    // Set scroll view indicator insets
    [scrollView setScrollIndicatorInsets:
     UIEdgeInsetsMake(CGRectGetMaxY(_tabBar.frame) - _containerView.contentInset.top, 0.0, scrollView.contentInset.bottom, 0.0)];
  } else {
    // Set header view frame
    [_headerView setFrame:(CGRect){
      _headerView.frame.origin,
      CGRectGetWidth(_headerView.frame), _headerView.maximumOfHeight + _containerView.contentInset.top
    }];
  }
  
  // Tab bar
  CGFloat tabBarY =
  (_headerView ?
   CGRectGetMaxY(_headerView.frame) :
   _containerView.contentInset.top
   );
  [_tabBar setFrame:(CGRect){
    0.0, tabBarY,
    _tabBar.frame.size
  }];
  
}

- (void)layoutViewControllers
{
  [self.view layoutSubviews];
  CGSize size = _containerView.bounds.size;
  
  CGFloat headerOffset =
  (_headerView ?
   _headerView.maximumOfHeight :
   0.0
  );
  UIEdgeInsets contentInsets = UIEdgeInsetsMake(headerOffset + CGRectGetHeight(_tabBar.bounds), 0.0, _containerView.contentInset.top, 0.0);
  
  // Resize sub view controllers
  [_viewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    if ([obj isKindOfClass:[UIViewController class]]) {
      UIViewController *viewController = obj;
      CGRect newFrame = (CGRect){size.width * idx, 0.0, size};
      if ([viewController.view isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (id)viewController.view;
        [scrollView setFrame:newFrame];
        [scrollView setContentInset:contentInsets];
      } else {
        [viewController.view setFrame:UIEdgeInsetsInsetRect(newFrame, contentInsets)];
      }
    }
  }];
  [_containerView setContentSize:(CGSize){size.width * _viewControllers.count, 0.0}];
}

- (void)layoutSubViewControllerToSelectedViewController
{
  UIViewController *selectedViewController = [self selectedViewController];
  if ([selectedViewController.view isKindOfClass:[UIScrollView class]] == NO) {
    return;
  }

  // Define selected scroll view
  UIScrollView *selectedScrollView = (id)selectedViewController.view;
  
  // Define relative y calculator
  CGFloat (^calcRelativeY)(CGFloat contentOffsetY, CGFloat contentInsetTop) = ^CGFloat(CGFloat contentOffsetY, CGFloat contentInsetTop) {
    return _headerView.maximumOfHeight - _headerView.minimumOfHeight - (contentOffsetY + contentInsetTop);
  };
  
  // Adjustment offset or frame for sub views.
  [_viewControllers enumerateObjectsUsingBlock:^(UIViewController *viewController, NSUInteger idx, BOOL *stop) {
    if (selectedViewController == viewController) {
      return;
    }
    
    UIView *targetView = viewController.view;
    if ([targetView isKindOfClass:[UIScrollView class]]) {
      // Scroll view
      // -> Adjust offset
      UIScrollView *targetScrollView = (id)targetView;
      CGFloat relativePositionY = calcRelativeY(selectedScrollView.contentOffset.y, selectedScrollView.contentInset.top);//headerViewHeight - _headerView.minimumOfHeight;
      if (relativePositionY > 0) {
        // The header view's height is higher than minimum height.
        // -> Adjust same offset.
        [targetScrollView setContentOffset:selectedScrollView.contentOffset];
        
      } else {
        // The header view height is lower than minimum height.
        // -> Adjust top of scrollview, If target header view's height is higher than minimum height.
        CGFloat targetRelativePositionY = calcRelativeY(targetScrollView.contentOffset.y, targetScrollView.contentInset.top);
        if (targetRelativePositionY > 0) {
          targetScrollView.contentOffset = (CGPoint){
            targetScrollView.contentOffset.x,
            -(CGRectGetMaxY(_tabBar.frame) - _containerView.contentInset.top)
          };
        }
      }
    } else {
      // Not scroll view
      // -> Adjust frame to area at the bottom of tab bar.
      CGFloat y = CGRectGetMaxY(_tabBar.frame) - _containerView.contentInset.top;
      [targetView setFrame:(CGRect){
        CGRectGetMinX(targetView.frame), y,
        CGRectGetMinX(targetView.frame), CGRectGetHeight(_containerView.frame) - y
      }];
    }
  }];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
  UIViewController *selectedViewController = [self selectedViewController];
  if ([keyPath isEqualToString:@"contentOffset"]) {
    if ([selectedViewController view] != object &&
        [[selectedViewController view] isKindOfClass:[UIScrollView class]] == NO) {
      return;
    }
    [self layoutHeaderViewAndTabBar];
  }
}

#pragma mark - Scroll view delegate (tab view controllers)

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
  [self layoutSubViewControllerToSelectedViewController];
  return;
  
  
  UIViewController *selectedViewController = [self selectedViewController];
  if ([selectedViewController.view isKindOfClass:[UIScrollView class]] == NO) {
    return;
  }
  // Define selected scroll view
  UIScrollView *selectedScrollView = (id)selectedViewController.view;
  
  // Define relative y calculator
  CGFloat (^calcRelativeY)(CGFloat contentOffsetY, CGFloat contentInsetTop) = ^CGFloat(CGFloat contentOffsetY, CGFloat contentInsetTop) {
    return _headerView.maximumOfHeight - _headerView.minimumOfHeight - (contentOffsetY + contentInsetTop);
  };
  
  // Adjustment offset or frame for sub views.
  [_viewControllers enumerateObjectsUsingBlock:^(UIViewController *viewController, NSUInteger idx, BOOL *stop) {
    if (selectedViewController == viewController) {
      return;
    }
    
    UIView *targetView = viewController.view;
    if ([targetView isKindOfClass:[UIScrollView class]]) {
      // Scroll view
      // -> Adjust offset
      UIScrollView *targetScrollView = (id)targetView;
      CGFloat relativePositionY = calcRelativeY(selectedScrollView.contentOffset.y, selectedScrollView.contentInset.top);//headerViewHeight - _headerView.minimumOfHeight;
      if (relativePositionY > 0) {
        // The header view's height is higher than minimum height.
        // -> Adjust same offset.
        [targetScrollView setContentOffset:selectedScrollView.contentOffset];

      } else {
        // The header view height is lower than minimum height.
        // -> Adjust top of scrollview, If target header view's height is higher than minimum height.
        CGFloat targetRelativePositionY = calcRelativeY(targetScrollView.contentOffset.y, targetScrollView.contentInset.top);
        if (targetRelativePositionY > 0) {
          targetScrollView.contentOffset = (CGPoint){
            targetScrollView.contentOffset.x,
            -(CGRectGetMaxY(_tabBar.frame) - _containerView.contentInset.top)
          };
        }
      }
    } else {
      // Not scroll view
      // -> Adjust frame to area at the bottom of tab bar.
      CGFloat y = CGRectGetMaxY(_tabBar.frame) - _containerView.contentInset.top;
      [targetView setFrame:(CGRect){
        CGRectGetMinX(targetView.frame), y,
        CGRectGetMinX(targetView.frame), CGRectGetHeight(_containerView.frame) - y
      }];
    }
  }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
  if (scrollView.isDragging) {
    NSUInteger numberOfViewControllers = _viewControllers.count;
    _selectedIndex = round(scrollView.contentOffset.x / scrollView.contentSize.width * numberOfViewControllers);
    _selectedIndex = MIN(numberOfViewControllers - 1, MAX(0, _selectedIndex));
    [_tabBar setSelectedItem:_tabBar.items[_selectedIndex]];
  }
}

#pragma mark - Tab bar delegate

- (BOOL)tabBar:(AXTabBar *)tabBar shouldSelectItem:(UITabBarItem *)item
{
  [self layoutSubViewControllerToSelectedViewController];
  return YES;
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
  _selectedIndex = [[tabBar items] indexOfObject:item];
  [_containerView setContentOffset:(CGPoint){_selectedIndex * CGRectGetWidth(_containerView.bounds), _containerView.contentOffset.y} animated:YES];
}

@end
