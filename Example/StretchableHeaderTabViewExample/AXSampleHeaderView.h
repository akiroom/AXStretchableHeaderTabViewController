//
//  AXSampleHeaderView.h
//  StretchableHeaderTabViewExample
//

#import <AXStretchableHeaderTabViewController/AXStretchableHeaderView.h>

@interface AXSampleHeaderView : AXStretchableHeaderView
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *detailTextLabel;

@end
