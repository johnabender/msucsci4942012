//
//  MSUCyanView.m
//  MSUdemo1
//
//  Created by John Bender on 1/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MSUCyanView.h"

@implementation MSUCyanView

-(void) doLayout
{
   self.backgroundColor = [UIColor cyanColor];
   path = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
}

-(void) moveDown:(NSNumber*)amount
{
   CGRect frame = self.frame;
   frame.origin.y += [amount floatValue];
   self.frame = frame;

//   self.frame.origin.y += [amount floatValue];
}


-(void) drawRect:(CGRect)rect
{
   [super drawRect:rect];
   [[UIColor whiteColor] set];
   [path fill];
}

@end
