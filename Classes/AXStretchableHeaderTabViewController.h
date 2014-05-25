//
//  AXStretchableHeaderTabViewController.h
//  Pods
//
//  Created by Hiroki Akiyama on 2014/05/25.
//
//

#import <UIKit/UIKit.h>
#import "AXStretchableHeaderView.h"
#import "AXTabBar.h"

@interface AXStretchableHeaderTabViewController : UIViewController
@property (assign, nonatomic) id<UITabBarControllerDelegate> delegate;

@property (nonatomic) NSUInteger selectedIndex;
@property (assign, nonatomic) UIViewController *selectedViewController;
@property (copy, nonatomic) NSArray *viewControllers;

@property (strong, nonatomic) AXStretchableHeaderView *headerView;
@property (readonly, nonatomic) AXTabBar *tabBar;
@property (readonly, nonatomic) UIScrollView *containerView;
@property (nonatomic) BOOL shouldBounceHeaderView;

// Layout
- (void)layoutViewControllers;
@end
