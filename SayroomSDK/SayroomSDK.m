//
//  SayroomSDK.m
//  SayroomSDK
//
//  Created by Jovonni Pharr on 8/16/14.
//  Copyright (c) 2014 Clear I Media. All rights reserved.
//

#import "SayroomSDK.h"
#import "SRServerCalls.h"
#import "SRAudioRecorder.h"


@interface SayroomSDK() {
    
    NSString *userAPIKey;
    int reactorMemberID;
    
    
}


@end

@implementation SayroomSDK

@synthesize status;

static SayroomSDK *sharedInstance = nil;


-(id)initWithApplicationKey: (int)rmid APIKey: (NSString *)apikey{
    
    NSLog(@"status 0: %@", status);
    
    if(status == NULL){
        status = @"Not Verified";
    }
    
    NSLog(@"status 1: %@", status);

    
    self = [super init];
    
    //set both
    reactorMemberID = rmid;
    userAPIKey = apikey;
    
    if (self) {
        
        if([status isEqualToString:@"verified"]){
            
            //if verified already
        
        }else{
            
            SRServerCalls *srsc = [[SRServerCalls alloc] init];
            
            //call verfication api on server calls
            BOOL verified = [srsc verifyAPI:reactorMemberID withApplicationKey:userAPIKey];
            
            if(verified == YES){
                
                status = @"verified";
                
            }else{
                
                status = @"Not Verified";
                
            }
            
            // Work your initialising magic here as you normally would
        
        }
        
        
    }
    
    NSLog(@"status 2: %@", status);
    
    return self;
}


- (BOOL)recordAudio{
    
    
    
    SRAudioRecorder *srar = [[SRAudioRecorder alloc] init];
    
    [srar recordAudio];
    
    
    return YES;
}

- (BOOL)stopRecordingOnImage: (int)biid reactorMemberID: (int)rmid APIKey: (NSString *)apik{
    
    
    SRAudioRecorder *srar = [[SRAudioRecorder alloc] init];
    
    [srar stopRecordingOnImage:1 reactorMemberID:reactorMemberID APIKey:userAPIKey];
    
    
    return YES;

}

- (BOOL)stopRecordingOnTask: (int)btid reactorMemberID: (int)rmid APIKey: (NSString *)apik{
    
    
    SRAudioRecorder *srar = [[SRAudioRecorder alloc] init];
    
    [srar stopRecordingOnTask:1 reactorMemberID:reactorMemberID APIKey:userAPIKey];
    
    return YES;
    
}





// Get the shared instance and create it if necessary.
+(SayroomSDK *)sharedInstance{
    
    if (sharedInstance == nil) {
        sharedInstance = [[super allocWithZone:NULL] init];
    }
    
    
    return sharedInstance;
}


-(id)init{
    
    NSLog(@"Init was called too");
    
    return [self initWithApplicationKey: reactorMemberID APIKey:userAPIKey];
}




// Your dealloc method will never be called, as the singleton survives for the duration of your app.


// Equally, we don't want to generate multiple copies of the singleton.
- (id)copyWithZone:(NSZone *)zone {
    return self;
}




@end