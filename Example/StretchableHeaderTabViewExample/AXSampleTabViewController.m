//
//  AXSampleTabViewController.m
//  StretchableHeaderTabViewExample
//

#import "AXSampleTabViewController.h"
#import "AXSub1TableViewController.h"
#import "AXSub2TableViewController.h"
#import "AXSub3ViewController.h"
#import "AXSampleHeaderView.h"
@interface AXSampleTabViewController ()

@end

@implementation AXSampleTabViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
    AXSampleHeaderView *headerView = [[AXSampleHeaderView alloc] init];
    headerView.textLabel.text = @"Italy Photo";
    headerView.detailTextLabel.text = @"The Duomo in Firenze";
    headerView.imageView.image = [UIImage imageNamed:@"sample-photo.jpg"];
    headerView.minimumOfHeight = 64.0;
    headerView.maximumOfHeight =  240.0;
    
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
  
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  
}

@end
