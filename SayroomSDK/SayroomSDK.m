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
    SRAudioRecorder *recordObject;
    
    
    
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
    
    
    //initiated, so init recording object, and startuprecordsession -- session should not have to restart everytime you want to record.
    recordObject = [[SRAudioRecorder alloc] init];
    
    //initiate startup record session
    [recordObject startUpRecorderSession];
    
    
    return self;
}


- (float)getCurrentRecordingTime{
    return [recordObject sendRecordingTime];
}


- (BOOL)recordAudio: (int)timeLimitOnRecording{

    //pass time in secons should record, 10 secs, 20 secs, 30 secs
    
    status = @"Recording";
    //recordObject = [[SRAudioRecorder alloc] init];
    
    //[recordObject startUpRecorderSession];
    
    [recordObject recordAudio:timeLimitOnRecording];
    
    
    return YES;
}

-(void)stopAlreadyRecording{
    [recordObject recordAudio:0];
}

- (BOOL)stopRecordingOnImage: (int)biid{
    
    status = @"Not Recording";
    
    [self stopAlreadyRecording];
    
    
    SRAudioRecorder *srar = [[SRAudioRecorder alloc] init];
        
    [srar stopRecordingOnImage:1 reactorMemberID:reactorMemberID APIKey:userAPIKey];
    
    return YES;

}


- (BOOL)stopRecordingOnTask: (int)btid{
    
    status = @"Not Recording";
    
    [self stopAlreadyRecording];
    
    SRAudioRecorder *srar = [[SRAudioRecorder alloc] init];
    
    [srar stopRecordingOnTask:1 reactorMemberID:reactorMemberID APIKey:userAPIKey];
    
    return YES;
    
}

-(void)playCurrentAudioRecording{
    [recordObject playAudio];
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
