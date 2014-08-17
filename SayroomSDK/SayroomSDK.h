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

@interface SayroomSDK : SRAudioRecorder {
    
    NSString * status;
    
}

@property (readwrite, retain) NSString * status;

+ (id)sharedInstance;
- (id)initWithApplicationKey: (int)rmid APIKey: (NSString *)apikey;

//accessible methods
- (BOOL)recordAudio; //audio recorder
- (BOOL)stopRecordingOnImage: (int)biid reactorMemberID: (int)rmid APIKey: (NSString *)apik; //svr calls
- (BOOL)stopRecordingOnTask: (int)btid reactorMemberID: (int)rmid APIKey: (NSString *)apik; //svr calls




@end
