//
//  MLTBadgedViewViewController.m
//  MLTBadgedView
//
//  Created by Robert Rasmussen on 10/2/10.
//  Copyright 2010 Moonlight Tower. All rights reserved.
//

#import "MLTBadgedViewViewController.h"
#import "UIView+Badge.h"

@implementation MLTBadgedViewViewController

//Examples of how to use UIView+Badge
- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor lightGrayColor];
  
  // Button placed flush right will be badged on the left by default
  UIButton *b = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  b.frame = CGRectMake(120,50,200,50);
  [b setTitle:@"Auto Badge Placement" forState:UIControlStateNormal];
  b.enabled = YES;
  b.badge.outlineWidth = 2.0;
  b.badge.badgeValue = 47;
  b.badge.badgeColor = [UIColor orangeColor];
  [self.view addSubview:b];
  
  // Here we force the badge to the left side, and make the outline wide
  UIButton *b2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  b2.frame = CGRectMake(100,120,200,50);
  [b2 setTitle:@"Wide Badge Outline" forState:UIControlStateNormal];
  b2.badge.outlineWidth = 5.0;
  b2.badge.placement = kBadgePlacementUpperLeft;
  b2.badge.badgeValue = 47;
  [self.view addSubview:b2];
  
  // Huge badge with custom colors
  UIButton *b3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  b3.frame = CGRectMake(100, 200, 200, 50);
  [b3 setTitle:@"Ugly Badge Support" forState:UIControlStateNormal];
  b3.badge.outlineWidth = 5.0;
  b3.badge.outlineColor = [UIColor blackColor];
  b3.badge.badgeColor = [UIColor brownColor];
  b3.badge.textColor = [UIColor purpleColor];
  b3.badge.minimumDiameter = 60.0;
  b3.badge.font = [UIFont boldSystemFontOfSize:20];
  b3.badge.badgeValue = 50;
  [self.view addSubview:b3];
  
  // Auto placement will badge to the upper right if possible
  UIButton *b4 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  b4.frame = CGRectMake(80,300,200,50);
  [b4 setTitle:@"Auto Badge Placement" forState:UIControlStateNormal];
  b4.enabled = YES;
  b4.badge.outlineWidth = 1.0;
  b4.badge.outlineColor = [UIColor redColor];
  b4.badge.badgeValue = 3;
  b4.badge.badgeColor = [UIColor darkGrayColor];
  [self.view addSubview:b4];
  
  // Any view can be badged
  UIView *b5 = [[UIView alloc] initWithFrame:CGRectMake(80, 370, 200, 40)];
  b5.backgroundColor = [UIColor blackColor];
  UILabel *b5l = [[UILabel alloc]init];
  b5l.font = [UIFont boldSystemFontOfSize:15.0];
  b5l.text = @"Badged UIView";
  [b5l sizeToFit];
  b5l.backgroundColor = [UIColor redColor];
  b5l.textColor = [UIColor whiteColor];
  b5l.center = CGPointMake(100, 20);
  [b5 addSubview:[b5l autorelease]];
  
  b5.badge.badgeValue = 44;
  [self.view addSubview:[b5 autorelease]];
}

@end
