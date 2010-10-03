//
//  UIView+Badge.m
//  MLTBadgedView
//
//  Created by Robert Rasmussen on 10/2/10.
//  Copyright 2010 Moonlight Tower. All rights reserved.
//

#import "UIView+Badge.h"

static int MLT_BADGE_TAG = 6546;

@implementation MLTBadgeView
@synthesize placement, badgeValue, font, badgeColor, textColor, outlineColor, outlineWidth, minimumDiameter, displayWhenZero;

-(void)dealloc {
  self.font = nil;
  self.badgeColor = nil;
  self.textColor = nil;
  self.outlineColor = nil;
  [super dealloc];
}

-(id)initWithFrame:(CGRect)frame {
  if(self = [super initWithFrame:frame]) {
    self.font = [UIFont boldSystemFontOfSize:13.0];
    self.badgeColor = [UIColor redColor];
    self.textColor = [UIColor whiteColor];
    self.outlineColor = [UIColor whiteColor];
    self.outlineWidth = 2.0;
    self.backgroundColor = [UIColor clearColor];
    self.minimumDiameter = 20.0;
    self.placement = kBadgePlacementUpperBest;
    self.opaque = YES;
  }
  return self;
}
-(void)setBadgeValue:(NSInteger)value {
  if(value != 0 || self.displayWhenZero) {
    CGSize numberSize = [[NSString stringWithFormat:@"%d", value] sizeWithFont:self.font];
    float diameterForNumber = numberSize.width > numberSize.height ? numberSize.width : numberSize.height;
    float diameter = diameterForNumber + 6 + (self.outlineWidth * 2);
    if(diameter < self.minimumDiameter) {
      diameter = self.minimumDiameter;
    }
    
    //We know the size of the badge circle. If no explicit placement for the badge has been set, we'll
    //see if it works on the right side first.
    CGRect superviewFrame = self.superview.frame;
    if(self.placement == kBadgePlacementUpperBest) {
      CGPoint rightMostInWindow = [self.superview convertPoint:CGPointMake(superviewFrame.origin.x + superviewFrame.size.width + (diameter / 2.0), -(diameter / 2.0)) fromView:nil];
      if(rightMostInWindow.x > [[UIScreen mainScreen] applicationFrame].size.width) {
        self.placement = kBadgePlacementUpperLeft; 
      } else {
        self.placement = kBadgePlacementUpperRight;
      }
    }
    self.bounds = CGRectMake(0, 0, diameter, diameter);
    self.center = (self.placement == kBadgePlacementUpperLeft) ? CGPointMake(0, 0) : CGPointMake(superviewFrame.size.width, 0); 
  } else {
    self.frame = CGRectZero;
  }
  badgeValue = value;
  [self setNeedsDisplay];
}
-(void)setMinimumDiameter:(float)f {
  minimumDiameter = f;
  self.bounds = CGRectMake(0, 0, f, f); 
}

-(void)drawRect:(CGRect)rect {
  if(self.badgeValue != 0 || self.displayWhenZero) {
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.outlineColor set];
    CGContextFillEllipseInRect(context, CGRectInset(rect, 1, 1));
    [self.badgeColor set];
    CGContextFillEllipseInRect(context, CGRectInset(rect, self.outlineWidth + 1, self.outlineWidth + 1));
    [self.textColor set];
    CGSize numberSize = [[NSString stringWithFormat:@"%d", self.badgeValue] sizeWithFont:self.font];
    [[NSString stringWithFormat:@"%d", self.badgeValue] drawInRect:CGRectMake(self.outlineWidth + 3, (rect.size.height / 2.0) - (numberSize.height / 2.0), rect.size.width - (self.outlineWidth * 2) - 6, numberSize.height) withFont:self.font lineBreakMode:UILineBreakModeClip alignment:UITextAlignmentCenter];
  } 
}

@end


@implementation UIView(Badged)

-(MLTBadgeView *)badge {
  UIView *existingView = [self viewWithTag:MLT_BADGE_TAG];
  if(existingView) {
    if(![existingView isKindOfClass:[MLTBadgeView class]]) {
      NSLog(@"Unexpected view of class %@ found with badge tag.");
      return nil;
    } else {
      return (MLTBadgeView *)existingView;
    }
  }
  MLTBadgeView *badgeView = [[MLTBadgeView alloc]initWithFrame:CGRectZero];
  badgeView.tag = MLT_BADGE_TAG;
  [self addSubview:badgeView];
  return [badgeView autorelease];
}

@end
