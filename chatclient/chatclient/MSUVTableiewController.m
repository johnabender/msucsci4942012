//
//  MSUVTableiewController.m
//  chatclient
//
//  Created by John Bender on 4/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MSUVTableiewController.h"
#import "MSUBluetoothManager.h"

@interface MSUVTableiewController ()
@end

@implementation MSUVTableiewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

   [MSUBluetoothManager instance];
   
   [[NSNotificationCenter defaultCenter] addObserver:self
                                            selector:@selector(bluetoothDataReceived:)
                                                name:@"bluetoothDataReceived"
                                              object:nil];
   messageArray = [NSMutableArray array];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
   [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
   return [messageArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
   if( cell == nil )
      cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];

   cell.textLabel.text = [messageArray objectAtIndex:indexPath.row];
    
    return cell;
}


#pragma mark - Text field delegate

-(BOOL) textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
   return YES;
}

-(BOOL) textFieldShouldReturn:(UITextField *)theField
{
   NSLog( @"text field returning" );
   [theField resignFirstResponder];
   [[MSUBluetoothManager instance] sendMessage:theField.text];
   return YES;
}



-(void) bluetoothDataReceived:(NSNotification*)note
{
   [messageArray addObject:[note object]];
   [self.tableView reloadData];
}

@end
