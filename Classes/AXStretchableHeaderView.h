//
//  AXStretchableHeaderView.h
//  Pods
//

#import <UIKit/UIKit.h>

@interface AXStretchableHeaderView : UIView
@property (nonatomic) CGFloat minimumOfHeight;
@property (nonatomic) CGFloat maximumOfHeight;
- (NSArray *)interactiveSubviews;
@end
