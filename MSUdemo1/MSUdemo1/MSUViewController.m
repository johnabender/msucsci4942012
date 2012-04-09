//
//  MSUViewController.m
//  MSUdemo1
//
//  Created by John Bender on 1/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MSUViewController.h"
#import "MSUOrangeView.h"
#import "MSUBlueView.h"
#import "MSUCyanView.h"

@implementation MSUViewController

@synthesize builtInOrangeView, builtInBlueView, builtInCyanView;


-(IBAction) blueGreenButtonPressed
{
   // turn all blue views green
   SEL ector = @selector(moveInCircle);
   NSNumber *downMove = [NSNumber numberWithFloat:-200.];
   for( UIView *view in msuViewArray ) {
//      if( [view class] == [MSUBlueView class] )
//      if( [view isKindOfClass:[MSUBlueView class]] )
      if( [view respondsToSelector:ector] )
//         [view performSelector:ector];
         [view performSelector:ector withObject:downMove];
   }
   /*
   for( int i = 0; i < [msuViewArray count]; i++ ) {
      UIView *view = [msuViewArray objectAtIndex:i];
   }
    */
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
   CGRect frame = CGRectMake( 0., 0., 100., 100. );
   MSUOrangeView *orangeView = [MSUOrangeView viewWithFrame:frame];
   [self.view addSubview:orangeView];

   frame.size.width = 100.;
   frame.size.height = 100.;
   frame.origin.x = 0.;
   frame.origin.y = self.view.frame.size.height - frame.size.height;
   MSUBlueView *blueView = [[MSUBlueView alloc] initWithFrame:frame];
   [self.view addSubview:blueView];
   
   msuViewArray = [NSArray arrayWithObjects:builtInOrangeView, builtInBlueView,
                   orangeView, blueView, builtInCyanView, nil];
   id ptr = nil;
   [ptr turnGreen];
}

@end
