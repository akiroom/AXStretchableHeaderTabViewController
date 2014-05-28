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
//@property (weak, nonatomic) id<UITabBarControllerDelegate> delegate;

@property (nonatomic) NSUInteger selectedIndex;
@property (readwrite, nonatomic) UIViewController *selectedViewController;
@property (copy, nonatomic) NSArray *viewControllers;

@property (weak, nonatomic) AXStretchableHeaderView *headerView;
@property (readonly, nonatomic) AXTabBar *tabBar;
//@property (readonly, nonatomic) UIScrollView *containerView;
@property (unsafe_unretained, nonatomic) IBOutlet UIScrollView *containerView;
@property (nonatomic) BOOL shouldBounceHeaderView;

// Layout
- (void)layoutViewControllers;
@end
