//
//  MSUOrangeView.m
//  MSUdemo1
//
//  Created by John Bender on 1/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MSUOrangeView.h"

@implementation MSUOrangeView

-(void) doLayout
{
   self.backgroundColor = [UIColor colorWithRed:1. green:.7 blue:0. alpha:1.];
}

+(id) viewWithFrame:(CGRect)frame
{
   MSUOrangeView *newView = [[MSUOrangeView alloc] initWithFrame:frame];
   return newView;
}

-(NSString*) description
{
   NSLog( @"self description" );
   return [super description];
}

- (id)initWithFrame:(CGRect)frame
{
   NSLog( @"initwithframe" );
    self = [super initWithFrame:frame];
    if (self) {
       [self doLayout];
    }
   NSLog( @"%@", [self description] );
    return self;
}

-(void) awakeFromNib
{
   NSLog( @"awakefromnib" );
   [super awakeFromNib];
   [self doLayout];
   NSLog( @"%@", self );
}


@end
