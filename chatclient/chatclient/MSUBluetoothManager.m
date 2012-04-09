//
//  MSUBluetoothManager.m
//  chatclient
//
//  Created by John Bender on 4/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MSUBluetoothManager.h"

@implementation MSUBluetoothManager

@synthesize peerName = _peerName;

static MSUBluetoothManager *sharedInstance = nil;

+(MSUBluetoothManager*) instance
{
   if( sharedInstance == nil )
      sharedInstance = [[MSUBluetoothManager alloc] init];
   return sharedInstance;
}


-(id) init
{
   self = [super init];
   if( self ) {
      session = [[GKSession alloc] initWithSessionID:@"msudemochatclientsessionid"
                                         displayName:[[UIDevice currentDevice] name]
                                         sessionMode:GKSessionModePeer];
      session.delegate = self;
      _peerName = nil;
      
      connectionPicker = [[GKPeerPickerController alloc] init];
      connectionPicker.delegate = self;
      [connectionPicker show];
   }
   return self;
}


+(BOOL) hasConnection
{
   return (sharedInstance != nil && sharedInstance.peerName != nil);
}


-(void) sendMessage:(NSString*)message
{
   NSData *encodedData = [NSKeyedArchiver archivedDataWithRootObject:message];
   [session sendDataToAllPeers:encodedData withDataMode:GKSendDataReliable error:nil];
}


-(void) receiveData:(NSData*)data
           fromPeer:(NSString*)peer
          inSession:(GKSession*)theSession
            context:(void*)context
{
   NSString *message = [NSKeyedUnarchiver unarchiveObjectWithData:data];
   [[NSNotificationCenter defaultCenter] postNotificationName:@"bluetoothDataReceived" object:message];
}


#pragma  mark - Peer picker delegate

-(GKSession*) peerPickerController:(GKPeerPickerController*)picker
          sessionForConnectionType:(GKPeerPickerConnectionType)type
{
   return session;
}


-(void) peerPickerController:(GKPeerPickerController*)picker
              didConnectPeer:(NSString*)newPeer
                   toSession:(GKSession*)session
{
   [picker dismiss];
}


-(void) peerPickerControllerDidCancel:(GKPeerPickerController*)picker
{
}


#pragma mark - Session delegate

-(void) session:(GKSession*)theSession 
           peer:(NSString*)thePeer 
 didChangeState:(GKPeerConnectionState)state
{
   if( state == GKPeerStateConnected )
   {
      peerId = thePeer;
      [session setDataReceiveHandler:self withContext:nil];
      
      NSString *handshake = [[UIDevice currentDevice] name];
      [self sendMessage:handshake];
   }
   else if( state == GKPeerStateDisconnected )
   {
   }
}

@end



