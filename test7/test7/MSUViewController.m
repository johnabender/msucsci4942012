//
//  MSUViewController.m
//  test7
//
//  Created by John Bender on 2/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MSUViewController.h"

@interface MSUViewController()
-(void) updateLabel;
@end

@implementation MSUViewController

@synthesize scrollView;
@synthesize viewToZoom;
@synthesize blueView;
@synthesize label;

- (void)viewDidLoad
{
    [super viewDidLoad];
   
   [self updateLabel];
   labelStartSize = blueView.frame.size;
   
   scrollView.delegate = self;
   scrollView.scrollEnabled = YES;
   scrollView.contentSize = viewToZoom.frame.size;
   scrollView.minimumZoomScale = 0.5;
   scrollView.maximumZoomScale = 2.;
   scrollView.bouncesZoom = YES;
   
   [scrollView.pinchGestureRecognizer addTarget:self action:@selector(handlePinch:)];
   //[scrollView.panGestureRecognizer addTarget:self action:@selector(handlePan:)];
}

-(void) handlePinch:(UIPinchGestureRecognizer*)pinch
{
   CGRect frame = blueView.frame;
   frame.size.width = labelStartSize.width/scrollView.zoomScale;
   frame.size.height = labelStartSize.height/scrollView.zoomScale;
   blueView.frame = frame;
}

-(void) handlePan:(UIPanGestureRecognizer*)pan
{
   static CGPoint lastTranslation = {0., 0.};
   CGPoint translation = [pan translationInView:scrollView];
   CGRect frame = label.frame;
   frame.origin.x -= translation.x - lastTranslation.x;
   frame.origin.y -= translation.y - lastTranslation.y;
   label.frame = frame;
   lastTranslation = translation;
}

-(UIView*) viewForZoomingInScrollView:(UIScrollView*)scrollView
{
   return viewToZoom;
}

-(void) updateLabel
{
   label.text = [NSString stringWithFormat:@"zoom %.2f %@%@\noffset %@", 
                 scrollView.zoomScale,
                 scrollView.zooming? @"Z" : @"",
                 scrollView.decelerating? @"D" : @"",
                 NSStringFromCGPoint( scrollView.contentOffset )];
}

-(void) scrollViewDidZoom:(UIScrollView*)scrollView
{
   [self updateLabel];
}

-(void) scrollViewDidScroll:(UIScrollView*)scrollView
{
   [self updateLabel];
}

@end
