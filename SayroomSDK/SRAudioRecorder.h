//
//  SRAudioRecorder.h
//  SayroomSDK
//
//  Created by Jovonni Pharr on 8/16/14.
//  Copyright (c) 2014 Clear I Media. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "SRServerCalls.h"

@interface SRAudioRecorder : NSObject <AVAudioRecorderDelegate, AVAudioPlayerDelegate>{
    
    
    
}



-(void)startUpRecorderSession;
-(BOOL)recordAudio;
-(BOOL)stopRecordingOnImage: (int)biid reactorMemberID: (int)rmid APIKey: (NSString *)apik;
-(BOOL)stopRecordingOnTask: (int)btid reactorMemberID: (int)rmid APIKey: (NSString *)apik;
-(void)playAudio;
-(float)sendRecordingTime;


@end
