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
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
    _shouldBounceHeaderView = YES;
    
    _containerView = [[UIScrollView alloc] init];
    [_containerView setBounces:NO];
    [_containerView setClipsToBounds:YES];
    [_containerView setPagingEnabled:YES];
    [_containerView setDelegate:self];
    
    _tabBar = [[AXTabBar alloc] init];
    [_tabBar setDelegate:self];
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.view.backgroundColor = [UIColor redColor];
  
  [self.view addSubview:_containerView];
  [self.view addSubview:_tabBar];
  
  [_headerView setFrame:(CGRect){CGPointZero, CGRectGetWidth(self.view.bounds), _headerView.maximumOfHeight}];
  [_containerView setFrame:self.view.bounds];
  [_tabBar sizeToFit];
  [_tabBar setFrame:(CGRect){0.0, CGRectGetMaxY(_headerView.frame), _tabBar.bounds.size}];
  
  [self layoutViewControllers];
}

- (void)viewDidLayoutSubviews
{
  [super viewDidLayoutSubviews];
  
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
      [viewController.view addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
      [self addChildViewController:viewController];
      [tabItems addObject:viewController.tabBarItem];
    }];
    [_tabBar setItems:tabItems];
    [self layoutViewControllers];
    
    // tab bar
    [_tabBar setSelectedItem:[_tabBar.items firstObject]];
    _selectedIndex = 0;
    _selectedViewController = [_viewControllers firstObject];
  }
}

#pragma mark - Layout

- (void)layoutViewControllers
{
  CGSize size = self.containerView.bounds.size;
  UIEdgeInsets contentInsets = UIEdgeInsetsMake(CGRectGetMaxY(_tabBar.frame), 0.0, 0.0, 0.0);
  [_viewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    if ([obj isKindOfClass:[UIViewController class]]) {
      UIViewController *viewController = obj;
      [viewController.view setFrame:(CGRect){size.width * idx, 0.0, size}];
      if ([viewController.view respondsToSelector:@selector(setContentInset:)]) {
        [(id)viewController.view setContentInset:contentInsets];
      }
    }
  }];
  [_containerView setContentSize:(CGSize){size.width * _viewControllers.count, 0.0}];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
  if ([keyPath isEqualToString:@"contentOffset"]) {
    if ([_selectedViewController view] != object) {
      return;
    }
    CGPoint contentOffset = [object contentOffset];
    CGFloat width = CGRectGetWidth(self.view.frame);
    
    CGFloat headerHeight = MAX(_headerView.minimumOfHeight, -contentOffset.y - CGRectGetHeight(_tabBar.bounds));
    if (_shouldBounceHeaderView == NO) {
      headerHeight = MIN(_headerView.maximumOfHeight, headerHeight);
    }
    [_headerView setFrame:(CGRect){CGPointZero, width, headerHeight}];
    [_tabBar setFrame:(CGRect){0.0, headerHeight, _tabBar.frame.size}];
    
    UIEdgeInsets scrollIndicatorInsets = UIEdgeInsetsMake(CGRectGetMaxY(_tabBar.frame) - CGRectGetMinY(_containerView.frame), 0.0,
                                                          0.0, 0.0);
    if ([_selectedViewController isKindOfClass:[UIViewController class]]) {
      if ([_selectedViewController.view isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (id)_selectedViewController.view;
        [scrollView setScrollIndicatorInsets:scrollIndicatorInsets];
      }
    }
  }
}

#pragma mark - Scroll view delegate (tab view controllers)

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
  if ([_selectedViewController.view isKindOfClass:[UIScrollView class]]) {
    UIScrollView *selectedScrollView = (id)_selectedViewController.view;
    
    if (-selectedScrollView.contentOffset.y < CGRectGetMaxY(_tabBar.frame)) {
      [_viewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (_selectedViewController.view == [obj view]) {
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
        if (_selectedViewController.view == [obj view]) {
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
  if (scrollView.isDragging) {
    NSUInteger numberOfViewControllers = _viewControllers.count;
    _selectedIndex = round(scrollView.contentOffset.x / scrollView.contentSize.width * numberOfViewControllers);
    _selectedIndex = MIN(numberOfViewControllers - 1, MAX(0, _selectedIndex));
    [_tabBar setSelectedItem:_tabBar.items[_selectedIndex]];
    _selectedViewController = _viewControllers[_selectedIndex];
    
  }
}

#pragma mark - Tab bar delegate

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
  _selectedIndex = [[tabBar items] indexOfObject:item];
  [_containerView setContentOffset:(CGPoint){_selectedIndex * CGRectGetWidth(_containerView.bounds), 0.0} animated:YES];
  _selectedViewController = _viewControllers[_selectedIndex];
}

@end
