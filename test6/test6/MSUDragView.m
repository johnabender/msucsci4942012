//
//  MSUDragView.m
//  test6
//
//  Created by John Bender on 2/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MSUDragView.h"

static const CGFloat pickupSize = 1.25;
static const CGFloat pickupAnimationDuration = 0.25;
static const CGFloat pickupAlpha = 0.7;

@implementation MSUDragView

@synthesize touchOffset;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       allowTapTouches = TRUE;
       
       [self randomizeColor];
       
       button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
       button.frame = CGRectMake( 10., 10., 50., 37. );
       [button setTitle:@"Button" forState:UIControlStateNormal];
       [button addTarget:self action:@selector(makeSmall) forControlEvents:UIControlEventTouchUpInside];
       [self addSubview:button];
       
       UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
       tap.delegate = self;
       [self addGestureRecognizer:tap];
    }
    return self;
}


-(BOOL) gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer
       shouldReceiveTouch:(UITouch*)touch
{
   return allowTapTouches;
}

-(void) randomizeColor
{
   // random background color
   CGFloat r = (CGFloat)rand()/(CGFloat)RAND_MAX;
   CGFloat g = (CGFloat)rand()/(CGFloat)RAND_MAX;
   CGFloat b = (CGFloat)rand()/(CGFloat)RAND_MAX;
   self.backgroundColor = [UIColor colorWithRed:r green:g blue:b alpha:1.];
}

-(void) makeSmall
{
   CGRect frame = self.frame;
   if( frame.size.width > 100. )
   {
      frame.size.width = 0.75*frame.size.width;
      frame.size.height = 0.75*frame.size.height;
   }
   else
   {
      frame.size.width = 1.33*frame.size.width;
      frame.size.height = 1.33*frame.size.height;
   }
   self.frame = frame;
}


-(void) handleTap:(UITapGestureRecognizer*)tap
{
//   CGPoint location = [tap locationInView:button];
//   if( [button pointInside:location withEvent:nil] )
//   {
//      [self makeSmall];
//      return;
//   }
   
   [self randomizeColor];
}

-(UIView*) hitTest:(CGPoint)point withEvent:(UIEvent*)event
{
   UIView *view = [super hitTest:point withEvent:event];
   if( [view isKindOfClass:[UIControl class]] ) {
      allowTapTouches = FALSE;
   } else {
      allowTapTouches = TRUE;
   }
   return view;
}

/*
-(void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
   for( UITouch *touch in touches )
   {
      CGPoint location = [touch locationInView:self.superview];
      touchOffset = CGPointMake( self.center.x - location.x,
                                 self.center.y - location.y );
      
      [UIView animateWithDuration:pickupAnimationDuration animations:^
      {
         CGAffineTransform scale = CGAffineTransformMakeScale( pickupSize, pickupSize );
         CGAffineTransform rotate = CGAffineTransformMakeRotation( M_PI - 0.01 );
         self.transform = CGAffineTransformConcat( scale, rotate );
         self.alpha = pickupAlpha;
      }];

      [self.superview bringSubviewToFront:self];
   }
}

-(void) touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event
{
   for( UITouch *touch in touches )
   {
      CGPoint location = [touch locationInView:self.superview];
      CGPoint newCenter = CGPointMake( location.x + touchOffset.x,
                                       location.y + touchOffset.y );
      self.center = newCenter;
   }
}

-(void) touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event
{
   [UIView animateWithDuration:pickupAnimationDuration animations:^
    {
       self.transform = CGAffineTransformIdentity;
       self.alpha = 1.;
    }];
}

-(void) touchesCancelled:(NSSet*)touches withEvent:(UIEvent*)event
{
   [self touchesEnded:touches withEvent:event];
}
*/
@end
