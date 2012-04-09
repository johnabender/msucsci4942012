//
//  MSUBluetoothManager.h
//  chatclient
//
//  Created by John Bender on 4/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

@interface MSUBluetoothManager : NSObject
<GKSessionDelegate, GKPeerPickerControllerDelegate>
{
   GKSession *session;
   NSString *peerId;
   NSString *_peerName;
   
   GKPeerPickerController *connectionPicker;
}

@property (nonatomic, readonly) NSString *peerName;

+(MSUBluetoothManager*) instance;
+(BOOL) hasConnection;

-(void) sendMessage:(NSString*)message;

@end
