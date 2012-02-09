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

   /* drawing by hand
   path = [[UIBezierPath alloc] init];
   path.lineWidth = 10.;
   
   CGPoint pt = CGPointMake( 0., 0. );
   [path moveToPoint:pt];
   
   pt.x += 50.;
   pt.y += 100.;
   [path addLineToPoint:pt];
   
   pt.x += 50.;
   pt.y -= 100.;
   [path addLineToPoint:pt];
   
   pt.x += 50.;
   [path moveToPoint:pt];
   
   pt.x += 50.;
   pt.y += 100.;
   [path addLineToPoint:pt];
   
   pt.x += 50.;
   pt.y -= 100.;
   [path addLineToPoint:pt];
    */
}

-(void) moveDown:(NSNumber*)amount
{
   CGFloat static const speed = 100.;
   CGFloat duration = fabs( [amount floatValue] )/speed;
   NSLog( @"duration %f", duration );

   [UIView animateWithDuration:duration delay:0.
                       options:UIViewAnimationCurveLinear
                    animations:^{
//   self.frame.origin.y += [amount floatValue];
// don't we wish it was this easy!
      CGRect frame = self.frame;
      frame.origin.y += [amount floatValue];
      self.frame = frame;
   } completion:^(BOOL finished) {
      if( finished ) {
         drawColor = [UIColor greenColor];
         [self setNeedsDisplay];
      }
   }];

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
   CGFloat static const radius = 50.; // points
   CGFloat static const speed = 100.; // degrees/second
   CGFloat static const refreshRate = 1./60.; // seconds
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
