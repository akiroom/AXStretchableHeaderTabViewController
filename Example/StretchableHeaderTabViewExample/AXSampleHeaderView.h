//
//  AXSampleHeaderView.h
//  StretchableHeaderTabViewExample
//
//  Created by Hiroki Akiyama on 2014/05/28.
//  Copyright (c) 2014年 Hiroki Akiyama. All rights reserved.
//

#import "AXStretchableHeaderView.h"

@interface AXSampleHeaderView : AXStretchableHeaderView <AXStretchableHeaderViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
