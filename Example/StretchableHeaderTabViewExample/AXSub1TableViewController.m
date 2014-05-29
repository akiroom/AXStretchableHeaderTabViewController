//
//  AXSub1TableViewController.m
//  StretchableHeaderTabViewExample
//

#import "AXSub1TableViewController.h"
#import "AXEmptyViewController.h"

@interface AXSub1TableViewController ()

@end

@implementation AXSub1TableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
  self = [super initWithStyle:UITableViewStylePlain];
  if (self) {
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Tab A" image:nil tag:0];
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"my-cell"];
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

@end
