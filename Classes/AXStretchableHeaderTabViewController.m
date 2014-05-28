//
//  AXStretchableHeaderTabViewController.m
//  Pods
//
//  Created by Hiroki Akiyama on 2014/05/25.
//
//

#import "AXStretchableHeaderTabViewController.h"

@interface AXStretchableHeaderTabViewController () <UIScrollViewDelegate, AXTabBarDelegate>

@end

@implementation AXStretchableHeaderTabViewController

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

- (void)awakeFromNib
{
  [super awakeFromNib];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  [self.view addSubview:_tabBar];
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
//  [_viewControllers enumerateObjectsUsingBlock:^(UIViewController *viewController, NSUInteger idx, BOOL *stop) {
//    [viewController.view addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
//    [self addChildViewController:viewController];
//  }];
//  [_containerView setDelegate:self];
}

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  //  UIView *v = self.containerView;
  NSLog(@"%@", NSStringFromCGRect(self.containerView.frame));
  NSLog(@"%@", NSStringFromUIEdgeInsets(self.containerView.contentInset));
}

- (void)viewWillDisappear:(BOOL)animated
{
  [_viewControllers enumerateObjectsUsingBlock:^(UIViewController *viewController, NSUInteger idx, BOOL *stop) {
    [viewController.view removeObserver:self forKeyPath:@"contentOffset"];
    [viewController removeFromParentViewController];
  }];
  [super viewWillDisappear:animated];
}

- (void)viewDidLayoutSubviews
{
  [super viewDidLayoutSubviews];
  
  [_headerView setFrame:(CGRect){
    0.0, _containerView.contentInset.top,
    CGRectGetWidth(self.view.bounds), _headerView.maximumOfHeight
  }];
  NSLog(@"%@", NSStringFromCGRect(_headerView.frame));
  
  [_tabBar sizeToFit];
  [_tabBar setFrame:(CGRect){
    0.0, CGRectGetMaxY(_headerView.frame),
    _tabBar.frame.size
  }];
  
  [self layoutViewControllers];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)setHeaderView:(AXStretchableHeaderView *)headerView
{
  if (_headerView != headerView) {
    [_headerView removeFromSuperview];
    _headerView = headerView;
    [self.view addSubview:headerView];
  }
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

- (void)setViewControllers:(NSArray *)viewControllers
{
  if ([_viewControllers isEqualToArray:viewControllers] == NO) {
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
      if (self.isViewLoaded) {
        [viewController.view addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
        [self addChildViewController:viewController];
      }
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

- (void)layoutViewControllers
{
  [self.view layoutSubviews];
  CGSize size = _containerView.bounds.size;
  
  UIEdgeInsets contentInsets = UIEdgeInsetsMake(_headerView.maximumOfHeight + CGRectGetHeight(_tabBar.bounds), 0.0, _containerView.contentInset.top, 0.0);
  NSLog(@"%@, %@", NSStringFromCGSize(size), NSStringFromUIEdgeInsets(contentInsets));
  
  [_viewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    if ([obj isKindOfClass:[UIViewController class]]) {
      UIViewController *viewController = obj;
      CGRect newFrame = (CGRect){size.width * idx, 0.0, size};
      if ([viewController.view respondsToSelector:@selector(setContentInset:)]) {
        [viewController.view setFrame:newFrame];
        [(id)viewController.view setContentInset:contentInsets];
        NSLog(@"--- %@", NSStringFromCGRect(viewController.view.frame));
      } else {
        [viewController.view setFrame:UIEdgeInsetsInsetRect(newFrame, contentInsets)];
      }
    }
  }];
  [_containerView setContentSize:(CGSize){size.width * _viewControllers.count, 0.0}];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
  return;
  UIViewController *selectedViewController = [self selectedViewController];
  if ([keyPath isEqualToString:@"contentOffset"]) {
    if ([selectedViewController view] != object &&
        [[selectedViewController view] isKindOfClass:[UIScrollView class]] == NO) {
      return;
    }
    UIScrollView *scrollView = (id)selectedViewController.view;
    
    CGPoint contentOffset = [object contentOffset];
    CGFloat width = CGRectGetWidth(self.view.frame);
    
    CGFloat headerHeight = _headerView.maximumOfHeight - contentOffset.y;
    NSLog(@"★%f", scrollView.contentInset.top);
//    NSLog(@"%f -> %f", contentOffset.y, headerHeight);
//    NSLog(@"%f", -contentOffset.y + scrollView.contentInset.top);
//    NSLog(@"%d -> %d", (int)-contentOffset.y, (int)headerHeight);
//    headerHeight = MAX(_headerView.minimumOfHeight, headerHeight);
//    if (_shouldBounceHeaderView == NO) {
//      headerHeight = MIN(_headerView.maximumOfHeight, headerHeight);
//    }
//    [_headerView setFrame:(CGRect){0.0, _containerView.contentInset.top, width, headerHeight}];
//    NSLog(@"_headerView.frame: %d < %@ < %d", (int)_headerView.minimumOfHeight, NSStringFromCGRect(_headerView.frame), (int)_headerView.maximumOfHeight);
//    [_tabBar setFrame:(CGRect){0.0, headerHeight, _tabBar.frame.size}];
//    
//    UIEdgeInsets scrollIndicatorInsets = UIEdgeInsetsMake(CGRectGetMaxY(_tabBar.frame) - CGRectGetMinY(_containerView.frame), 0.0,
//                                                          0.0, 0.0);
//    if ([selectedViewController isKindOfClass:[UIViewController class]]) {
//      if ([selectedViewController.view isKindOfClass:[UIScrollView class]]) {
//        UIScrollView *scrollView = (id)selectedViewController.view;
//        [scrollView setScrollIndicatorInsets:scrollIndicatorInsets];
//      }
//    }
  }
}

#pragma mark - Scroll view delegate (tab view controllers)

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
  return;
  UIViewController *selectedViewController = [self selectedViewController];
  if ([selectedViewController.view isKindOfClass:[UIScrollView class]]) {
    UIScrollView *selectedScrollView = (id)selectedViewController.view;
    
    if (-selectedScrollView.contentOffset.y < CGRectGetMaxY(_tabBar.frame)) {
      [_viewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (selectedViewController.view == [obj view]) {
          return;
        }
        if ([[obj view] isKindOfClass:[UIScrollView class]]) {
          UIScrollView *scrollView = (id)[obj view];
          if (-scrollView.contentOffset.y >= CGRectGetMaxY(_tabBar.frame)) {
            // Set head content offsets;
            [scrollView setContentOffset:(CGPoint){0.0, -CGRectGetMaxY(_tabBar.frame)}];
          }
        }
      }];
    } else {
      // Set same content offsets.
      CGPoint newContentOffset = selectedScrollView.contentOffset;
      newContentOffset.y = MIN(CGRectGetMaxY(_tabBar.frame), newContentOffset.y);
      
      [_viewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (selectedViewController.view == [obj view]) {
          return;
        }
        if ([[obj view] isKindOfClass:[UIScrollView class]]) {
          UIScrollView *scrollView = (id)[obj view];
          [scrollView setContentOffset:newContentOffset];
        }
      }];
    }
  }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
  return;
  if (scrollView.isDragging) {
    NSUInteger numberOfViewControllers = _viewControllers.count;
    _selectedIndex = round(scrollView.contentOffset.x / scrollView.contentSize.width * numberOfViewControllers);
    _selectedIndex = MIN(numberOfViewControllers - 1, MAX(0, _selectedIndex));
    [_tabBar setSelectedItem:_tabBar.items[_selectedIndex]];
  }
}

#pragma mark - Tab bar delegate

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
  _selectedIndex = [[tabBar items] indexOfObject:item];
  [_containerView setContentOffset:(CGPoint){_selectedIndex * CGRectGetWidth(_containerView.bounds), _containerView.contentOffset.y} animated:YES];
}

@end
