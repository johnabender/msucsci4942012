//
//  MSUCyanView.h
//  MSUdemo1
//
//  Created by John Bender on 1/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MSUBlueView.h"

@interface MSUCyanView : MSUBlueView {
   UIBezierPath *path;
   UIColor *drawColor;
}

-(void) moveDown:(NSNumber*)amount;
-(void) moveInCircle;

@end
