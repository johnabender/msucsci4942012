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
   drawColor = [UIColor blueColor];
}

-(void) moveDown:(NSNumber*)amount
{
   CGFloat static const speed = 100.;
   CGFloat duration = fabs( [amount floatValue] )/speed;
   NSLog( @"duration %f", duration );

   [UIView animateWithDuration:duration delay:0.
                       options:UIViewAnimationCurveLinear
                    animations:^{
      CGRect frame = self.frame;
      frame.origin.y += [amount floatValue];
      self.frame = frame;
   } completion:^(BOOL finished) {
      if( finished ) {
         drawColor = [UIColor greenColor];
         [self setNeedsDisplay];
      }
   }];

//   self.frame.origin.y += [amount floatValue];
}


-(void) updateMove:(NSMutableDictionary*)conditions
{
   // unpack dictionary
   CGFloat curAngle = [[conditions objectForKey:@"curAngle"] floatValue];
   CGPoint center = [[conditions objectForKey:@"center"] CGPointValue];
   CGFloat refreshRate = [[conditions objectForKey:@"refreshRate"] floatValue];
   CGFloat dtheta = [[conditions objectForKey:@"dtheta"] floatValue];
   CGFloat radius = [[conditions objectForKey:@"radius"] floatValue];
   
   // calculate
   CGFloat deltaTheta = dtheta*refreshRate*M_PI/180.;
   CGFloat newAngle = MIN( curAngle + deltaTheta, 2.*M_PI );
   
   // move
   CGRect frame = self.frame;
   frame.origin.x = center.x + radius*sin( newAngle );
   frame.origin.y = center.y + radius*cos( newAngle );
   self.frame = frame;
   
   // recurse
   if( newAngle < 2.*M_PI ) {
      [conditions setObject:[NSNumber numberWithFloat:newAngle] forKey:@"curAngle"];
      [self performSelector:@selector(updateMove:) withObject:conditions afterDelay:refreshRate];
   }
}


-(void) moveInCircle
{
   CGFloat radius = 50.; // points
   CGFloat speed = 100.; // degrees/second
   CGFloat refreshRate = 1./60.; // seconds
   CGPoint center = CGPointMake( self.frame.origin.x,
                                 self.frame.origin.y - radius );
   NSMutableDictionary *initialConditions = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                             [NSValue valueWithCGPoint:center], @"center",
                                             [NSNumber numberWithFloat:0.], @"curAngle",
                                             [NSNumber numberWithFloat:speed], @"dtheta",
                                             [NSNumber numberWithFloat:radius], @"radius",
                                             [NSNumber numberWithFloat:refreshRate], @"refreshRate",
                                              nil];
   [self updateMove:initialConditions];
}


-(void) drawRect:(CGRect)rect
{
   [super drawRect:rect];
   [drawColor set];
   [path fill];
}

@end
