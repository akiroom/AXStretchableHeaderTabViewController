//
//  AXSampleNoBounceTabViewController.m
//  StretchableHeaderTabViewExample
//

#import "AXSampleNoBounceTabViewController.h"
#import "AXSub1TableViewController.h"
#import "AXSub2TableViewController.h"
#import "AXSampleSwipableHeaderView.h"

@interface AXSampleNoBounceTabViewController ()

@end

@implementation AXSampleNoBounceTabViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    self.title = @"No Bounce";
    
    AXSampleSwipableHeaderView *headerView = [[AXSampleSwipableHeaderView alloc] init];
    
    // THIS IS THE POINT IN THIS FILE.
    headerView.bounces = NO;
    // THIS IS THE POINT IN THIS FILE.
    
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
  
  AXSampleSwipableHeaderView *headerView = (id)self.headerView;
  headerView.textLabel.text = @"The Duomo in Firenze";
  headerView.imageView.image = [UIImage imageNamed:@"sample-photo.jpg"];
  [headerView.backButton setTitle:@"back" forState:UIControlStateNormal];
  [headerView.backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

- (void)back:(id)sender
{
  [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
