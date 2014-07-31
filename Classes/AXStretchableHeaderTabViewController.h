//
//  AXStretchableHeaderTabViewController.h
//  Pods
//

#import <UIKit/UIKit.h>
#import "AXStretchableHeaderView.h"
#import "AXTabBar.h"

@class AXStretchableHeaderTabViewController;

@protocol AXStretchableSubViewControllerViewSource <NSObject>
@optional
- (UIScrollView *)stretchableSubViewInSubViewController:(id)subViewController;
@end

@interface AXStretchableHeaderTabViewController : UIViewController <UIScrollViewDelegate, AXTabBarDelegate>
@property (nonatomic) NSUInteger selectedIndex;
@property (readwrite, nonatomic) UIViewController *selectedViewController;
@property (copy, nonatomic) NSArray *viewControllers;

@property (weak, nonatomic) IBOutlet AXStretchableHeaderView *headerView;
@property (readonly, nonatomic) AXTabBar *tabBar;
@property (weak, nonatomic) IBOutlet UIScrollView *containerView;
@property (nonatomic) BOOL shouldBounceHeaderView;

// Layout
- (void)layoutHeaderViewAndTabBar;
- (void)layoutViewControllers;
- (void)layoutSubViewControllerToSelectedViewController;
@end
