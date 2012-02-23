//
//  MSUDragView.h
//  test6
//
//  Created by John Bender on 2/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSUDragView : UIView <UIGestureRecognizerDelegate> {
   UIButton *button;
   BOOL allowTapTouches;
}

@property (nonatomic, assign) CGPoint touchOffset;

-(void) randomizeColor;

@end
