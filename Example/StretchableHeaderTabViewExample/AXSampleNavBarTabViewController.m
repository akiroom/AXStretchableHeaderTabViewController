//
//  AXSampleNavBarTabViewController.m
//  StretchableHeaderTabViewExample
//
//  Created by Hiroki Akiyama on 2014/05/26.
//  Copyright (c) 2014年 Hiroki Akiyama. All rights reserved.
//

#import "AXSampleNavBarTabViewController.h"
#import "AXSub1TableViewController.h"
#import "AXSub2TableViewController.h"
#import "AXSub3ViewController.h"
#import "AXSampleHeaderView.h"

@interface AXSampleNavBarTabViewController ()

@end

@implementation AXSampleNavBarTabViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([AXSampleHeaderView class]) bundle:nil];
    AXSampleHeaderView *headerView = [[nib instantiateWithOwner:self options:nil] firstObject];
    headerView.textLabel.text = @"Italy Photo";
    headerView.detailTextLabel.text = @"The Duomo in Firenze";
    headerView.imageView.image = [UIImage imageNamed:@"sample-photo.jpg"];
    headerView.minimumOfHeight = 64.0;
    headerView.maximumOfHeight =  120.0;
    [headerView.backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    self.headerView = headerView;
    
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

- (void)back:(id)sender
{
  [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
