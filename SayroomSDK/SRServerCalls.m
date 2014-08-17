//
//  SRServerCalls.m
//  SayroomSDK
//
//  Created by Jovonni Pharr on 8/16/14.
//  Copyright (c) 2014 Clear I Media. All rights reserved.
//

#import "SRServerCalls.h"

@interface SRServerCalls(){
    
    
    
    
}



@end

@implementation SRServerCalls



-(BOOL)verifyAPI: (int)reactorMemberID withApplicationKey: (NSString *)apiKey{
    
        //this gets called from sayroomSDK, upon
    
        NSLog(@"Verifying API");
    
        BOOL verficationResult = [self verifyUserAPIKey];
    
        if(verficationResult){
        
            NSLog(@"verified: true");
            
            return YES;
        
        }else{
        
            NSLog(@"verified: False");
            
            return NO;
        
        }
    
    NSLog(@"verified: Last Log");
    
    return YES;
    
}

-(BOOL)verifyUserAPIKey{
    
    //call server and get response
    
    NSLog(@"Verifying: Server Call");
    
    ///end call server and get response
    
    return YES;
    
}

-(BOOL)userUploadAudioForImage: (int)userID brandImageID: (int)biid userLocation: (NSString*)userCurrentLocation{
    
    return YES;
    
    
}

-(BOOL)userUploadAudioForTask: (int)userID brandTaskID: (int)btid userLocation: (NSString*)userCurrentLocation{
    
    
    return YES;
    
}




@end
