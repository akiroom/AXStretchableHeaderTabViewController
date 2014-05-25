//
//  AXSampleListViewController.m
//  StretchableHeaderTabViewExample
//

#import "AXSampleListViewController.h"
#import "AXSampleTabViewController.h"

@interface AXSampleListViewController ()

@end

@implementation AXSampleListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
  self = [super initWithStyle:style];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self setTitle:@"Stretchable header tab view"];
  
  [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"list-cell"];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"list-cell" forIndexPath:indexPath];
  [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
  [cell.textLabel setText:
   @[@"Sample",
     @"Sample with navigation bar"][indexPath.row]];
  return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  AXSampleTabViewController *tabViewCon = [[AXSampleTabViewController alloc] init];
  [self.navigationController pushViewController:tabViewCon animated:YES];
}

@end
