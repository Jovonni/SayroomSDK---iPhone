//
//  SRAudioRecorder.m
//  SayroomSDK
//
//  Created by Jovonni Pharr on 8/16/14.
//  Copyright (c) 2014 Clear I Media. All rights reserved.
//

#import "SRAudioRecorder.h"

@interface SRAudioRecorder(){
    AVAudioPlayer *audio;
    AVAudioRecorder *audioRecorder;
    NSTimer *recordingTimer;
}


@end

@implementation SRAudioRecorder

-(BOOL)recordAudio{
    
    //attempt to record
    
    
    
    //if not recording
    if (!audioRecorder.recording){
        //playButton.enabled = NO;
        NSLog(@"About to record");
        [audioRecorder record];
        
        //take out setting title, set title in timer
        //[recordingButton setTitle:@"Listening" forState:UIControlStateNormal];
        
        recordingTimer = [NSTimer scheduledTimerWithTimeInterval:.01
                                                          target:self
                                                        selector:@selector(isRecordingAtTenSeconds)
                                                        userInfo:nil repeats:YES
                          ];
        
    } else {
        //if recording
        //playButton.enabled = YES;
        NSLog(@"About to stop recording...");
        [audioRecorder stop];
        NSLog(@"Done recording");
        
        [recordingTimer invalidate];
        
    }
    
    
    //end attempt to record
    //
    return YES;
    
}

-(void)isRecordingAtTenSeconds{
    
    int recordingtime = audioRecorder.currentTime;
    //NSLog(@"recording: %i", recordingtime);
    
    
    
    
    int countdowntime = recordingtime - 10;
    int realcountdowntime = countdowntime * -1;
    
     //
    
    //count, and stop at 10
    if (recordingtime<10) {
        //NSLog(@"less than");
        NSLog(@"Listening  %i", realcountdowntime);
        
    } else if (recordingtime>=10){
        NSLog(@"Done");
        //stop recording
        [self recordAudio];
    }
    
}


-(BOOL)stopRecordingOnImage: (int)biid reactorMemberID: (int)rmid APIKey: (NSString *)apik{
    
    
    NSLog(@"stopping recording");
    
    return YES;
    
}


-(BOOL)stopRecordingOnTask: (int)btid reactorMemberID: (int)rmid APIKey: (NSString *)apik{
    
    NSLog(@"stopping recording");
    
    return YES;
    
}

@end
