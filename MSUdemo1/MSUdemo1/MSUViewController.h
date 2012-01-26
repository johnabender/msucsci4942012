//
//  MSUViewController.h
//  MSUdemo1
//
//  Created by John Bender on 1/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MSUOrangeView;
@class MSUBlueView;
@class MSUCyanView;

@interface MSUViewController : UIViewController {
   NSArray *msuViewArray;
}

@property (nonatomic, strong) IBOutlet MSUOrangeView *builtInOrangeView;
@property (nonatomic, strong) IBOutlet MSUBlueView *builtInBlueView;
@property (nonatomic, strong) IBOutlet MSUCyanView *builtInCyanView;

-(IBAction) blueGreenButtonPressed;

@end
