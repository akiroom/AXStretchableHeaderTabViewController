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
    AXSampleHeaderView *headerView = [[AXSampleHeaderView alloc] init];
    headerView.headerDelegate = headerView;
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
  
  self.headerView.minimumOfHeight = 64.0;
  self.headerView.maximumOfHeight =  180.0;

//  AXSampleHeaderViewController *headerViewController = (id)self.headerViewController;
//  headerView.textLabel.text = @"Italy Photo";
//  headerView.detailTextLabel.text = @"The Duomo in Firenze";
//  headerViewController.imageView.image = [UIImage imageNamed:@"sample-photo.jpg"];
//  headerViewController.imageView.clipsToBounds = YES;
//  [headerView.backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
//  AXSampleHeaderView *sample = (id)self.headerView;
//  [self.headerView setNeedsLayout];
//  [self.headerView setNeedsUpdateConstraints];
//  [self.headerView removeConstraints:self.headerView.constraints];
//  [sample.imageView setAlpha:0.5];
//  [sample.imageView setFrame:(CGRect){64, 64, 40.0, 40.0}];
//  UIView *test = [[UIView alloc] initWithFrame:(CGRect){120, 120, 30, 30}];
//  test.backgroundColor = [UIColor cyanColor];
//  [sample addSubview:test];
//  NSLog(@"%@", sample.imageView);
//  //  [self.headerView layoutSubviews];
//  NSLog(@"ここから");
//  NSLog(@"%@", NSStringFromCGRect(self.headerView.frame));
//  [self.headerView.constraints enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//    NSLog(@"%@", obj);
//  }];
//  NSLog(@"ここまで");
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
