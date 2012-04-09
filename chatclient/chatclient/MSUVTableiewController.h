//
//  MSUVTableiewController.h
//  chatclient
//
//  Created by John Bender on 4/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSUVTableiewController : UITableViewController
<UITextFieldDelegate>
{
   NSMutableArray *messageArray;
   
   IBOutlet UITextField *textField;
}

@end
