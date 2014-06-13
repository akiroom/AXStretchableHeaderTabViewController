//
//  AXSampleNoSwipableTabViewController.m
//  StretchableHeaderTabViewExample
//

#import "AXSampleNoSwipableTabViewController.h"
#import "AXSub1TableViewController.h"
#import "AXSub2TableViewController.h"
#import "AXSampleNoSwipableHeaderView.h"

@implementation AXSampleNoSwipableTabViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    self.title = @"No horizontal swipe header";
    
    AXSampleNoSwipableHeaderView *headerView = [[AXSampleNoSwipableHeaderView alloc] init];
    self.headerView = headerView;
    
    AXSub1TableViewController *sub1ViewCon = [[AXSub1TableViewController alloc] init];
    AXSub2TableViewController *sub2ViewCon = [[AXSub2TableViewController alloc] init];
    
    NSArray *viewControllers = @[sub1ViewCon, sub2ViewCon];
    self.viewControllers = viewControllers;
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.headerView.minimumOfHeight = 64.0;
  self.headerView.maximumOfHeight =  220.0;
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

@end
