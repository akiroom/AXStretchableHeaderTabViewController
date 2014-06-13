//
//  AXSampleHeaderView.h
//  StretchableHeaderTabViewExample
//

#import "AXStretchableHeaderView.h"

@interface AXSampleSwipableHeaderView : AXStretchableHeaderView <AXStretchableHeaderViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
