//
//  AXSub4ViewController.m
//  StretchableHeaderTabViewExample
//

#import "AXSub4ViewController.h"
#import "AXEmptyViewController.h"

@interface AXSub4ViewController ()

@end

@implementation AXSub4ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Tab D" image:nil tag:0];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
  }
  return self;
}

- (void)loadView
{
  [super loadView];
  
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.view.backgroundColor = [UIColor redColor];
  
  [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"my-cell"];
  [_tableView setDataSource:self];
  [_tableView setDelegate:self];
  [_tableView setFrame:self.view.bounds];
  [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  // Return the number of sections.
  return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  // Return the number of rows in the section.
  return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"my-cell" forIndexPath:indexPath];
  [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
  [cell.textLabel setText:[NSString stringWithFormat:@"(%ld, %ld)", indexPath.section, indexPath.row]];
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  AXEmptyViewController *nextViewCon = [[AXEmptyViewController alloc] init];
  [self.navigationController pushViewController:nextViewCon animated:YES];
}

#pragma mark - Stretchable Sub View Controller View Source

- (UIScrollView *)stretchableSubViewInSubViewController:(id)subViewController
{
  NSLog(@"%@", NSStringFromCGRect(self.view.frame));
  NSLog(@"%@", NSStringFromCGRect(_tableView.frame));
  return _tableView;
}

@end
