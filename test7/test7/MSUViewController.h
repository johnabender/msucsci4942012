//
//  MSUViewController.h
//  test7
//
//  Created by John Bender on 2/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSUViewController : UIViewController <UIScrollViewDelegate> {
   CGSize labelStartSize;
}

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) IBOutlet UIView *viewToZoom;
@property (nonatomic, weak) IBOutlet UIView *blueView;
@property (nonatomic, weak) IBOutlet UILabel *label;

@end
