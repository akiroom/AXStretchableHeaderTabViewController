//
//  AXSampleNoHeaderTabViewController.m
//  StretchableHeaderTabViewExample
//

#import "AXSampleNoHeaderTabViewController.h"
#import "AXSub1TableViewController.h"
#import "AXSub2TableViewController.h"
#import "AXSub3ViewController.h"

@interface AXSampleNoHeaderTabViewController ()

@end

@implementation AXSampleNoHeaderTabViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    self.title = @"Sample";
    
    AXSub1TableViewController *sub1ViewCon = [[AXSub1TableViewController alloc] init];
    AXSub2TableViewController *sub2ViewCon = [[AXSub2TableViewController alloc] init];
    AXSub3ViewController *sub3ViewCon = [[AXSub3ViewController alloc] init];
    
    NSArray *viewControllers = @[sub1ViewCon, sub2ViewCon, sub3ViewCon];
    self.viewControllers = viewControllers;
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
//  self.headerView.minimumOfHeight = 64.0;
//  self.headerView.maximumOfHeight =  220.0;
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
