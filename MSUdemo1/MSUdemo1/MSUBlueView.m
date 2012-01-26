//
//  MSUBlueView.m
//  MSUdemo1
//
//  Created by John Bender on 1/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MSUBlueView.h"

@implementation MSUBlueView

-(void) doLayout
{
   self.backgroundColor = [UIColor colorWithRed:0.3 green:0.5 blue:1. alpha:1.];
}

- (id)initWithFrame:(CGRect)frame
{
   self = [super initWithFrame:frame];
   if (self) {
      [self doLayout];
   }
   return self;
}

-(void) awakeFromNib
{
   [super awakeFromNib];
   [self doLayout];
}


-(void) turnGreen
{
   self.backgroundColor = [UIColor greenColor];
}

@end
