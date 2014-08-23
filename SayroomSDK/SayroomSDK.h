//
//  SayroomSDK.h
//  SayroomSDK
//
//  Created by Jovonni Pharr on 8/16/14.
//  Copyright (c) 2014 Clear I Media. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SRAudioRecorder.h"
#import "SRServerCalls.h"

@interface SayroomSDK : NSObject {
    
    NSString * status;
    
}

@property (readwrite, retain) NSString * status;

+ (id)sharedInstance;
- (id)initWithApplicationKey: (int)rmid APIKey: (NSString *)apikey;

//accessible methods
- (BOOL)recordAudio: (int)timeLimitOnRecording; //audio recorder
- (BOOL)stopRecordingOnImage: (int)biid; //svr calls
- (BOOL)stopRecordingOnTask: (int)btid; //svr calls
- (void)playCurrentAudioRecording;
- (float)getCurrentRecordingTime;


@end
