//
//  AXStretchableHeaderView.h
//  Pods
//

#import <UIKit/UIKit.h>

@class AXStretchableHeaderView;

@protocol AXStretchableHeaderViewDelegate <NSObject>
- (NSArray *)interactiveSubviewsInStretchableHeaderView:(AXStretchableHeaderView *)stretchableHeaderView;
@end

@interface AXStretchableHeaderView : UIView
@property (nonatomic) id<AXStretchableHeaderViewDelegate> delegate;
@property (nonatomic) CGFloat minimumOfHeight;
@property (nonatomic) CGFloat maximumOfHeight;
@property (nonatomic) BOOL bounces;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;
@end
