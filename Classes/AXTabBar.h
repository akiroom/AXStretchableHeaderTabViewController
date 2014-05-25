//
//  AXTabBar.h
//  Pods
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
  AXTabBarStyleDefault = 0,
  AXTabBarStyleVariableWidthButton,
} AXTabBarStyle;

@class AXTabBar;

@protocol AXTabBarDelegate <NSObject>
@optional
- (void)tabBar:(AXTabBar *)tabBar didSelectItem:(UITabBarItem *)item;
@end

@interface AXTabBar : UIView
@property (copy, nonatomic) NSArray *items;
@property (assign, nonatomic) UITabBarItem *selectedItem;
@property (assign, nonatomic) id<AXTabBarDelegate> delegate;
@property (nonatomic) AXTabBarStyle tabBarStyle;
@end
