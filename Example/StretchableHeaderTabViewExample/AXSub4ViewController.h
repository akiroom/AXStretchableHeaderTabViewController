//
//  AXSub4ViewController.h
//  StretchableHeaderTabViewExample
//

#import <UIKit/UIKit.h>
#import "AXStretchableHeaderTabViewController.h"

@interface AXSub4ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, AXStretchableSubViewControllerViewSource>

@property (strong, nonatomic) UITableView *tableView;

@end
