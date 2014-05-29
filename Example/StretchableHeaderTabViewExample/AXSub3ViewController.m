//
//  AXSub3ViewController.m
//  StretchableHeaderTabViewExample
//

#import "AXSub3ViewController.h"

@implementation AXSub3ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    _sampleLabel = [[UILabel alloc] init];
    
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Tab C" image:nil tag:0];
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  [self.view setBackgroundColor:[UIColor orangeColor]];
  
  [_sampleLabel setText:@"サンプルラベル"];
  [_sampleLabel sizeToFit];
  [_sampleLabel setFrame:_sampleLabel.bounds];
  [self.view addSubview:_sampleLabel];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

@end
